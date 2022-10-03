require_relative '../exceptions/invalid_password_exception'

class PasswordValidationService
  attr_accessor :password, :errors, :skip_validations, :min_length, :max_length

  DEFAULT_MIN_LENGTH_OF_PASSWORD = 10.freeze
  DEFAULT_MAX_LENGTH_OF_PASSWORD = 15.freeze
  CASE_REGEX = /(.*[A-Z]){4}/.freeze
  NUMERICALITY_REGEX = /(.*[0-9]){3}/i.freeze
  VALIDATIONS = %i[validate_length! validate_case! validate_numericality!]

  def initialize(password,  options: { skip_validation: [], length: { min: DEFAULT_MIN_LENGTH_OF_PASSWORD, max: DEFAULT_MAX_LENGTH_OF_PASSWORD } })
    self.password = password
    self.errors = []
    self.skip_validations = options[:skip_validation]
    self.min_length =  options[:length][:min]
    self.max_length =  options[:length][:max]
  end

  def validate
    VALIDATIONS.each do |validation|
      self.send(validation)
    end

    unless errors.empty?
      raise Exceptions::InvalidPasswordException, errors
    end
  end

  def validate!
    validate
  end

  private
  def validate_length!
    unless (min_length..max_length).cover? password.length
      # Handle translation string if needed.
      self.errors << "The length of the input must be between #{min_length} and #{max_length} characters"
      # Todo: Future proof if by raising custom exception for each validation like Validators::Exceptions::InvalidLength
    end
  end

  def validate_case!
    unless self.password.match?(CASE_REGEX)
      self.errors << "The input must include at least 4 uppercase characters"
    end
  end

  def validate_numericality!
    unless self.password.match?(NUMERICALITY_REGEX)
      self.errors << "The input must include at least 3 numbers"
    end
  end

end
