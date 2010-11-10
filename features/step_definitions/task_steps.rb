Given /^the following tasks:$/ do |tasks|
  Task.create!(tasks.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) task$/ do |pos|
  visit tasks_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following tasks:$/ do |expected_tasks_table|
  expected_tasks_table.diff!(tableish('table tr', 'td,th'))
end
