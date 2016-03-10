Feature: Create Blog
  As an author
  In order to gift my thoughts to the world
  I want to merge a blog
  
 Background:
    Given the blog is set up
    
Scenario: Non-admin cannot merge articles
   Given I am on the admin panel
   Then I should see "Login"
   
Scenario: When articles are merged, the merged article should contain the text of both previous articles
  Given the blog is set up
  And I am logged into the admin panel
  Given I am on the new article page
    When I fill in "article_title" with "A1"
    And I fill in "article__body_and_extended_editor" with "Hello"
    And I press "Publish"
    Then I should be on the admin content page
    
  Given I am on the new article page
    When I fill in "article_title" with "A2"
    And I fill in "article__body_and_extended_editor" with "World"
    And I press "Publish"
    Then I should be on the admin content page
  When I follow "Edit"
    And I fill in "merge_id" with "1"
    Then I should be on the admin content page
    When I follow "A1"
    Then I should see "Hello World"
    And the author should be "admin"
  
Scenario: comments of merged aritcles are merged
    Given the blog is set up
  And I am logged into the admin panel
  Given I am on the new article page
    When I fill in "article_title" with "A1"
    And I fill in "article__body_and_extended_editor" with "Hello"
    And I press "Publish"
    Then I should be on the admin content page
    
  Given I am on the new article page
    When I fill in "article_title" with "A2"
    And I fill in "article__body_and_extended_editor" with "World"
    And I press "Publish"
    Then I should be on the admin content page
  
  Given I am on the home page
    When I follow "A1"
    And I fill in "comment_author" with "bum"
    And I fill in "comment_body" with "I hate my life"

  Given I am on the home page
    When I follow "A2"
    And I fill in "comment_author" with "mub"
    And I fill in "comment_body" with "I love my life"

  When I follow "Edit"
    And I fill in "merge_id" with "1"
    Then I should be on the admin content page
  When I follow "Comments"
  
  Given I am on the home page
    When I follow "A2"
    Then I should see "I love my life"
    And I should see "I hate my life"
    

    

