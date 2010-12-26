Feature: Account settings control
	In order to configure my account
	As a user
	I need to change my settings

	Scenario: Access account settings area
		Given I am logged in
		When I follow "Account Settings"
		Then I should see "Change Password"
