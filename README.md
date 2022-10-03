# Input Validation Service
Allows for validation of strings for a below mentioned criteria.

The validation criteria is the following:


1. The length of the string must be between 10 and 15 characters.
2. The string must include at least 3 numbers.
3. The string must include at least 4 uppercase characters.

## Installation
To simply run the test for the written service, simply run 
````shell
$ bundle install
rspec spec/features/validator_spec.rb
````

This should run 3 test blocks that describe the errors and 1 test block that allows for valid input.