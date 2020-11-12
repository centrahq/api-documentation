---
title: Order API - Delete Shipment
altTitle: Delete Shipment
excerpt: Deleting the shipment completely
taxonomy:
  category: docs
---

# Delete shipment

```text
DELETE  *base*/shipments/*shipmentId*[?xml=1]
```
Authentication : [API Key](/api-references/api-intro#authentication)

This will delete the shipment completely. Will only work if the shipment does not have any invoices or credit notes connected to it.

## Parameters

[parameter data="shipmentId" datatype="string" isRequired=false sublevel=1]
The ``shipmentId`` from :ref:`Get shipments <order-api-get-shipments>` or :ref:`Create shipment <order-api-create-shipment>`.
[/parameter]

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

```http
   DELETE <base>/shipments/*shipmentId* HTTP/1.1
```

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="order" datatype="int" sublevel=1]
Order ID for the shipment that was deleted.
[/parameter]

[parameter data="shipment" datatype="string" sublevel=1]
Shipment ID for the shipment that was deleted.
[/parameter]

[parameter data="msg" datatype="string" isRequired=false sublevel=1]
If ``status`` returns ``no``, this value should send back a message why it failed.
[/parameter]

## Response example

```json
   {
     "status": "ok",
     "msg": "shipment removed",
     "order": 8,
     "shipment": "8-1"
   }
```

## Error example

```json
   {
     "status": "no",
     "msg": "shipment has invoices or creditnotes and could not be deleted.",
     "shipment": "3-1"
   }
```
