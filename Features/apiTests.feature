Feature: Testing agify.io API

Scenario: Verify the API returns 200 status code for a valid name 
  Given the API endpoint is "https://api.agify.io"
  When I send a request with the name "billybob"
  Then the response status should be 200

  Scenario: Verify the API response has count, name and age properties
  Given the API endpoint is "https://api.agify.io"
  When I send a request with the name "billybob"
  Then the response status should be 200
  And the response should contain properties as "count", "name" and "age"

@test
  Scenario: Verify the API response has date as NULL if invalid name is given
  Given the API endpoint is "https://api.agify.io"
  When I send a request with the name "billybob"
  Then the response status should be 200
  And the response should contain null value in age

Scenario: Verify the API handles missing parameters gracefully
  Given the API endpoint is "https://api.agify.io"
  When I send a request without a name
  Then the response status should be 400

@PerformanceTest
Scenario: API response should be under or equal to 200ms
  Given the API endpoint is "https://api.agify.io"
  When I send a request with the name "alice"
   Then the api response should come in less than or equal to "200"ms

Scenario: Verify response should return a valid JSON
  Given the API endpoint is "https://api.agify.io"
  When I send a request with the name "billybob"
  Then the response status should be 200
  Then Response has a valid JSON format

  Scenario: Verify response should have a valid content type
  Given the API endpoint is "https://api.agify.io"
  When I send a request with the name "billybob"
  Then the response status should be 200
  Then Response has a valid content type

  Scenario: Verify API request should not accept SQL Injection code as name paramenter
  Given the API endpoint is "https://api.agify.io"
  When I send a request with the sql injected name 
  Then the response status should not be 200

  Scenario: Verify API request should give a proper error code if name is missing
  Given the API endpoint is "https://api.agify.io"
  When I send a request with the name ""
  Then the response status should not be 200

  @BVATest  
  Scenario: Verify API request should not accept more than 255 charaters for a name
  Given the API endpoint is "https://api.agify.io"
  When I send a request with the name "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  Then the response status should not be 200

