---
title: Order API - Create Return
altTitle: Create Return
excerpt: Creating return for given shipment and items
taxonomy:
  category: docs
---

# Create return

```text
POST  *base*/return
```

This will create return for given shipment and items. Return will be created even if some of the provided items cannot be returned.

## Parameters

[parameter data="shipment" datatype="string" isRequired=true sublevel=1]
The ``shipmentId`` from :ref:`Get shipments <order-api-get-shipments>` or :ref:`Create shipment <order-api-create-shipment>`.
[/parameter]

[parameter data="products" datatype="object" isRequired=false sublevel=1]
Key is ``lineID`` from the :ref:`Get shipments <order-api-get-shipments>` and value is the ``quantity``.
Example: ``{"products":{"1441":2}}`` will create a return of 2 products from item ``1441``.
[/parameter]

[parameter data="key in object" datatype="string" isRequired=true sublevel=2]
``lineID`` from the :ref:`Get shipments <order-api-get-shipments>` referring to a specific product item in the order.
[/parameter]

[parameter data="value in object" datatype="int" isRequired=true sublevel=2]
Quantity of the item that should be returned.
[/parameter]

[parameter data="returnStock" datatype="boolean" isRequired=false sublevel=1]
Insert returned items into stock. If not provided ``Default stock action on return`` setting on the store will be used.
[/parameter]

[parameter data="handlingCost" datatype="float" isRequired=false sublevel=1]
Handling cost.
[/parameter]

[parameter data="handlingCostFromShipment" datatype="boolean" isRequired=false sublevel=1]
Default `false`. Set to `true` to use Handling cost from Shipment. You cannot provide handlingCost at the same time this option is used.
[/parameter]

[parameter data="shippingCost" datatype="float" isRequired=false sublevel=1]
Shipping cost.
[/parameter]

[parameter data="shippingCostFromShipment" datatype="boolean" isRequired=false sublevel=1]
Default `false`. Set to `true` to use Shipping cost from Shipment. You cannot provide shippingCost at the same time this option is used.
[/parameter]

[parameter data="returnCost" datatype="float" isRequired=false sublevel=1]
Return cost. If the return itself should have a cost to it. Providing a value here will deduct the amount of money to refund.
[/parameter]

[parameter data="voucherValue" datatype="float" isRequired=false sublevel=1]
Voucher value, should always be positive value.
[/parameter]

[parameter data="voucherValueFromShipment" datatype="boolean" isRequired=false sublevel=1]
Default `false`. Set to `true` to use Voucher value from Shipment. You cannot provide voucherValue at the same time this option is used.
[/parameter]

[parameter data="comment" datatype="string" isRequired=false sublevel=1]
Additional comment for return, for reference.
[/parameter]

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

[parameter data="createdAt" datatype="date/datetime" isRequired=false sublevel=1]
Additional datetime one of the format ``YYYY-MM-DD`` or ``YYYY-MM-DD HH:MM:SS`` like ``2015-12-24 13:25:01``. Timezone is system-wide and decided by the company using Centra.
[/parameter]

[parameter data="refund" datatype="object" isRequired=false sublevel=1]
Refund object.
Example: ``{"refund":{"refundPayment": true}}`` will make refund from return.
[/parameter]

[parameter data="refundPayment" datatype="boolean" isRequired=false sublevel=2]
If this is set to true the payment provider will get a refund request to pay back the money to the customer. The amount that will be refunded is the amount for the products, the handling, shipping and return costs. If the refund is successful against the payment provider, the ``returnCompleted`` will be ``true`` in the response.
[/parameter]

[parameter data="sendEmail" datatype="boolean" isRequired=false sublevel=2]
Send refund email. Default value is ``false``.
[/parameter]

## Request example

```http
   POST <base>/return HTTP/1.1
   Content-type: application/json

   {
     "shipment": "120276-1",
     "returnStock": 1,
     "comment": "Return created with Order Api",
     "products": {
       "268871": "1",
       "268870": "1"
     }
   }
```

## Request example including refund

```http
   POST <base>/return HTTP/1.1
   Content-type: application/json

   {
     "shipment": "120276-1",
     "returnStock": 1,
     "comment": "Return created with Order Api",
     "products": {
       "268871": "1",
       "268870": "1"
     },
     "refund": {
       "refundPayment": true,
       "sendEmail": true
     }
   }
```

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="order" datatype="int" isRequired=false sublevel=1]
Order ID that was captured.
[/parameter]

[parameter data="return" datatype="int" isRequired=false sublevel=1]
Return ID that was created.
[/parameter]

[parameter data="returnCompleted" datatype="boolean" isRequired=false sublevel=1]
If the return was completed directly on creation, this can only happen if a successful refund was made when return was created.
[/parameter]

[parameter data="msg" datatype="string" isRequired=false sublevel=1]
If ``status`` returns ``no``, this value should send back a message why it failed.
[/parameter]

## Response example

```json
   {
     "status": "ok",
     "return": 5397,
     "returnCompleted": false,
     "returnedItems": [
       "268871"
     ]
   }
```

## Response example including refund

```json
   {
     "status": "ok",
     "return": 5397,
     "returnCompleted": true,
     "returnedItems": [
       "268871"
     ],
     "refund": {
       "status": "ok"
     }
   }
```

## Error example

```json
   {
     "status": "no",
     "msg": "return could not be created."
   }
```
