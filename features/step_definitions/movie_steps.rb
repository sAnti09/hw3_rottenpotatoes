# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  Movie.delete_all
  movies_hash = movies_table.hashes
  movies_hash.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  Movie.count.should eq(movies_hash.size)
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.

  regexp = /#{e1}.*#{e2}/m
  #page.body.should have_content(regexp)
  page.body.should =~ regexp
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(',').each do |rating|
    rating.strip!
    step %{I #{uncheck.nil? ? "check" :"uncheck"} "ratings_#{rating}"}
  end
end

#When /all checkboxes are (un)?checked/ do |mode|
#  all_ratings = Movie.all_ratings
#  all_ratings.each do |rating|
#    step %{I #{mode.nil? ? "check" :"uncheck"} "ratings_#{rating}"}
#  end
#
#  step %{I press "Refresh"}
#end

Then /I should(n't)? see (any|all)? movies/ do |mode, temp|
  all_movies = Movie.all
  all_movies.each do |movie|
    step %{I should #{mode.nil? ? "see" :"not see"} "#{movie.title}"}
  end
end
