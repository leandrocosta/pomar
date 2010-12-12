Given /^there is a confirmed user with username "([^"]*)" and password "([^"]*)"$/ do |username, password|
    user = User.create!(
      :name => "default name",
      :email => "email@sub.domain",
      :username => username,
      :password => password,
      :password_confirmation => password)
    user.confirmed = true
    user.save(:validate => false)
end
