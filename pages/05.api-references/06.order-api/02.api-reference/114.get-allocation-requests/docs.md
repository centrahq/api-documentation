---
title: Order API - Get order allocation requests
altTitle: Get order allocation requests
taxonomy:
  category: docs
---

# Get allocation requests of an order

Endpoint: `GET *base*/orders/*id*/allocation-requests`  
Authentication: [API Key](/api-references/api-intro#authentication)

This will fetch all allocation requests for order.

Allocation request can have the following statuses:

`allocated` - items are allocated from this warehouse, request is sent,
`timed-out` - allocation request reached expiration date, items are re-allocated, request still can be confirmed (if the allocation flow has not yet reached the end),
`sent` - request was sent, but products are allocated from another warehouse. If this warehouse will confirm the request, re-allocation will be done if there is sufficient stock at the moment of confirmation.
`outdated` - allocation request is outdated, please ignore it
`failed` - allocation request wasn't sent in a webhook, but it can still be confirmed through Order API

[notice-box=alert]
In Order API Plugin settings `Allow access to the following endpoints` Order API should have access to `Get allocation requests of an order (GET /orders/*id*/allocation-requests)` endpoint.
[/notice-box]

## Parameters

[parameter data="warehouseId" datatype="int" isRequired=false sublevel=1]
Show allocation requests for a specific warehouse ID
[/parameter]

[parameter data="status" datatype="string" isRequired=false sublevel=1]
By default, allocation requests will be shown only with status ``sent``, ``allocated`` and ``failed``

Show allocation requests with a specific status. Acceptable values are ``sent``, ``outdated``, ``timed-out``,``confirmed``, ``rejected``, ``failed`` and ``pending``.

[/parameter]

## Request example

`GET <base>/*base*/orders/9993/allocation-requests HTTP/1.1`

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
            "id": 1140,
            "status": "outdated",
            "warehouseId": 27,
            "expirationDate": "2024-02-14T16:00:00+01:00",
            "order": {
                "id": "5cdb865329d982314aab6c5b84ac1201",
                "number": 1103
            },
            "lines": [
                {
                    "lineId": 1484,
                    "quantity": 1,
                    "stockItemId": 121
                },
                {
                    "lineId": 1485,
                    "quantity": 1,
                    "stockItemId": 120
                },
                {
                    "lineId": 1486,
                    "quantity": 2,
                    "stockItemId": 116
                }
            ],
            "createdAt": "2024-02-13T16:00:00+01:00",
            "warehouseName": "Store 1"
        },
        {
            "id": 1141,
            "status": "sent",
            "warehouseId": 27,
            "expirationDate": "2024-02-14T16:02:25+01:00",
            "order": {
                "id": "5cdb865329d982314aab6c5b84ac1201",
                "number": 1103
            },
            "lines": [
                {
                    "lineId": 1484,
                    "quantity": 1,
                    "stockItemId": 121
                },
                {
                    "lineId": 1485,
                    "quantity": 1,
                    "stockItemId": 120
                },
                {
                    "lineId": 1486,
                    "quantity": 2,
                    "stockItemId": 116
                }
            ],
            "createdAt": "2024-02-13T16:02:25+01:00",
            "warehouseName": "Store 1"
        }
    ]
}
```

## Error examples

Order isn't found:

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "status": "no",
    "msg": "Unknown order id: 1095"
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