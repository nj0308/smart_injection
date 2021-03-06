# frozen_string_literal: true

# @api private
# @since 0.1.0
module SmartCore::Injection::Injector::InjectionSettings::IncompatabilityControl
  class << self
    # @param injectable [Class, Module]
    # @param imports [Hash<String|Symbol,String>]
    # @param memoize [Boolean]
    # @param access [Symbol]
    # @param bind [Symbol]
    # @param from [NilClass, SmartCore::Container]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def prevent_incompatabilities!(injectable, imports, memoize, access, bind, from)
      prevent_injectable_incompatabilities!(injectable)
      prevent_imports_incompatabilites!(imports)
      prevent_memoize_incompatabilites(memoize)
      prevent_access_incompatabilites(access)
      prevent_bind_incompatabilites(bind)
      prevent_from_incompatabilites(from)
    end

    private

    # @param injectable [Class, Module]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def prevent_injectable_incompatabilities!(injectable)
      unless injectable.is_a?(Class) || injectable.is_a?(Module)
        raise(SmartCore::Injection::ArgumentError, <<~ERROR_MESSAGE)
        ERROR_MESSAGE
      end
    end

    # @param imports [Hash<String|Symbol,String>]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def prevent_imports_incompatabilites!(imports)
      unless imports.is_a?(::Hash)
        raise(SmartCore::Injection::ArgumentError, <<~ERROR_MESSAGE)
          Incorrect import list (should be a type of Hash)
        ERROR_MESSAGE
      end

      unless imports.keys.all? { |key| key.is_a?(String) || key.is_a?(Symbol) }
        raise(SmartCore::Injection::ArgumentError, <<~ERROR_MESSAGE)
          Some method aliases are incorret (they should be a type of String or Symbol)
        ERROR_MESSAGE
      end

      unless imports.values.all? { |value| value.is_a?(String) }
        raise(SmartCore::Injection::ArgumentError, <<~ERROR_MESSAGE)
          Some injection pathes are incorrect (they should be a type of String)
        ERROR_MESSAGE
      end
    end

    # @param memoize [Boolean]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def prevent_memoize_incompatabilites(memoize)
      unless memoize.is_a?(::TrueClass) || memoize.is_a?(::FalseClass)
        raise(SmartCore::Injection::ArgumentError, <<~ERROR_MESSAGE)
        ERROR_MESSAGE
      end
    end

    # @param access [Symbol]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def prevent_access_incompatabilites(access)
      unless SmartCore::Injection::Injector::InjectionSettings::ACCESS_MARKS.include?(access)
        raise(SmartCore::Injection::ArgumentError, <<~ERROR_MESSAGE)
        ERROR_MESSAGE
      end
    end

    # @param bind [Symbol]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def prevent_bind_incompatabilites(bind)
      unless SmartCore::Injection::Injector::InjectionSettings::BINDING_STRATEGIES.include?(bind)
        raise(SmartCore::Injection::ArgumentError, <<~ERROR_MESSAGE)
        ERROR_MESSAGE
      end
    end

    # @param from [NilClass, SmartCore::Container]
    # @return [void]
    #
    # @api private
    # @since 0.1.0
    def prevent_from_incompatabilites(from)
      unless from.is_a?(NilClass) || from.is_a?(SmartCore::Container)
        raise(SmartCore::Injection::ArgumentError, <<~ERROR_MESSAGE)
        ERROR_MESSAGE
      end
    end
  end
end
