---
title: Order API - Get Supplier Delivery Details
altTitle: Get Supplier Delivery Details
excerpt: Getting the incoming and not accepted deliveries that are connected to the warehouse this plugin is connected to.
taxonomy:
  category: docs
---

# Get supplier delivery details

Endpoint: `GET *base*/supplier-deliveries/*supplierDeliveryId*/details`  
Authentication: [API Key](/api-references/api-intro#authentication)

Get the incoming and not accepted deliveries that are connected to the warehouse this plugin is connected to.

Deliveries will be listed when these requirements are fulfilled:

* Delivery created on a confirmed Supplier Order.
* Supplier order has the Preferred Warehouse set to the "Supplier Delivery Warehouse" in the Plugin.
* Delivery is not accepted yet.
* Delivery has items in it.

## Parameters

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

Both `id` and `deliveryId` from [List supplier deliveries](/api-references/order-api/api-reference/list-supplier-deliveries) can be used to fetch a supplier delivery.

`GET <base>/supplier-deliveries/*supplierDeliveryId* HTTP/1.1`

## Response

`200` `Content-type: application/json`


[parameter data="status" datatype="boolean" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="delivery" datatype="object" isRequired=true sublevel=1]
Information about this specific supplier order delivery.
[/parameter]

[parameter data="id" datatype="string" sublevel=2]
Internal ID for the supplier order delivery.
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
The total quantity of products in this supplier order.
[/parameter]

[parameter data="orders" datatype="array" sublevel=2]
The list of orders that has reserved products for this supplier order delivery.
[/parameter]

[parameter data="orderId" datatype="string" sublevel=3]
The order ID for the customer order.
[/parameter]

[parameter data="accountId" datatype="string" sublevel=3]
The account ID for the customer.
[/parameter]

[parameter data="accountName" datatype="string" sublevel=3]
The name of the account.
[/parameter]

[parameter data="buyer" datatype="string" sublevel=3]
The name of the buyer from account placing the order.
[/parameter]

[parameter data="carrier" datatype="string" sublevel=3]
The preferred carrier for this account.
[/parameter]

[parameter data="service" datatype="string" sublevel=3]
The preferred carrier service for this account.
[/parameter]

[parameter data="paymentTerms" datatype="string" sublevel=3]
The payment terms defined for this order.
[/parameter]

[parameter data="shippingTerms" datatype="string" sublevel=3]
The shipping terms defined for this order.
[/parameter]

[parameter data="poNumber" datatype="string" sublevel=3]
PO number used when placing the order.
[/parameter]

[parameter data="deliveryName deliveryCompany deliveryEmail deliveryCell deliveryTele deliveryAddress deliveryCoaddress deliveryZipcode deliveryCity deliveryState" datatype="string" sublevel=3]
The address the order should be delivered to.
[/parameter]

[parameter data="deliveryCountry" datatype="string" sublevel=3]
ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc).
[/parameter]

[parameter data="products" datatype="array" sublevel=3]
The product items in this supplier order delivery. Most of the fields are described in the :ref:`Get stock response <order-api-get-stock-response>` but the following ones are specific to supplier order deliveries:
[/parameter]

[parameter data="quantity" datatype="int" sublevel=4]
The amount of product items reserved from this supplier order delivery to the customer order.
[/parameter]

[parameter data="cost" datatype="string" sublevel=4]
The cost / pcs for this item.
[/parameter]

[parameter data="costCurrency" datatype="string" sublevel=4]
The currency code for the cost / pcs. ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc).
[/parameter]

## Response example

```json
{
  "status": "ok",
  "delivery": {
    "id": "364",
    "orderId": "957",
    "deliveryId": "957-1",
    "supplierName": "Falca",
    "supplierCountry": "ES",
    "created": "2019-01-28 01:15",
    "ETD": "2019-03-31 15:15",
    "ETA": "2019-04-05 20:15",
    "message": "Text entered by centra admin",
    "productsQty": 20000,
    "orders": [
      {
        "orderId": "83982",
        "accountId": "478",
        "accountName": "Internal ROW",
        "buyer": "Internal ROW, John ",
        "carrier": "",
        "service": "",
        "other": "Other Comment",
        "paymentTerms": "30 Net",
        "shippingTerms": "Ex. Works",
        "poNumber": "Pre Spring 17",
        "deliveryName": "John Doe",
        "deliveryCompany": "A Company",
        "deliveryEmail": "info@example.com",
        "deliveryCell": "",
        "deliveryTele": "0",
        "deliveryAddress": "Skogsgatan 123",
        "deliveryCoaddress": "C/O: Warehouse",
        "deliveryZipcode": "12345",
        "deliveryCity": "Stockholm",
        "deliveryState": "0",
        "deliveryCountry": "SE",
        "products": [
          {
            "sku": "12019005",
            "variantSku": "A",
            "sizeSku": "",
            "brand": "Kronan",
            "collection": "ALL",
            "product": "Bike Lady 0 speed BLACK",
            "variant": "SVART",
            "size": "ONE SIZE",
            "ean": "898989891212",
            "upc": "123456",
            "weight": 22,
            "weightUnit": "kg",
            "quantity": 122
            "cost": "9.40",
            "costCurrency": "USD"
          },
          {
            "sku": "12019007",
            "variantSku": "A",
            "sizeSku": "",
            "brand": "Kronan",
            "collection": "ALL",
            "product": "Bike Lady 0 speed BLUE",
            "variant": "BLUE",
            "size": "ONE SIZE",
            "ean": "898989891213",
            "upc": "123456",
            "weight": 22,
            "weightUnit": "kg",
            "quantity": 342,
            "cost": "12.40",
            "costCurrency": "EUR"
          }
        ]
      },
      { "orderId": "..."}
    ]
  }
}
```
