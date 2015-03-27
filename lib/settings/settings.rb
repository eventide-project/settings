class Settings
  attr_reader :data
  attr_reader :pathname

  dependency :logger

  def initialize(data, pathname=nil)
    @data = data
    @pathname = pathname
  end

  def self.logger
    @logger ||= Logger.get self
  end

  def self.build(data_source=nil)
    raw_data = nil
    if data_source.is_a? Hash
      logger.trace "Building based on a hash"
      raw_data = data_source
      logger.data raw_data
    else
      logger.trace "Building based on a pathname"
      pathname = data_source
      pathname ||= File::Defaults.filename
      pathname = File.canonical(pathname)
      File.validate(pathname)
      raw_data = read_file(pathname)
    end

    data = confstruct(raw_data)

    instance = new data, pathname

    Logger.configure instance

    logger.debug "Built"

    instance
  end

  def self.confstruct(raw_data)
    logger.trace "Building confstruct"
    Confstruct::Configuration.new(raw_data).tap do
      logger.debug "Built confstruct"
    end
  end

  def self.read_file(pathname)
    logger = Logger.get self

    logger.trace "Reading file: #{pathname}"
    File.read(pathname).tap do
      logger.debug "Read file: #{pathname}"
    end
  end

  def override(override_data)
    logger.trace "Overriding settings data"
    res = data.push!(override_data)
    logger.debug "Overrode settings data"
    logger.data "Override data #{override_data}"
    res
  end

  def reset
    logger.trace "Resetting overridden settings data"
    res = data.pop!
    logger.debug "Reset overridden settings data"
    res
  end

  def set(receiver, *namespace, attribute: nil, strict: true)
    logger.trace "Setting #{receiver} (#{digest(namespace, attribute, strict)})"
    unless attribute.nil?
      value = set_attribute(receiver, attribute, namespace, strict)
    else
      receiver = set_object(receiver, namespace, strict)
    end
    value || receiver
  end

  def set_attribute(receiver, attribute, namespace, strict)
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

  def set_object(receiver, namespace, strict)
    logger.trace "Setting #{receiver} object (#{digest(namespace, nil, strict)})"
    data = get(namespace)
    data.each {|attribute, value| Settings::Setting::Assignment::Object.assign(receiver, attribute.to_sym, value, strict) }
    logger.info "Set #{receiver} object (#{digest(namespace, nil, strict)})"
    receiver
  end

  def assign_value(receiver, attribute, value, strict=false)
    Settings::Setting::Assignment.assign(receiver, attribute, value, strict)
  end

  def get(*namespace)
    namespace.flatten!
    logger.trace "Getting #{namespace}"

    string_keys = namespace.map { |n| n.is_a?(String) ? n : n.to_s }

    value = string_keys.inject(data) {|memo, k| memo ? memo[k] : nil }

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
end
