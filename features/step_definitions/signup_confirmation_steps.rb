Given /^there is not an unconfirmed user with password_salt "([^"]*)"$/ do |key|
  User.destroy_all(:password_salt => key)
end

When /^I confirm the key "([^"]*)"$/ do |key|
  visit "/confirm?key=#{key}"
end
