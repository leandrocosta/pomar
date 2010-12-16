Feature: Session handling
  In order to use pomar
  As a registered user
  I need to be able to create a session

  Scenario: Access private area without a session
    Given I am not logged in
    When I access private area
    Then I should see "You are not logged in!"

  Scenario: Access private area with a session
    Given I am logged in
    When I access private area
    Then I should see "Private area!"
