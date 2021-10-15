---
title: Order API - Capture Shipment
altTitle: Capture Shipment
excerpt: Capturing the payment for a shipment
taxonomy:
  category: docs
---

# Capture shipment

`PUT  *base*/capture`
Authentication : [API Key](/api-references/api-intro#authentication)

This will capture the payment for a shipment. You can use this on a shipment that has `"shouldCapture": true` from [Get shipments](order-api-get-shipments).

## Parameters

[parameter data="shipment" datatype="string" isRequired=true storetype="b2b b2c" sublevel=1]
The ``shipmentId`` from [Get shipments](/api-references/order-api/api-reference/get-shipments) or [Create shipment](/api-references/order-api/api-reference/create-shipment).
[/parameter]

[parameter data="xml" datatype="boolean" isRequired=false storetype="b2b b2c" sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

```http
PUT <base>/capture HTTP/1.1
Content-type: application/json

{
  "shipment": "83651-1"
}
```

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="order" datatype="int" sublevel=1]
Order ID that was captured.
[/parameter]

[parameter data="shipment" datatype="string" sublevel=1]
OShipment ID that was captured.
[/parameter]

[parameter data="msg" datatype="string" isRequired=false sublevel=1]
If ``status`` returns ``no``, this value should send back a message why it failed.
[/parameter]

## Response example

```json
{
  "status": "ok",
  "order": 83651,
  "shipment": "83651-1"
}
```

## Error example

```json
{
  "status": "no",
  "msg": "capture failed",
  "order": 83651,
  "shipment": "83651-1"
}
```
