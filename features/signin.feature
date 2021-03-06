Feature: Sign In!
  In order to get access to pomar
  As a registered user
  I need to be able to sign in

  Scenario: Access sign in page
    Given I am on the home page
    When I follow "Sign In"
    Then I should see "Username"
    And I should see "Password"

  Scenario: Sign in with invalid values for fields
    Given I am on the signin page
    When I press "Login"
    Then I should see "Invalid username/password combination"

  Scenario: Sign in with valid values for fields
    Given there is a confirmed user with username "u" and password "pppppp"
    And I am on the signin page
    When I fill in "Username" with "u"
    And I fill in "Password" with "pppppp"
    And I press "Login"
    Then I should see "logged in as"
