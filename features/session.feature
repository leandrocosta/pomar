Feature: Session handling
  In order to use pomar
  As a registered user
  I need to be able to create a session

  Scenario: Access private area without a session
    Given I don't have a session
    When I access private area
    Then I should see "You are not logged in"
