# Add a declarative step here for populating the DB with movies.
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Given /^I check only the following ratings: ((?:.+,)*.+)$/ do |ratings|
  checked_ratings = ratings.split ", "
  unchecked_ratings = Movie.all_ratings - checked_ratings
  checked_ratings.each {|rating| check "ratings_#{rating}"}
  unchecked_ratings.each {|rating| uncheck "ratings_#{rating}"}
end

When /^I submit the filter form$/ do
  click_button "ratings_submit"
end

Then /^I should only see: ((?:.+,)*.+)$/ do |title_list|
  titles = title_list.split ", "
  table_rows = all "table#movies tbody tr"
  assert table_rows.count == titles.count
  assert table_rows.map {|row| row.find("td").text} - titles == []
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page
Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end
