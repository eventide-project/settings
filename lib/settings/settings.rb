require 'json'
require 'confstruct'

class Settings
  Logger.register self

  attr_reader :data
  attr_reader :pathname

  dependency :logger

  def initialize(data, pathname=nil)
    @data = data
    @pathname = pathname
  end

  def self.build(pathname=nil)
    pathname ||= File::Defaults.name

    pathname = File.canonical(pathname)

    File.validate(pathname)

    file_data = read_file(pathname)

    data = Confstruct::Configuration.new(file_data)

    instance = new data, pathname

    Logger.configure instance

    instance
  end

  def self.read_file(pathname)
    file_data = ::File.open(pathname)

    JSON.load file_data
  end

  def override(override_data)
    data.push!(override_data)
  end

  def reset
    data.pop!
  end

  # def set(receiver, *keys)
  #   keys = data.keys if keys.empty?

  #   keys.flatten! if keys.is_a? Array

  #   keys.each {|k| data[k] ? assign_value(receiver, k, data[k]) : nil }
  # end

  # def set(receiver, *keys)
  def set(receiver, *namespace, attribute: nil)
    logger.trace "Setting #{receiver} (#{digest(namespace, attribute)})"
    unless attribute.nil?
      value = set_one(receiver, attribute, namespace)
    else
      receiver = set_all(receiver, namespace)
    end
    value || receiver
  end

  def set_one(receiver, attribute, namespace)
    attribute = attribute.to_s if attribute.is_a? Symbol

    full_namespace = namespace.dup
    full_namespace << attribute

    value = get(full_namespace)

    assign_value(receiver, attribute, value)

    log_value = value
    log_value = log_value.to_h if log_value.respond_to? :to_h

    logger.info "Set #{receiver} #{attribute} to #{log_value}"

    value
  end

  def set_all(receiver, namespace)
    data.each {|k, v| assign_value(receiver, k, v) }
  end

  def assign_value(receiver, attribute, value)
    attribute = attribute.to_sym # aren't they already symbols if they come from confstruct
    Settings::Setting::Assignment.assign(receiver, attribute, value)
  end

  def get(*namespace)
    namespace.flatten!
    logger.trace "Getting #{namespace}"

    # namespace = namespace.join '.'

    value = namespace.inject(data) {|memo, k| memo ? memo[k] : nil }

    log_data = value
    log_data = log_data.to_h if log_data.respond_to? :to_h
    logger.data "#{namespace}: #{log_data}"

    logger.debug "Got #{namespace}"

    value
  end

  def digest(namespace, attribute)
    content = []
    content << "Namespace: #{namespace.join ', '}" unless namespace.empty?
    content << "Attribute: #{attribute}" if attribute
    str = content.join ', '
    str = 'Namespace and Attribute are not specified' if str.empty?
    str
  end

  module File
    def self.canonical(pathname)
      if ::File.extname(pathname) == ""
        pathname = (Pathname.new(pathname) + Defaults.name).to_s
      end

      if ::File.dirname(pathname) == "."
        pathname = (Pathname.new(Directory::Defaults.pathname) + pathname).to_s
      end

      pathname
    end

    def self.validate(pathname)
      pathname = Pathname.new pathname

      unless pathname.file?
        raise(Errno::ENOENT, "Settings cannot be read from #{pathname}. The file doesn't exist.")
      end
    end

    module Defaults
      def self.name
        'settings.json'
      end
    end
  end

  module Directory
    module Defaults
      def self.pathname
        Dir.pwd
      end
    end
  end
end
