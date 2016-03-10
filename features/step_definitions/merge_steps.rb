Given /the following (.*?) exist:$/ do |type, table|
  table.hashes.each do |element|
    if    type == "users"    then User.create(element)
    elsif type == "articles" then Article.create(element)
    elsif type == "comments" then Comment.create(element)
    end
  end
end

Given /I am logged in as "(.*?)" with "(.*?)"$/ do |user, pass|
    visit '/accounts/login'
  fill_in 'user_login', :with => user
  fill_in 'user_password', :with => pass
  click_button 'Login'
  assert page.has_content? 'Login successful'
end

And /I am at the Edit Page of Article with id "(.*?)"$/ do |id|
    visit '/admin/content/edit/'+id
end

Given /I merged Articles with ids "(\d+)" and "(\d+)"$/ do |id1, id2|
    article = Article.find_by_id(id1)
    article.merge_article(id2)
end

Then /^"(.*?)" should be the author of article with id "(\d+)"$/ do |author, id|
    author == Article.find_by_id(id).author
end
Then /^"(.*?)" should not be the author of article with id "(\d+)"$/ do |author, id|
    author != Article.find_by_id(id).author
end

Then /^Article "(\d+)" should have comment id "(\d+)"$/ do |article_id, comment_id|
    article = Article.find_by_id(article_id)
    comments = article.comments
    comments.find_by_id(comment_id)
end

Then /^Article "(\d+)" should have title "(.*?)"$/ do |id, title|
    article = Article.find_by_id(id)
    real_title = article.title
    title == real_title
end
