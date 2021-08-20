---
title: Order API - Get Shipments
altTitle: Get Shipments
excerpt: Fetching all Good to Go-shipments that are not sent.
taxonomy:
  category: docs
---

<!--
```eval_rst
.. _order-api-get-shipments:
```
-->

# Get shipments

`GET *base*/shipments?[&limit=5][&order=83651]`
Authentication : [API Key](/api-references/api-intro#authentication)

Will list all Good to Go-shipments that are not sent. Oldest first.

## Parameters

[parameter data="limit" datatype="int" isRequired=false sublevel=1]
Limit amount of shipments returned. For statuses `inprogress` and `completed` a positive value between 1 and 100.
[/parameter]

[parameter data="order" datatype="int" isRequired=false sublevel=1]
Return shipments for a specific order.
[/parameter]

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

[parameter data="offset" datatype="int" isRequired=false sublevel=1]
Offset how far in to start returning orders.
[/parameter]

[parameter data="status" datatype="string" isRequired=false sublevel=1]
Default value: `goodtogo`. Allowed values: `inprogress`, `goodtogo`, `completed`
[/parameter]

[parameter data="newer_than" datatype="date/datetime" isRequired=false sublevel=1]
Only return shipments newer than provided date
[/parameter]

[parameter data="older_than" datatype="date/datetime" isRequired=false sublevel=1]
Only return shipments older than provided date
[/parameter]

## Request example

`GET <base>/shipments?limit=5 HTTP/1.1`

<!--
```eval_rst
.. _get-shipments-response:
```
-->

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="shipments" datatype="array" isRequired=true sublevel=1]
Array of shipments returned.
[/parameter]

[parameter data="orderId" datatype="string" sublevel=2]
ID of the order.
[/parameter]

[parameter data="shipmentId" datatype="string" sublevel=2]
ID of the shipment.
[/parameter]

[parameter data="selectionId" datatype="string" sublevel=2]
Selection ID of the order.
[/parameter]

[parameter data="orderDate" datatype="datetime" sublevel=2]
Date when order was created.
[/parameter]

[parameter data="shouldCapture" datatype="boolean" sublevel=2]
If the shipment needs to be captured before being shipped.
[/parameter]

[parameter data="deliveryNote" datatype="string" isRequired=false sublevel=2]
URL to a PDF delivery note for the shipment.
[/parameter]

[parameter data="shippingTerms" datatype="object" isRequired=false sublevel=2]
Shipping Terms object selected on this shipment.
[/parameter]

[parameter data="id" datatype="int" sublevel=3]
Id of the specific shipping terms object.
[/parameter]

[parameter data="name" datatype="string" sublevel=3]
Name of the specific shipping terms object.
[/parameter]

[parameter data="description" datatype="string" sublevel=3]
Description of the specific shipping terms object.
[/parameter]

[parameter data="paymentTerms" datatype="object" isRequired=false sublevel=2]
Payment Terms object selected on this shipment.
[/parameter]

[parameter data="id" datatype="int" sublevel=3]
ID of the specific payment terms object.
[/parameter]

[parameter data="name" datatype="string" sublevel=3]
Name of the specific payment terms object.
[/parameter]

[parameter data="description" datatype="string" sublevel=3]
Description of the specific payment terms object.
[/parameter]

[parameter data="proforma" datatype="string" isRequired=false sublevel=2]
URL to a PDF proforma for the shipment.
[/parameter]

[parameter data="defaultCarrier" datatype="string" isRequired=false sublevel=2]
Name of the carrier for this shipment.
[/parameter]

[parameter data="deliveryService" datatype="string" isRequired=false sublevel=2]
Name of the delivery service for this shipment.
[/parameter]

[parameter data="invoices" datatype="array" isRequired=false sublevel=2]
URLs to PDF invoices for the shipment. Will only be set if any invoices exists.
[/parameter]

[parameter data="products" datatype="array" isRequired=false sublevel=2]
Products inside the shipment.
[/parameter]

[parameter data="lineId" datatype="string" sublevel=3]
ID of the specific product item in this shipment.
[/parameter]

[parameter data="qty" datatype="int" sublevel=3]
Quantity of this specific product item.
[/parameter]

[parameter data="isBundle" datatype="boolean" sublevel=3]
Flag showing if product is bundle
[/parameter]

[parameter data="isPartOfBundle" datatype="int" sublevel=3]
Bundle id
[/parameter]

[parameter data="bundle" datatype="array" sublevel=3]
Array of containing items for bundle
[/parameter]

[parameter data="taxBreakdown" datatype="array" sublevel=2]
Lists all tax rules applied to the order.
[/parameter]

[parameter data="description" datatype="string" sublevel=3]
Text description of tax rule. ex: VAT
[/parameter]

[parameter data="taxPercent" datatype="float" sublevel=3]
Percentage of tax. ex 25
[/parameter]

