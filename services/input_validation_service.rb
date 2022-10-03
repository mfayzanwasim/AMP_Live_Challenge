require_relative '../exceptions/invalid_input_exception'

class InputValidationService
  attr_accessor :input, :errors, :skip_validations, :min_length, :max_length

  DEFAULT_MIN_LENGTH_OF_INPUT = 10.freeze
  DEFAULT_MAX_LENGTH_OF_INPUT = 15.freeze
  CASE_REGEX = /(.*[A-Z]){4}/.freeze
  NUMERICALITY_REGEX = /(.*[0-9]){3}/i.freeze
  VALIDATIONS = %i[validate_length! validate_case! validate_numericality!]

  def initialize(input, skip_validations: [], length: { min: DEFAULT_MIN_LENGTH_OF_INPUT, max: DEFAULT_MAX_LENGTH_OF_INPUT })
    self.input = input
    self.errors = []
    self.skip_validations = skip_validations
    self.min_length = length[:min]
    self.max_length = length[:max]
  end

  def validate
    VALIDATIONS.each do |validation|
      next if skip_validations.include?(validation)
      self.send(validation)
    end

    unless errors.empty?
      raise Exceptions::InvalidInputException.new(errors)
    end
  end

  def validate!
    validate
  end

  private
  def validate_length!
    unless (min_length..max_length).cover? input.length
      # Handle translation string if needed.
      self.errors << "The length of the input must be between #{min_length} and #{max_length} characters"
      # Todo: Future proof it by raising custom exception for each validation like Validators::Exceptions::InvalidLength
    end
  end

  def validate_case!
    unless self.input.match?(CASE_REGEX)
      self.errors << "The input must include at least 4 uppercase characters"
    end
  end

  def validate_numericality!
    unless self.input.match?(NUMERICALITY_REGEX)
      self.errors << "The input must include at least 3 numbers"
    end
  end

end
