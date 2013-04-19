# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(:title => movie['title'], :release_date => movie['release_date'], :rating => movie['rating'])
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

#http://stackoverflow.com/questions/5886429/how-to-write-a-cucumber-step-to-test-if-a-list-of-elements-is-sorted

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #flunk "Unimplemented"
  page.body.index(e1).should < page.body.index(e2)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rbj
  rating_list.split(%r{,\s*}).each {|rating| step %Q(I #{uncheck}check "ratings_#{rating}")}
end

Then /I should see all of the movies/ do  
  page.all('table#movies tr').count.should == 11  
  page.should have_css("table#movies tr", :count=>11)
end

Then /I should see no movies/ do
  page.all('table#movies tr').count.should == 1  
  page.should have_css("table#movies tr", :count=>1)
end

