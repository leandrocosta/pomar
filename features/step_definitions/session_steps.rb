Given /I am not logged in/ do
	visit '/signout'
end

Given /I am logged in/ do
    user = User.create!(
      :name => "default name",
      :email => "email@sub.domain",
      :username => 'username',
      :password => 'password',
      :password_confirmation => 'password')
    user.confirmed = true
    user.save(:validate => false)

  visit '/signin'
  fill_in('username', :with => 'username')
  fill_in('password', :with => 'password')
  click_button('Login')
end

When /I access private area/ do
	visit '/main'
end
