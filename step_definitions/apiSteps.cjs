const { Given, When, Then } = require('@cucumber/cucumber');
const chai = require('chai');
const axios = require('axios');
const expect = chai.expect;

// Your step definitions here

let endpoint;
let response;

Given('the API endpoint is {string}', function (url) {
  endpoint = url;
});

When('I send a request with the name {string}', async function (name) {
  response = await axios.get(`${endpoint}/?name=${name}`);
});

When('I send a request without a name', async function () {
  try {
    response = await axios.get(endpoint);
  } catch (err) {
    response = err.response;
  }
});

Then('the response status should be {int}', function (statusCode) {
  expect(response.status).to.equal(statusCode);
});

Then('the response should contain properties as {string}, {string} and {string}', function (count, name, age) {
  expect(response.data).to.have.property(count);
  expect(response.data).to.have.property(age);
  expect(response.data).to.have.property(name);

});

Then('the ages in the responses should not be equal', async function () {
  const response1 = await axios.get(`${endpoint}/?name=alice`);
  const response2 = await axios.get(`${endpoint}/?name=bob`);
  expect(response1.data.age).to.not.equal(response2.data.age);
});

Then('the api response should come in less than or equal to {string}ms', async function (key) {
  const startTime = Date.now();
  const response = await axios.get(`${endpoint}/?name=alice`);
  const responseTime = Date.now() - startTime;
  console.log(`Response Time: ${responseTime}ms`);
  expect(responseTime).lessThanOrEqual(200)
 
});

Then('the response should contain null value in age', function () {
  expect(response.data.age).to.have.property(null);
});

Then('Response has a valid JSON format', async function (name) {
  response = await axios.get(`${endpoint}/?name=${name}`);

  let parsedResponse;
    try {
      parsedResponse = JSON.parse(JSON.stringify(response.data));
    } catch (e) {
      throw new Error('Invalid JSON format');
    }
  // Check that the response contains the expected keys
  expect(parsedResponse).to.have.all.keys('name', 'age', 'count');
  expect(parsedResponse.name).to.be.a('string');
  expect(parsedResponse.age).to.be.a('number');
  expect(parsedResponse.count).to.be.a('number');
});

Then('Response has a valid content type', async function (name) {
  response = await axios.get(`${endpoint}/?name=${name}`);
  expect(response.headers['content-type']).to.include('application/json');
});

Then('the response status should not be 200', async function (name) {
  response = await axios.get(`${endpoint}/?name=${name}`);
  expect(response.status).to.equal(200);

});

Then('I send a request with the sql injected name', async function () {
  const sqlInjectionPayload = '`" OR 1=1 --`';
  response = await axios.get(`${endpoint}/?name=${sqlInjectionPayload}`);
})
