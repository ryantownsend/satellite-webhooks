[![Codeship](https://app.codeship.com/projects/c0539910-cd26-0134-987f-32338ebbb7ed/status?branch=master)](https://app.codeship.com/projects/200333) [![Code Climate](https://codeclimate.com/github/ryantownsend/satellite-webhooks/badges/gpa.svg)](https://codeclimate.com/github/ryantownsend/satellite-webhooks)

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/ryantownsend/satellite-webhooks)

Satellite is a Rails-based webhook delivery microservice. It supports the following features:

* JSONAPI-compliant RESTful API
* Automatic retry mechanism with exponential back-off
* Configurable delivery attempt limit
* Automatic application of HTTP Basic Authentication header
* HTTP proxy support for those needing static outbound IP addresses
* HMAC request signing

* [Development Documentation](https://github.com/ryantownsend/satellite-webhooks/blob/master/docs/development.md)
* [API Documentation](https://github.com/ryantownsend/satellite-webhooks/blob/master/docs/api.md)
