class Settings
  class Error < RuntimeError; end

  attr_reader :data
  attr_reader :pathname

  dependency :logger, ::Telemetry::Logger

  def initialize(data, pathname=nil)
    @data = data
    @pathname = pathname
  end

  def self.logger
    # @logger ||= ::Telemetry::Logger.get self
    @logger ||= SubstAttr::Substitute.build(::Telemetry::Logger)
  end

  def self.build(source=nil)
    source ||= implementer_source

    data_source = DataSource::Build.(source)

    data = data_source.get_data

    instance = new data

    # ::Telemetry::Logger.configure instance

    logger.opt_debug "Built"

    instance
  end

  def self.implementer_source
    logger.opt_trace "Getting data source from the implementer"

    unless self.respond_to? :data_source
      logger.opt_trace "Implementer doesn't provide a data_source"
      return nil
    end

    self.data_source.tap do |data_source|
      logger.opt_trace "Got data source from the implementer (#{data_source})"
    end
  end

  def override(override_data)
    logger.opt_trace "Overriding settings data"
    res = data.push!(override_data)
    logger.opt_debug "Overrode settings data"
    logger.opt_data "Override data #{override_data}"
    res
  end

  def reset
    logger.opt_trace "Resetting overridden settings data"
    res = data.pop!
    logger.opt_debug "Reset overridden settings data"
    res
  end

  def set(receiver, *namespace, attribute: nil, strict: true)
    logger.opt_trace "Setting #{receiver} (#{digest(namespace, attribute, strict)})"
    unless attribute.nil?
      value = set_attribute(receiver, attribute, namespace, strict)
    else
      receiver = set_object(receiver, namespace, strict)
    end
    value || receiver
  end

  def set_attribute(receiver, attribute, namespace, strict)
    logger.opt_trace "Setting #{receiver} attribute (#{digest(namespace, attribute, strict)})"

    attribute = attribute.to_s if attribute.is_a? Symbol

    attribute_namespace = namespace.dup
    attribute_namespace << attribute

    value = get(attribute_namespace)

    if value.nil?
      msg = "#{attribute_namespace} not found in the data"
      logger.error msg
      raise Settings::Error, msg
    end

    Settings::Setting::Assignment::Attribute.assign(receiver, attribute.to_sym, value, strict)

    log_value = value
    log_value = log_value.to_h if log_value.respond_to? :to_h

    logger.opt_debug "Set #{receiver} #{attribute} to #{log_value}"

    value
  end

  def set_object(receiver, namespace, strict)
    logger.opt_trace "Setting #{receiver} object (#{digest(namespace, nil, strict)})"

    data = get(namespace)

    if data.nil?
      msg = "#{namespace} not found in the data"
      logger.error msg
      raise Settings::Error, msg
    end

    data.each do |attribute, value|
      Settings::Setting::Assignment::Object.assign(receiver, attribute.to_sym, value, strict)
    end

    logger.opt_debug "Set #{receiver} object (#{digest(namespace, nil, strict)})"

    receiver
  end

  def assign_value(receiver, attribute, value, strict=false)
    Settings::Setting::Assignment.assign(receiver, attribute, value, strict)
  end

  def get(*namespace)
    namespace.flatten!
    logger.opt_trace "Getting #{namespace}"

    string_keys = namespace.map { |n| n.is_a?(String) ? n : n.to_s }

    value = string_keys.inject(data) {|memo, k| memo ? memo[k] : nil }

    log_data = value
    log_data = log_data.to_h if log_data.respond_to? :to_h
    logger.opt_data "#{namespace}: #{log_data}"

    logger.opt_debug "Got #{namespace}"

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
