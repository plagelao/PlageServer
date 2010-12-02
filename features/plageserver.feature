Feature: As a web user
         In order to visit a page
         I want a server up and running

Scenario: I do a GET REQUEST to a PlageServer
  Given A PlageServer
  When I do a GET REQUEST to /
  Then I should receive a 200 RESPONSE with "Hello world" in the body
