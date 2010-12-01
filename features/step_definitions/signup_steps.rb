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
