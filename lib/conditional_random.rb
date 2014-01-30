require 'securerandom'

require "conditional_random/version"

module ConditionalRandom
  def self.conditionalize(method_name)
    # Raise error when method is not exists in SecureRandom
    SecureRandom.send(method_name) unless ::SecureRandom.respond_to?(method_name)

    define_singleton_method method_name do |*args, &block|
      begin
        random = ::SecureRandom.send(method_name, *args)
      end until block.nil? || (block && block.call(random))
      random
    end
  end

  conditionalize :hex
  conditionalize :base64
  conditionalize :random_bytes
  conditionalize :random_number
  conditionalize :urlsafe_base64
  conditionalize :uuid
end
