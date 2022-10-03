# Input Validation Service
Allows for validation of strings for a below mentioned criteria.

The validation criteria is the following:


1. The length of the string must be between 10 and 15 characters.
2. The string must include at least 3 numbers.
3. The string must include at least 4 uppercase characters.

## Running the tests
To simply run the test for the written service, simply run 
````shell
$ bundle install
rspec spec/features/validator_spec.rb
````

This should run 5 test blocks that describe the errors and 1 test block that allows for valid input and 1 test block that passes by skipping the validations.

## Expected arguments
The service for input validation is called InputValidationService
Expected arguments are at least the input that is to be validated, followed by skip_validations: [],  length: { min: DEFAULT_MIN_LENGTH_OF_INPUT, max: DEFAULT_MAX_LENGTH_OF_INPUT })
If skip_validations is provided an array of methods to skip then the validations performed in those methods are not run and results in errors not being added to the exception message array.
Also, length can be tweaked to change the Minimum expected length of the input and also the maximum expected length of the input


## Example
```ruby
# This skips all validations
InputValidationService.new('', skip_validations: %i[validate_length! validate_case! validate_numericality!] ).validate!

# This changes the expected min and max length and allows the input to be validated
InputValidationService.new('PASS123', length: { min: 5, max: 8}).validate!

# This is an example of a validatable input
InputValidationService.new('myPASSword123').validate!
```
