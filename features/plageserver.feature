Feature: As a web user
         In order to visit a page
         I want a server up and running

Scenario: I do a REQUEST to a PlageServer
  Given: A "Hello world " app running in a PlageServer
  When I do a REQUEST to /
  Then I should receive a RESPONSE containing "Hello world"
