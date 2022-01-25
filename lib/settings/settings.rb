class Settings
  class Error < RuntimeError; end

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def self.build(source=nil)
    source ||= implementer_source

    data = get_data(source)

    instance = new(data)

    instance
  end

  def self.get_data(source)
    data_source = DataSource::Build.(source)
    data = data_source.get_data
  end

  def self.implementer_source
    unless self.respond_to?(:data_source)
      return nil
    end

    self.data_source
  end

  def set(receiver, *namespace, attribute: nil, strict: true)
    unless attribute.nil?
      value = set_attribute(receiver, attribute, namespace, strict)
    else
      receiver = set_object(receiver, namespace, strict)
    end
    value || receiver
  end

  def set_attribute(receiver, attribute, namespace, strict)
    attribute = attribute.to_s if attribute.is_a?(Symbol)

    attribute_namespace = namespace.dup
    attribute_namespace << attribute

    value = get(attribute_namespace)

    if value.nil?
      raise Settings::Error, "#{attribute_namespace} not found in the data"
    end

    Settings::Setting::Assignment::Attribute.assign(receiver, attribute.to_sym, value, strict)

    value
  end

  def set_object(receiver, namespace, strict)
    data = get(namespace)

    if data.nil?
      raise Settings::Error, "#{namespace} not found in the data"
    end

    data.each do |attribute, value|
      Settings::Setting::Assignment::Object.assign(receiver, attribute.to_sym, value, strict)
    end

    receiver
  end

  def assign_value(receiver, attribute, value, strict=false)
    Settings::Setting::Assignment.assign(receiver, attribute, value, strict)
  end

  def get(*namespace)
    namespace.flatten!

    keys = namespace.map { |n| n.is_a?(Symbol) ? n.to_s : n }

    value = nil
    if keys.empty?
      value = data
    else
      value = data.dig(*keys)
    end

    value
  end
end
