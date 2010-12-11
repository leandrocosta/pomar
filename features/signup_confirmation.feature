Feature: Sign Up confirmation
  In order to complete my registration
  As a not confirmed user
  I need to be able to confirm my account

  Scenario: Confirm account with invalid key
    Given there is not an unconfirmed user with sha1_salt "1234567890"
    When I confirm the key "1234567890"
    Then I should see "Error: The confirmation key is invalid!"

  Scenario: Confirm account with valid key
    Given there is an unconfirmed user with sha1_salt "1234567890" and email "default@sub.domain"
    When I confirm the key generated by sha1_salt "1234567890" and email "default@sub.domain"
    Then I should see "Your account was confirmed!"
