module Exceptions
  class InvalidInputException < StandardError
    attr_reader :errors

    def initialize(errors)
      super
      @errors = errors
    end
  end
end