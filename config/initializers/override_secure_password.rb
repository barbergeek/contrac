module ActiveModel
  module SecurePassword
    module ClassMethods
      def has_secure_password(options = {})
        # Load bcrypt-ruby only when has_secure_password is used.
        # This is to avoid ActiveModel (and by extension the entire framework)
        # being dependent on a binary library.
        gem 'bcrypt-ruby', '~> 3.0.0'
        require 'bcrypt'

        attr_reader :password

        if options.fetch(:validations, true)
          validates_confirmation_of :password
          validates_presence_of     :password, :on => :create

          before_create { raise "Password digest missing on new record" if password_digest.blank? }
        end

        include InstanceMethodsOnActivation

        if respond_to?(:attributes_protected_by_default)
          def self.attributes_protected_by_default #:nodoc:
            super + ['password_digest']
          end
        end
      end
    end
  end
end