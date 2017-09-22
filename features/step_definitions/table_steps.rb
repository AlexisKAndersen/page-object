Then /^the data for row "([^\"]*)" should be "([^\"]*)" and "([^\"]*)"$/ do |row, col1, col2|
  row = (row.to_i - 1) if row.to_i > 0
  table_row = @element[row]
  expect(table_row[0].text).to eql col1
  expect(table_row[1].text).to eql col2
end

When /^I retrieve the data from the table cell$/ do
  @cell_data = @page.cell_id
end

Then /^the cell data should be '([^"]*)'$/ do |expected|
  expect(@cell_data).to eql expected
end

When /^I retrieve a table element by "([^\"]*)"$/ do |how|
  @element = @page.send "table_#{how}_element"
end

When /^I retrieve a table element by "([^\"]*)" and "([^\"]*)"$/ do |param1, param2|
  @element = @page.send "table_#{param1}_#{param2}_element"
end

When /^I retrieve a table element while the script is executing$/ do
  @element = @page.table_element(:id => 'table_id')
end

Then /^the data for the first row should be "([^\"]*)" and "([^\"]*)"$/ do |col1, col2|
  expect(@element.first_row[0].text).to eql col1
  expect(@element.first_row[1].text).to eql col2
end

Then /^the data for the second row should be "([^\"]*)" and "([^\"]*)"$/ do |col1, col2|
  expect(@element[1][0].text).to eql col1
  expect(@element[1][1].text).to eql col2
end

Then /^the data for the last row should be "([^\"]*)" and "([^\"]*)"$/ do |col1, col2|
  expect(@element.last_row[0].text).to eql col1
  expect(@element.last_row[1].text).to eql col2
end

Then /^I should see that the table exists$/ do
  expect(@page.table_id?).to be true
end

Then /^the data for column "([^\"]*)" and row "([^\"]*)" should be "([^\"]*)"$/ do |column, row, value|
  expect(@element[row.to_i - 1][column].text).to eql value
end

Then /^the data for row "([^\"]*)" and column "([^\"]*)" should be "([^\"]*)"$/ do |row, column, value|
  expect(@element[row][column].text).to eql value
end

Then /^the data for row "([^\"]*)" should be nil$/ do |row|
  expect(@element[row]).to be_nil
end

Then /^the data for row "([^\"]*)" and column "([^\"]*)" should be nil$/ do |row, column|
  expect(@element[row][column]).to be_nil
end

Then /^I should see the text includes "([^"]*)" when I retrieve it by "([^"]*)"$/ do |text, how|
  expect(@page.send("table_#{how}")).to include text
end

Then /^the table should be like the expected one$/ do |expected_table|
  expect((expected_table.diff!@element.hashes)).to be_nil
end

When(/^I ask for the column values for "([^"]*)"$/) do |header|
  @values = @page.table_id_element.column_values(header)
end

Then(/^I should receive:$/) do |table|
  expect(@values.size).to eql 2
  table.hashes.each do |hsh|
    expect(@values).to include hsh['values']
  end
end

When(/^I ask for the column values for column (\d+)$/) do |index|
  @values = @page.table_id_element.column_values(index.to_i)
end