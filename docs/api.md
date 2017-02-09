The HTTP interface for this application is a [JSONAPI](http://jsonapi.org/)-compliant RESTful API. You should use a compliant client, such as [json_api_client](https://github.com/chingor13/json_api_client) to make integration as simple as possible.

Currently, there is no security and only a two resources exist: webhooks and deliveries.

### Webhooks

Note: webhooks are read-only and cannot be modified once created, hence why no update / delete endpoints exist.

#### Index

`GET /api/v1/webhooks`

This index provides a list of all webhooks in the application.

#### Show

`GET /api/v1/webhooks/:id`

This view will return the attributes of a single webhook.

#### Create

`POST /api/v1/webhooks`

This endpoint allows you to submit a webhook to be queued for delivery. The endpoint is idempotent so if you submit a second webhook with the same `identifier` attribute, it will treat this as a duplicate record and return the original, without queuing a second delivery.

Deliveries are attempted 3 times before the background queue will give up.

##### Attributes

* `identifier` – uuid, required, unique
* `url` – string, required
* `headers` – object (key-value pairs), optional
* `body` – string, required

##### Example Body

```json
{
  "data": {
    "type": "webhooks",
    "attributes": {
      "identifier": "6cb9b8eb-9d57-4541-9522-80838cd1a019",
      "url": "http://example.com/path/to/endpoint",
      "headers": {
        "Content-Type": "application/json"
      },
      "body": "{\"key\":\"value\"}"
    }
  }
}
```

### Deliveries

Note: deliveries are read-only, you cannot even create them as the resource is designed to simply report on the status of webhook delivery attempts made from the background queues.

#### Example Object

```json
{
  "id": 1,
  "type": "deliveries",
  "attributes": {
    "status": "delivered",
    "response_time_ms": 103,
    "response_status_code": 200,
    "response_headers": {
      "Content-Type": "text/plain"
    },
    "response_body": "Success!"
  }
}
```

#### Index

`GET /api/v1/webhooks/:webhook_id/deliveries`

This index provides a list of all deliveries for the given webhook's id.

#### Show

`GET /api/v1/webhooks/:webhook_id/deliveries/:id`

This view will return the attributes of a single delivery.
