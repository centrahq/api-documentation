---
title: Order API - Complete Shipment
altTitle: Complete Shipment
excerpt: Completing Shipment.
taxonomy:
  category: docs
---

# Complete shipment

Endpoint: `POST  *base*/shipment`  
Authentication: [API Key](/api-references/api-intro#authentication)

This will insert back the tracking number and carrier information to Centra. An email will be sent out to the customer with the tracking information.

Remember, for the Shipment to be completed, it has to be paid, Good-to-go, and shipped.

[notice-box=info]
You can select if you want to capture the order, this is often used if the shipments are already created inside Centra. You will get an error as response if the capture did not go through.
[/notice-box]

## Parameters

[parameter data="order" datatype="int" isRequired=true sublevel=1]
Order ID to which the shipment belongs.
[/parameter]

[parameter data="shipment" datatype="int" isRequired=true sublevel=1]
Shipment ID for the shipment to complete.
[/parameter]

[parameter data="capture" datatype="boolean" sublevel=1]
Default: ``true``. Try to capture the order. Ignored if the capture was already made earlier for the shipment.
[/parameter]

[parameter data="gtg" datatype="boolean" sublevel=1]
Good-to-go. Indicates the items are packed and ready to leave the Warehouse. Required for shipment to complete.
[/parameter]

[parameter data="shipped" datatype="boolean" sublevel=1]
Indicates the items have been shipped. Required for shipment to complete.
[/parameter]

[parameter data="carrier" datatype="string" isRequired=false sublevel=1]
Carrier used for shipping.
[/parameter]

[parameter data="service" datatype="string" isRequired=false sublevel=1]
Service level used for shipping.
[/parameter]

[parameter data="packages" datatype="int" isRequired=false sublevel=1]
Number of packages in shipment.
[/parameter]

[parameter data="tracking" datatype="string" isRequired=false sublevel=1]
Tracking number for shipment.
[/parameter]

[parameter data="returnSlipTracking" datatype="string" isRequired=false sublevel=1]
Return slip tracking number for shipment.
[/parameter]

[parameter data="sendEmail" datatype="boolean" isRequired=false sublevel=1]
Decide if Shipping Confirmation e-mail should be sent. If not defined, Store setting "Send Shipping Confirmation" will be used instead.
[/parameter]

[parameter data="internalComment" datatype="string" isRequired=false sublevel=1]
Append some text to internal comment field.
[/parameter]

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

```http
   PUT <base>/shipment HTTP/1.1
   Content-type: application/json

   {
     "order": "83651",
     "shipment": "83651-1",
     "carrier": "Fedex",
     "service": "Express",
     "packages": 1,
     "tracking": "TRTTET5",
     "returnSlipTracking": "TRTTET6",
     "capture": 1
   }
```

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="order" datatype="int" sublevel=1]
Order ID that was completed.
[/parameter]

[parameter data="shipment" datatype="string" sublevel=1]
Shipment ID that was completed.
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
