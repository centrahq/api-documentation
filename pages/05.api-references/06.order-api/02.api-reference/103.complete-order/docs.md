---
title: Order API - Complete Order
altTitle: Complete Order
excerpt: Completing Order.
taxonomy:
  category: docs
---

# Complete order

Endpoint: `POST  *base*/order/*orderId*`  
Authentication: [API Key](/api-references/api-intro#authentication)

If [Create Order](/api-references/order-api/api-reference/create-order) was used with `createOnly` set as `true`, the order will only be prepared but not finalized. By using the Complete Order-endpoint you can finalize the order to be placed properly as a second step from creating the order. This might be necessary if you first need to make sure the order can be placed (Create Order) and then finalize it after you've verified the payment (Complete Order).

[notice-box=info]
You can use this endpoint multiple times for the same order, for example to save details on payment auth and capture at different times.
[/notice-box]

The Create Order call is the one validating that the products exists in stock, so if the Complete Order-call is made much later than the Create Order-call, there might be products back ordered inside the finalized order.

## Parameters

The following parameters are explained in the [Create Order](/api-references/order-api/api-reference/create-order)-call, but are also supported when completing the order.

[parameter data="payment" datatype="object" isRequired=false storetype="b2b b2c" sublevel=1]
Will contain information that should be inserted in regards to how the payment was handled outside of Centra.
[/parameter]

[parameter data="id" datatype="int" isRequired=true sublevel=2]
The ID of the payment plugin used from Centra. If not used, the order will not be marked with a payment type at all.
[/parameter]

[parameter data="auth capture" datatype="object" isRequired=false sublevel=2]
Information about the authorization and capture of the order. Authorization was the reservation of the order, capture is when the value also has been charged.
[/parameter]

[parameter data="response" datatype="string" isRequired=false sublevel=3]
The response string from the payment type. Will be shown verbose inside Centra.
[/parameter]

[parameter data="status" datatype="int" isRequired=true sublevel=3]
If the authorization/capture went through or not. ``0`` means pending, ``1`` means success, ``2`` means failed.
[/parameter]

[parameter data="transaction" datatype="string" isRequired=false sublevel=3]
The transaction ID of the authorization/capture.
[/parameter]

[parameter data="method" datatype="string" isRequired=false sublevel=3]
Will be shown on reports to summarize what payment method was used.
[/parameter]

[parameter data="amount" datatype="decimal2 (0.00)" isRequired=true sublevel=3]
The amount that was authorized.
[/parameter]

[parameter data="external_url" datatype="string" isRequired=false sublevel=3]
If an external invoice was created, insert the URL to the invoice here.
[/parameter]

[parameter data="buyerName" datatype="string" isRequired=false storetype="b2b" sublevel=1]
Name of the buyer that placed the order.
[/parameter]

[parameter data="internalComment" datatype="string" isRequired=false sublevel=1]
Text for the "Internal comment"-field. Will only be shown internally in Centra.
[/parameter]

[parameter data="poNumber" datatype="string" isRequired=false storetype="b2b" sublevel=1]
PO number used when placing the order. Will be visible on delivery notes and invoices.
[/parameter]

[parameter data="orderDate" datatype="date/datetime" isRequired=false sublevel=1]
The time when the order was placed. Timezone is based on the location of the organization's Centra settings.
[/parameter]

[parameter data="deliveryDate" datatype="date/datetime" isRequired=false sublevel=1]
Expected time of delivery.
[/parameter]

[parameter data="cancelDate" datatype="date/datetime" isRequired=false sublevel=1]
Date when order should be cancelled if not confirmed.
[/parameter]

[parameter data="warehouseGroup" datatype="string" isRequired=false sublevel=1]
Used to define which allocation rule (previously known as "warehouse group") it should use. Default will use the one set for the market.
[/parameter]

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

```http
POST <base>/order/123 HTTP/1.1
Content-type: application/json

{
  "comment": "Completed order, here is a comment"
}
```

## Response

`200` `Content-type: application/json`


[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="orders" datatype="array of string" sublevel=1]
List of order numbers created. An order might split up in multiple orders after completing it, this is why you might get multiple orders back.
[/parameter]

[parameter data="msg" datatype="string" isRequired=false sublevel=1]
If ``status`` returns ``no``, this value should send back a message why it failed.
[/parameter]

## Response example

```json
{
  "orders": [
    "44"
  ],
  "status": "ok"
}
```

## Error example

```json
{
  "status": "no",
  "msg": "Message about why the order failed to be completed."
}
```
