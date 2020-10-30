---
title: Order API - Accept Supplier Delivery
altTitle: Accept Supplier Delivery
excerpt: Accepting the delivery with the proper quantities in the physical delivery
taxonomy:
  category: docs
---

# Accept supplier delivery

```text
POST  *base*/supplier-deliveries/*supplierDeliveryId*
```

```text
POST  *base*/supplier-deliveries/*supplierDeliveryId*/sku
```

Will accept the delivery with the proper quantities in the physical delivery. This will be inserted into the preferred warehouse.

[notice-box=info]This can only be done once per supplier delivery.[/notice-box]

It is possible to over deliver or under deliver when accepting the delivery. This will be visible inside Centra when delivery was accepted.

In case of under delivery a new delivery containing the undelivered products will be created.

## Parameters

[parameter data="products" datatype=object isRequired=true storetype="b2b b2c" sublevel=1]
Key is from the :ref:`Get supplier delivery <order-api-get-supplier-delivery>` and value is the ``quantity``.
[/parameter]

[parameter data="key in object" isRequired=true datatype="string" sublevel=2]
Use ``ean`` from the :ref:`Get supplier delivery <order-api-get-supplier-delivery>` referring to a specific product item in the supplier order delivery.
If the endpoint used is ``/sku``, the combination of ``sku``, ``variantSku`` and ``sizeSku`` should be used instead.
Example: ``{"products":{"1441":2}}`` will create a shipment of 2 products from item ``1441``.
[/parameter]

[parameter data="value in object" isRequired=true datatype="int" sublevel=2]
Quantity of the item that should be accepted.
[/parameter]

[parameter data="insertStock" isRequired=false datatype="boolean" sublevel=1]
Default ``true``. Flag that defines whether to insert items to warehouse stock.
* ``"insertStock": true`` insert items to warehouse stock 
* ``"insertStock": false`` do not insert items to warehouse stock
[/parameter]

[parameter data="xml" isRequired=false datatype="boolean" sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

Both `id` and `deliveryId` from [List supplier deliveries](list-supplier-deliveries) can be used to accept a supplier delivery.

```http
   POST <base>/supplier-delivery/364 HTTP/1.1
   Content-type: application/json

   {
     "products": {
       "73213213123": 32,
       "73213213124": 12,
     },
     "insertStock": false
   }
```

### Accept using SKU instead of EAN

Append /sku to the URL and switch from EAN to SKU for the product keys.

```http
   POST <base>/supplier-delivery/364/sku HTTP/1.1
   Content-type: application/json

   {
     "products": {
       "PRODSKUVARIANTSKUSIZESKU": 32,
       "PRODSKUVARIANTSKUSIZESKU2": 12,
     }
   }
```

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true storetype="b2b b2c" sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="additionalDelivery" datatype="object" isRequired=false storetype="b2b b2c" sublevel=1]
If not all products from the supplier order delivery was accepted, this is the new created delivery for the remaining products of the supplier order delivery.
[/parameter]

[parameter data="id" datatype="string" sublevel=2]
Internal ID for the created supplier order delivery.
[/parameter]

[parameter data="deliveryId" datatype="string" sublevel=2]
ID of the supplier order delivery. This is the ID communicated externally.
[/parameter]

[parameter data="orderId" datatype="string" sublevel=2]
ID of the supplier order.
[/parameter]

[parameter data="supplierCountry" datatype="string" sublevel=2]
ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc).
[/parameter]

[parameter data="created" datatype="datetime" sublevel=2]
The date this supplier order delivery was created.
[/parameter]

[parameter data="ETA" datatype="datetime" sublevel=2]
Estimated time of arrival to the warehouse. This will be used to calculate what orders that should be automatically connected to this specific delivery.
[/parameter]

[parameter data="ETD" datatype="datetime" sublevel=2]
Estimated time of delivery for the customer.
[/parameter]

[parameter data="productsQty" datatype="int" sublevel=2]
The total quantity of products remaining in the accepted supplier order delivery.
[/parameter]

## Response example

```json
   {
     "status":"ok",
     "additionalDelivery": {
       "id": "365",
       "orderId": "957",
       "deliveryId": "957-2",
       "supplierName": "Falca",
       "supplierCountry": "ES",
       "created": "2019-01-28 01:15",
       "ETD": "2019-03-31 15:15",
       "ETA": "2019-04-05 20:15",
       "message": "Text entered by centra admin",
       "productsQty": 19891
     }
   }
```
