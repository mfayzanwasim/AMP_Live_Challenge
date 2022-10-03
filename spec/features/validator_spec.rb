require_relative '../../services/password_validation_service'
require_relative '../../exceptions/invalid_password_exception'

RSpec.describe "PasswordValidationServiceTest", :type => :request do

  describe "when valid input is provided" do
    it "should throw no exceptions" do
      expect { PasswordValidationService.new('myPASSword123').validate! }.not_to raise_error
    end
  end

  describe "when less than three numbers are provided in input" do
    it "should raise exception with message The input must include at least 3 numbers" do
      expect { PasswordValidationService.new('myPASS12word').validate! }.to raise_error(Exceptions::InvalidPasswordException)
    end
  end

  describe "when less than four uppercase letters are provided in input" do
    it "should raise exception with message The input must include at least 4 uppercase characters" do
      expect { PasswordValidationService.new('mypass123word').validate! }.to raise_error(Exceptions::InvalidPasswordException)
    end
  end

  describe "when less than three numbers are provided in input" do
    it "should raise exception with message The length of the input must be between 10 and 15 characters" do
      expect { PasswordValidationService.new('PASS123').validate! }.to raise_error(Exceptions::InvalidPasswordException)
    end
  end
end