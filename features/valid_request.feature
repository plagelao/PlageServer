Feature: As a valid rfc 2616 implementation
         In order to visit a page
         I want a valid request


Scenario: REQUEST with absolute URI
  Given A PlageServer
  When I do the REQUEST "GET http://localhost:8082/ HTTP/1.1\r\n\r\n"
  Then I should receive the RESPONSE "HTTP/1.1 200 OK\r\n\r\n"
  And A body containing "Welcome to PlageServer"

Scenario: REQUEST with absolute path
  Given A PlageServer
  When I do the REQUEST "GET / HTTP/1.1\r\nHost: localhost:8082\r\n\r\n"
  Then I should receive the RESPONSE "HTTP/1.1 200 OK\r\n\r\n"
  And A body containing "Welcome to PlageServer"

Scenario: Invalid REQUEST, no method specified
  Given A PlageServer
  When I do the REQUEST "http://localhost:8082/ HTTP/1.1\r\n\r\n"
  Then I should receive the RESPONSE "HTTP/1.1 400 Bad Request\r\n\r\n"

Scenario: Invalid REQUEST, no URI specified
  Given A PlageServer
  When I do the REQUEST "GET invalid_uri HTTP/1.1\r\n\r\n"
  Then I should receive the RESPONSE "HTTP/1.1 400 Bad Request\r\n\r\n"

Scenario: Invalid REQUEST, no protocol specified
  Given A PlageServer
  When I do the REQUEST "GET http://localhost:8082/ \r\n\r\n"
  Then I should receive the RESPONSE "HTTP/1.1 400 Bad Request\r\n\r\n"

Scenario: Invalid REQUEST, invalid protocol specified
  Given A PlageServer
  When I do the REQUEST "GET http://localhost:8082/ HTTP/1.2\r\n\r\n"
  Then I should receive the RESPONSE "HTTP/1.1 400 Bad Request\r\n\r\n"

Scenario: Invalid REQUEST, invalid request line end
  Given A PlageServer
  When I do the REQUEST "GET http://localhost:8082/ HTTP/1.1\r\n\n"
  Then I should receive the RESPONSE "HTTP/1.1 400 Bad Request\r\n\r\n"

Scenario: Invalid REQUEST, invalid request end
  Given A PlageServer
  When I do the REQUEST "GET http://localhost:8082/ HTTP/1.1\r\n\r"
  Then I should receive the RESPONSE "HTTP/1.1 400 Bad Request\r\n\r\n"

Scenario: Invalid REQUEST, invalid absolute path
  Given A PlageServer
  When I do the REQUEST "GET / HTTP/1.1\r\n\r\n"
  Then I should receive the RESPONSE "HTTP/1.1 400 Bad Request\r\n\r\n"

