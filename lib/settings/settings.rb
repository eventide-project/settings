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

  def self.build(data_source=nil)
    raw_data = nil
    if data_source.is_a? Hash
      raw_data = data_source
    else
      pathname ||= File::Defaults.name
      pathname = File.canonical(pathname)
      File.validate(pathname)
      raw_data = read_file(pathname)
    end

    data = Confstruct::Configuration.new(raw_data)

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

  def set(receiver, *namespace, attribute: nil, strict: true)
    logger.trace "Setting #{receiver} (#{digest(namespace, attribute, strict)})"
    unless attribute.nil?
      value = set_one(receiver, attribute, namespace, strict)
    else
      receiver = set_all(receiver, namespace, strict)
    end
    value || receiver
  end

  def set_one(receiver, attribute, namespace, strict)
    logger.trace "Setting #{receiver} attribute (#{digest(namespace, attribute, strict)})"

    attribute = attribute.to_s if attribute.is_a? Symbol

    attribute_namespace = namespace.dup
    attribute_namespace << attribute

    value = get(attribute_namespace)

    if value.nil?
      msg = "#{attribute_namespace} not found in the data"
      logger.error msg
      raise msg
    end

    Settings::Setting::Assignment::Attribute.assign(receiver, attribute.to_sym, value, strict)

    log_value = value
    log_value = log_value.to_h if log_value.respond_to? :to_h

    logger.info "Set #{receiver} #{attribute} to #{log_value}"

    value
  end

  def set_all(receiver, namespace, strict)
    logger.trace "Setting #{receiver} object (#{digest(namespace, nil, strict)})"
    data = get(namespace)
    data.each {|attribute, value| Settings::Setting::Assignment::Object.assign(receiver, attribute.to_sym, value, strict) }
    logger.info "Set #{receiver} object (#{digest(namespace, nil, strict)})"
    receiver
  end

  def assign_value(receiver, attribute, value, strict=false)
    attribute = attribute.to_sym # aren't they already symbols if they come from confstruct
    Settings::Setting::Assignment.assign(receiver, attribute, value, strict)
  end

  def get(*namespace)
    namespace.flatten!
    logger.trace "Getting #{namespace}"

    value = namespace.inject(data) {|memo, k| memo ? memo[k] : nil }

    log_data = value
    log_data = log_data.to_h if log_data.respond_to? :to_h
    logger.data "#{namespace}: #{log_data}"

    logger.debug "Got #{namespace}"

    value
  end

  def digest(namespace, attribute, strict)
    content = []
    content << "Namespace: #{namespace.join ', '}" unless namespace.empty?
    content << "Attribute: #{attribute}" if attribute
    strict = "<not set>" if strict.nil?
    content << "Strict: #{strict}"
    content.join ', '
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
        raise "Settings cannot be read from #{pathname}. The file doesn't exist."
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
