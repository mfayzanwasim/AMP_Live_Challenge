module Exceptions
  class InvalidPasswordException < StandardError
    def initialize(msg = "Invalid input")
      super
    end
  end
end