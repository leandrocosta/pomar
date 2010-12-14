Given /I am not logged in/ do
	visit '/signout'
end

When /I access private area/ do
	visit '/main'
end
