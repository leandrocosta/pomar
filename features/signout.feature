Feature: Sign Out!
  In order to finish the access to pomar
  As a logged user
  I need to be able to sign out

  Scenario: Logout
    Given I am logged in
    And I access private area
    When I follow "Sign Out"
    Then I should see "Sign In!"
