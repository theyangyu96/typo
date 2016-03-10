Feature: Create Blog
  As an author
  In order to gift my thoughts to the world
  I want to merge a blog
  
 Background:
    Given the blog is set up

    Given the following users exist:
        | profile_id | login    | name   | password | email           |
        | 2          | pengster | Angela | ppppppp  | 1@example.com   |
        | 3          | yangster | Yang   | yyyyyyy  | 2@example.com   |

    Given the following articles exist:
        | id | title    | author   | user_id | body     |
        | 3  | A1       | pengster | 2       | Hello    |
        | 4  | A2       | yangster | 3       | World    | 

    Given the following comments exist:
        | id | author   | body     | article_id | user_id |
        | 1  | pengster | Comment1 | 3          | 2       |
        | 2  | yangster | Comment2 | 4          | 3       |
    
Scenario: Non-admin cannot merge articles
  Given I am logged in as "pengster" with "ppppppp"
  And I am at the Edit Page of Article with id "3"
  Then I should not see "Merge Articles"
  
   
Scenario: the merged article should contain the text of both previous articles
  Given I merged Articles with ids "3" and "4"
  And I am at the Edit Page of Article with id "3"
  And I am logged in as "pengster" with "ppppppp"
  Then I should see "Hello"
  And I should see "World"
  
Scenario: authors of merged articles are merged
  Given I merged Articles with ids "3" and "4"
  Then "pengster" should be the author of article with id "3"
  And "yangster" should not be the author of article with id "3"

Scenario: comments of merged aritcles are merged
  Given I merged Articles with ids "3" and "4"
  Then Article "3" should have comment id "1"  
  And Article "3" should have comment id "2"

Scenario: The title should be either one of the merged articles
    Given I merged Articles with ids "3" and "4"
    Then Article "3" should have title "A1"

    

