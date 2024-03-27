---
title: Order API - Get order allocation requests
altTitle: Get order allocation requests
taxonomy:
  category: docs
---

# Get allocation requests of an order

Endpoint: `GET *base*/allocation-requests`  
Authentication: [API Key](/api-references/api-intro#authentication)

This will fetch allocation requests for orders. It only applies to the "Direct, then confirm" flow, where at least such 
warehouse is used for the stock allocation.

Allocation request can have the following statuses:

* `allocated` - items are allocated, but a webhook was not sent yet, should transition to `sent` right away,
* `sent` - request webhook was sent, waiting for a response,
* `failed` - could not deliver a webhook call, but the request can still be fetched and confirmed through Order API,
* `confirmed` - Centra received a confirmation, the allocation is now final,
* `rejected` - Centra received a rejection; if stock had been allocated from this warehouse, it has moved on to the next one,
* `timed-out` - allocation request reached expiration date, items are re-allocated, but this request still can be confirmed as long as the allocation flow has not reached the end yet,
* `outdated` - allocation request is outdated and cannot be accepted anymore, please ignore it.

[notice-box=alert]
In Order API Plugin settings `Allow access to the following endpoints` Order API should have access to the `Get allocation requests (GET /allocation-requests)` endpoint.
[/notice-box]

## Parameters

[parameter data="status" datatype="string" isRequired=false sublevel=1]
By default, only "pending" (actionable) allocation requests will be returned.

Accepts one or multiple comma-separated statuses listed above, or ``all`` to include all possible statuses.
[/parameter]

[parameter data="order" datatype="int" isRequired=false sublevel=1]
Show allocation requests for a specific order number. Also accepts a comma-separated list of numbers.
[/parameter]

[parameter data="warehouse" datatype="int" isRequired=false sublevel=1]
Show allocation requests for a specific warehouse ID. Also accepts a comma-separated list of IDs.
[/parameter]

[parameter data="page" datatype="int" isRequired=false sublevel=1]
Page number, starting from ``1``. Each page contains up to ``100`` entries.
[/parameter]

## Request example

`GET <base>/*base*/allocation-requests HTTP/1.1`

## Response

`200` `Content-type: application/json`
[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success. ``no`` if failed.
[/parameter]

[parameter data="errorMessages" datatype="array" isRequired=false sublevel=1]
If ``status`` returns ``no``, this value will be not empty with a message why it failed.
[/parameter]

[parameter data="allocation_requests" datatype="array" isRequired=false sublevel=1]
Array with allocation requests json objects.
[/parameter]

## Response example

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "status": "ok",
    "allocation_requests": [
        {
            "id": 1,
            "status": "outdated",
            "warehouseId": 3,
            "warehouseName": "Amsterdam",
            "expirationDate": "2024-03-18T09:04:48+01:00",
            "order": {
                "id": "486e13eaaa65d5ff1e87c997b5dce54e",
                "number": 15
            },
            "lines": [
                {
                    "lineId": 73,
                    "quantity": 5,
                    "stockItemId": 1
                }
            ],
            "createdAt": "2024-03-18T09:04:47+01:00"
        },
        {
            "id": 2,
            "status": "outdated",
            "warehouseId": 4,
            "warehouseName": "Tokyo",
            "expirationDate": "2024-03-18T09:04:47+01:00",
            "order": {
                "id": "486e13eaaa65d5ff1e87c997b5dce54e",
                "number": 15
            },
            "lines": [
                {
                    "lineId": 73,
                    "quantity": 5,
                    "stockItemId": 1
                }
            ],
            "createdAt": "2024-03-18T09:04:47+01:00"
        }
    ]
}
```

## Error examples

Unknown status:

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "status": "no",
    "errorMessages": {
        "status": "Expected \"status\" to be a single or a comma-separated list of request statuses, or \"all\", got \"?\""
    }
}
```


Missing access to endpoint: 
```http
HTTP/1.1 403 Forbidden
Content-type: application/json

{
  "status": "Not Allowed"
}
```