[parameter data="value" datatype="float" sublevel=3]
How much tax. ex 20
[/parameter]

## Response example

```http
HTTP/1.1 200 OK
Content-type: application/json

{
  "status": "ok",
  "shipments": [
    {
      "orderId": "83651",
      "selectionId": "ff805e6dc70f905553e2225c6977a27a",
      "orderDate": "2012-02-04 15:16:13",
      "cancelDate": "2012-08-04 15:16:13",
      "preferredDeliveryDate": "2012-05-04 15:16:13",
      "estimatedDeliveryDate": "2012-05-04 15:16:13",
      "orderStore": "retail",
      "orderCurrency": "EUR",
      "shipmentId": "83651-1",
      "customerId": "11627",
      "accountId": "0",
      "billingName": "Someones Name",
      "billingCompany": "",
      "billingAddress": "Examplestreet 1",
      "billingCoaddress": "",
      "billingCity": "Somecity",
      "billingState": "",
      "billingZipcode": "12345",
      "billingCountry": "DE",
      "billingEmail": "someone@example.com",
      "billingTele": "",
      "deliveryName": "Someones Name",
      "deliveryCompany": "",
      "deliveryEmail": "someone@example.com",
      "deliveryCell": "+4912345678",
      "deliveryTele": "",
      "deliveryAddress": "Examplestreet 1",
      "deliveryCoaddress": "",
      "deliveryZipcode": "12345",
      "deliveryCity": "Somecity",
      "deliveryState": "",
      "deliveryCountry": "DE",
      "billingVAT": "",
      "poNumber": "",
      "shippingList": "standard",
      "shippingTerms": {
        "id": 5, 
        "name": "ShippingTermName", 
        "description": "ShippingTermDescription"
      },
      "paymentTerms": {
        "id": 10, 
        "name": "PaymentTermName", 
        "description": "PaymentTermDescription"
      },
      "proforma": "http://.../proforma?shipment=83651-1",
      "deliveryNote": "http://../delnote?shipment=83651-1",
      "defaultCarrier": "Delivery Carrier",
      "deliveryService": "Delivery Service",
      "shipmentDate": "2019-07-01 12:56:00",
      "trackingNumber": "123456789",
      "trackingUrl": "https://www.dhl.com.pl/exp-en/express/tracking.html?AWB=123456789",
      "returnSlipTracking": "123456789",
      "invoices": [
        "https://online.klarna.com/invoice_public_show.yaws/invoice.pdf?invno=&orgno="
      ],
      "suspect": 0,
      "hold": 0,
      "paid": 1,
      "shouldCapture": 0,
      "shippingValue": 25,
      "voucherValue": 0,
      "grandTotalValue": 3978.75,
      "grandTotalTaxValue": 795.75,
      "taxAdded": 0,
      "taxDeducted": 0,
      "internalComment": "",
      "otherComment": "",
      "taxBreakdown": [
        {
          "description": "VAT",
          "taxPercent": 25,
          "value": 795.75
        }
      ],
      "products": [
        {
          "lineId": "43243",
          "sku": "S123K456U1",
          "variantSku": "",
          "sizeSku": "",
          "name": "Product #1",
          "variant": "White",
          "size": "XS",
          "ean": "1234567890123",
          "qty": 1,
          "originalPrice": 500.5,
          "price": 450.5,
          "weight": 2,
          "weightUnit": "kg",
          "countryOfOrigin": "DE",
          "harmCode": "12345",
          "comment": "",
          "warehouses": [
            {
                "name": "Default warehouse",
                "itemQty": "1"
            }
          ],
        "isBundle": false,
        "isPartOfBundle": "217"
        },
        {
          "lineId": "43244",
          "sku": "S123K456U2",
          "variantSku": "",
          "sizeSku": "",
          "name": "Product #2",
          "variant": "Blue",
          "size": "XS",
          "ean": "1234567890124",
          "qty": 2,
          "originalPrice": 200.5,
          "price": 180.5,
          "weight": 1.5,
          "weightUnit": "kg",
          "countryOfOrigin": "CI",
          "harmCode": "12345",
          "comment": "",
          "isBundle": true,
          "bundle": [
            {
              "lineId": "43243",
              "sku": "S123K456U1",
              "variantSku": "",
              "sizeSku": "",
              "name": "Product #1",
              "variant": "White",
              "size": "XS",
              "ean": "1234567890123",
              "qty": 1,
              "originalPrice": 500.5,
              "price": 450.5,
              "weight": 2,
              "weightUnit": "kg",
              "countryOfOrigin": "DE",
              "harmCode": "12345",
              "comment": "",
              "warehouses": [
                {
                    "name": "Default warehouse",
                    "itemQty": "1"
                }
              ],
            "isBundle": false,
            "isPartOfBundle": "217"
            },
        ]
        }
      ]
    }
  ]
}
```
