Given /^there is a user with e\-mail "([^"]*)"$/ do |email|
    User.create!(
      :name => "default name",
      :email => email,
      :username => "default username",
      :password => "default password",
      :password_confirmation => "default password");
end

Given /^there is a user with username "([^"]*)"$/ do |username|
    User.create!(
      :name => "default name",
      :email => "default@sub.domain",
      :username => username,
      :password => "default password",
      :password_confirmation => "default password");
end

Then /^"([^"]*)" should receive an email with a link to a confirmation page$/ do |address|
  unread_emails_for(address).size.should == 1

  open_last_email_for(last_email_address)
  current_email.should have_subject(/Pomar! Account confirmation/)
  click_email_link_matching /\/confirm\?key=/
end
