class Settings
  module Setting
    module Assignment
      extend self

      def logger
        @logger ||= Logger.get self
      end

      def assign(receiver, attribute, value, strict=false)
        settable = assure_settable(receiver, attribute, strict)
        if settable
          assign_value(receiver, attribute, value)
        end

        receiver
      end

      def assign_value(receiver, attribute, value)
        logger.trace "Assigning to #{attribute}"
        receiver.send("#{attribute}=", value).tap do
          logger.debug "Assigning to #{attribute}"
          logger.data "Assigned #{value} to #{attribute}"
        end
      end

      def setting?(receiver, attribute)
        receiver_class = receiver.class
        Settings::Registry.instance.setting? receiver_class, attribute
      end

      def assignable?(receiver, attribute)
        receiver.respond_to? setter_name(attribute)
      end

      def setter_name(attribute)
        :"#{attribute.to_s}=" unless attribute.to_s.end_with? '='
      end

      def digest(receiver, attribute, strict)
        content = []
        content << "Attribute: #{attribute}" if attribute
        content << "Receiver: #{receiver}"
        strict = "<not set>" if strict.nil?
        content << "Strict: #{strict}"
        content.join ', '
      end

      module Object
        extend Assignment

        def logger
          @logger ||= Logger.get self
        end

        def self.assure_settable(receiver, attribute, strict=true)
          logger.trace "Approving attribute (#{digest(receiver, attribute, strict)})"

          if strict
            setting = setting?(receiver, attribute)
            unless setting
              logger.warn "Can't set \"#{attribute}\". It isn't a setting of #{receiver}."
              return false
            end
          end

          assignable = assignable? receiver, attribute
          unless assignable
            logger.warn "Can't set \"#{attribute}\". It isn't assignable to #{receiver}."
            return false
          end

          logger.debug "\"#{attribute}\" can be set"
          true
        end
      end

      module Attribute
        extend Assignment

        def logger
          @logger ||= Logger.get self
        end

        def self.assure_settable(receiver, attribute, strict=true)
          if strict
            setting = setting? receiver, attribute
            unless setting
              msg = "Can't set \"#{attribute}\". It isn't a setting of #{receiver}."
              logger.error msg
              raise msg
            end
          end

          assignable = assignable? receiver, attribute
          unless assignable
            msg = "Can't set \"#{attribute}\". It isn't assignable to #{receiver}."
            logger.error msg
            raise msg
          end

          logger.debug "\"#{attribute}\" can be set"
          true
        end
      end
    end
  end
end
