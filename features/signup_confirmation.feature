Feature: Sign Up confirmation
  In order to complete my registration
  As a user
  I need to be able to confirm my account

  Scenario: Confirm account with invalid key
    Given there is not an unconfirmed user with password_salt "1234567890"
    When I go to confirm_path?key=1234567890
    Then I should see "Your account was confirmed!"
