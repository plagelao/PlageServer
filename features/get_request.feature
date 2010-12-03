Feature: As a valid rfc 2616 implementation
         In order to visit a page
         I want a valid GET REQUEST

Scenario: GET REQUEST to an exisiting page responds with the page
  Given A PlageServer
  When I do the REQUEST "GET / HTTP/1.1\r\nHost: localhost:8082\r\n\r\n"
  Then I should receive the RESPONSE "HTTP/1.1 200 OK\r\n\r\n"
  And A body containing "Welcome to PlageServer"

Scenario: GET REQUEST to a URI that does not exist
  Given A PlageServer
  When I do the REQUEST "GET /not_found HTTP/1.1\r\nHost: localhost:8082\r\n\r\n"
  Then I should receive the RESPONSE "HTTP/1.1 404 Not Found\r\n\r\n"
