Feature: Account settings control
	In order to configure my account
	As a user
	I need to change my settings

	Scenario: Access account settings area
		Given I am logged in
		When I follow "Settings"
		Then I should see "Password"
