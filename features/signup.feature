Feature: Sign Up!
	In order to sign up for an account
	As a guest
	I need to be able to register

	Scenario: Access sign up page
		Given I am on the home page
		When I follow "Sign Up"
		Then I should see "Sign up to pomar!"
		And I should see "Name"
		And I should see "E-mail"
		And I should see "Username"
		And I should see "Password"
		And I should see "Confirmation"

	Scenario: Registering with invalid values for fields
		Given I am on the signup page
		When I press "Create user"
		Then I should see "Name can't be blank"
		And I should see "Email can't be blank"
		And I should see "Username can't be blank"
		And I should see "Password can't be blank"
		And I should see "Password is too short"

	Scenario: Registering with invalid e-mail
		Given I am on the signup page
		When I fill in "Name" with "John"
		And I fill in "E-mail" with "john@domain"
		And I fill in "Username" with "john"
		And I fill in "Password" with "mypass"
		And I fill in "Confirmation" with "mypass"
		And I press "Create user"
		Then I should see "Email is invalid"

	Scenario: Registering with duplicate e-mail
		Given there is a user with e-mail "john@sub.domain"
		And I am on the signup page
		When I fill in "Name" with "John"
		And I fill in "E-mail" with "john@sub.domain"
		And I fill in "Username" with "john"
		And I fill in "Password" with "mypass"
		And I fill in "Confirmation" with "mypass"
		And I press "Create user"
		Then I should see "Email has already been taken"

	Scenario: Registering with duplicate username
		Given there is a user with username "john"
		And I am on the signup page
		When I fill in "Name" with "John"
		And I fill in "E-mail" with "john@sub.domain"
		And I fill in "Username" with "john"
		And I fill in "Password" with "mypass"
		And I fill in "Confirmation" with "mypass"
		And I press "Create user"
		Then I should see "Username has already been taken"

	Scenario: Registering with valid values for fields
		Given I am on the signup page
		When I fill in "Name" with "John"
		And I fill in "E-mail" with "john@sub.domain"
		And I fill in "Username" with "john"
		And I fill in "Password" with "mypass"
		And I fill in "Confirmation" with "mypass"
		And I press "Create user"
		Then I should see "User was successfully created"
		And "john@sub.domain" should receive an email with a link to a confirmation page
