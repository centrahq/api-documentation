---
title: Order API - Create Shipment
altTitle: Create Shipment
excerpt: Creating a shipment and per default try to capture from the payment provider
taxonomy:
  category: docs
---

# Create shipment

`POST  *base*/shipments`  
Authentication : [API Key](/api-references/api-intro#authentication)

This will create a shipment and per default try to capture from the payment provider, shipment will not be created if the capture fails.

[notice-box=alert]
You have the ability to turn off capture to make it possible to edit the shipment after it has been created. However, if you explicitly turn off capture using ``"capture": false``, we will not capture the money for the order automatically, and the [Order API complete shipment](/api-references/order-api/api-reference/complete-shipment) call MUST be made and verified that it was successful until you can ship any products.
[/notice-box]

## Parameters

[parameter data="order" datatype="int" isRequired=true sublevel=1]
Order ID to create shipment on.
[/parameter]

[parameter data="products" datatype="object" isRequired=true sublevel=1]
Key is ``lineID`` from the [Get orders response](/api-references/order-api/api-reference/get-orders#response) and value is the ``quantity``.
Example: ``{"products":{"1441":2}}`` will create a shipment of 2 products from item ``1441``.
[/parameter]

[parameter data="key in object" datatype="string" isRequired=true sublevel=2]
``lineID`` from the [Get orders response](/api-references/order-api/api-reference/get-orders#response) referring to a specific product item in the order.
[/parameter]

[parameter data="value in object" datatype="int" isRequired=true sublevel=2]
Quantity of the item that should be shipped.
[/parameter]

[parameter data="gtg" datatype="boolean" isRequired=false sublevel=1]
Default: ``false``. Mark the shipment as good to go.
[/parameter]

[parameter data="capture" datatype="boolean" isRequired=false sublevel=1]
Default: ``true``. If Centra should capture the shipment amount from the payment provider.
[notice-box=alert]
Should not be turned off unless you are capturing the money somewhere else.
[/notice-box]
[/parameter]

[parameter data="shipped" datatype="boolean" isRequired=false sublevel=1]
Mark the shipment as sent. Default: ``false``.
[/parameter]

[parameter data="carrier" datatype="string" isRequired=false sublevel=1]
Carrier used for shipping. Only used if ``shipped`` is ``true``.
[/parameter]

[parameter data="service" datatype="string" isRequired=false sublevel=1]
Service level used for shipping. Only used if ``shipped`` is ``true``.
[/parameter]

[parameter data="packages" datatype="int" isRequired=false sublevel=1]
Number of packages in shipment. Only used if ``shipped`` is ``true``.
[/parameter]

[parameter data="tracking" datatype="string" isRequired=false sublevel=1]
Tracking number for shipment. Only used if ``shipped`` is ``true``.
[/parameter]

[parameter data="returnSlipTracking" datatype="string" isRequired=false sublevel=1]
Return slip tracking number for shipment. Only used if ``shipped`` is ``true``.
[/parameter]

[parameter data="sendEmail" datatype="boolean" isRequired=false sublevel=1]
Decide if Shipping Confirmation e-mail should be sent. If not defined, Store setting "Send Shipping Confirmation" will be used instead. Only used if ``shipped`` is ``true``.
[/parameter]

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

```http
POST <base>/shipments HTTP/1.1
Content-type: application/json

{
  "order": 83651,
  "products": {
    "43243": 1,
    "43244": 2
  }
}
```

<!--
```eval_rst
.. _create-shipment-response:
```
-->

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="order" datatype="int" sublevel=1]
Order ID that the shipment was created on.
[/parameter]

[parameter data="shipment" datatype="string" sublevel=1]
The shipment ID for the create shipment.
[/parameter]

[parameter data="deliveryNote" datatype="string" isRequired=false sublevel=1]
URL to a PDF delivery note for the shipment.
[/parameter]

[parameter data="proforma" datatype="string" isRequired=false sublevel=1]
URL to a PDF proforma for the shipment.
[/parameter]

[parameter data="invoice" datatype="string" isRequired=false sublevel=1]
URL to a PDF invoice for the shipment. Will only be set if an invoice exists.
[/parameter]

[parameter data="msg" datatype="string" isRequired=false sublevel=1]
If ``status`` returns ``no``, this value should send back a message why it failed.
[/parameter]

## Response example

```http
HTTP/1.1 200 OK
Content-type: application/json

{
  "status": "ok",
  "order": 83651,
  "shipment": "83651-1",
  "deliveryNote": "http://.../delivery-note.pdf",
  "proforma": "http://.../proforma.pdf",
  "invoice": "http://.../invoice.pdf"
}
```

## Error examples

```json
{
  "status": "no",
  "msg": "order does not exist",
  "order": "1337"
}
```

```json
{
  "msg": "can not capture order",
  "status": "no",
  "order": "5"
}
```
