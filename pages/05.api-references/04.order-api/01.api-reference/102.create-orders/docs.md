---
title: Order API - Batch Create Orders
altTitle: Batch Create Orders
excerpt: Batch Create Orders.
taxonomy:
  category: docs
---

# Batch create orders

```text
POST  *base*/orders
```
Authentication : [API Key](/api-references/api-intro#authentication)

You are able to insert multiple orders at the same time by changing the endpoint from `<base>/order` to `<base>/orders` and sending data for each order inside an object with defined keys. You will get back responses for each order using the same defined keys you sent.

## Parameters

The request consists of a JSON object with names for each element. The content of each element should be an order object, specified in [Create Order](/api-references/order-api/api-reference/create-order). The name for each element is then used in the response to map against either a success response or an error for each order.

[parameter data="foo bar etc ..." datatype="order object" isRequired=true sublevel=1]
The name of each element could be anything you like. The content of each element are exactly like the parameters for :ref:`Create Order <create-order-parameters>`.
[/parameter]

## Request example

```http
   POST <base>/orders HTTP/1.1
   Content-type: application/json

   {
     "x123": {
       "invoiceAddress": {
         "country": "SE",
         "firstName": "John",
         "lastName": "Smith",
         "address": "12 Alto Road",
         "coaddress": "c/o Peter",
         "zipcode": "90212",
         "city": "San Francisco",
         "email": "x@example.com"
       },
       "deliveryAddress": {
         "country": "US",
         "firstName": "John",
         "lastName": "Smith",
         "address": "1500 California St",
         "coaddress": "c/o Peter",
         "zipcode": "90210",
         "city": "San Francisco",
         "state": "CA"
       },
       "products": [
         {
          "qty": 2,
          "ean": "ABCDEFGHIJKL",
          "unitPrice": 14.11,
          "originalPrice": 100.11,
          "itemText" : {
            "sku": "SPECIAL-SKU-FOR-THIS-ONE",
            "product": "A special product",
            "variant": ""
          }
         },
         {
          "qty": 1,
          "sku": "SKUASKUBSKUC",
          "unitPrice": 12.11,
          "originalPrice": 50.22
         }
       ]
     },
     "a1": {
       "...": "..."
     }
   }
```

## Response
`200` `Content-type: application/json`

[parameter data="foo bar etc ..." datatype="object" isRequired=true sublevel=1]
Object with fields for each order using the names from the request.
[/parameter]

[parameter data="status" datatype="string" isRequired=true sublevel=2]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="order" datatype="nt" isRequired=false sublevel=2]
Will return if ``createOnly`` was set as ``true``.
[/parameter]

[parameter data="orders" datatype="array of int" isRequired=false sublevel=2]
List of order numbers created. An order might split up in multiple orders after completing it, this is why you might get multiple orders back.
[/parameter]

[parameter data="msg" datatype="string" isRequired=false sublevel=2]
If ``status`` returns ``no``, this value should send back a message why it failed.
[/parameter]

## Response examples

```json
   {
     "x123": {
       "status": "ok",
       "orders": [
         1234
       ]
     },
     "a1": {
       "status": "ok",
       "orders": [
         1235
       ]
     }
   }
```

Response if `createOnly` is `true`:

```json
   {
     "x123": {
       "status": "ok",
       "order": 1234
     },
     "a1": {
       "status": "ok",
       "order": 1235
     }
   }
```

## Error examples

```json
   {
     "x123": {
       "status": "no",
       "msg": "Message about why the order failed to be created."
     },
     "a1": {
       "status": "no",
       "msg": "Message about why the order failed to be created."
     }
   }
```

Since you can insert multiple orders at the same time, some orders might succeed where others fail. Here's an example with two orders that failed and one that succeeded:

```json
   {
     "x123": {
       "status": "no",
       "msg": "Message about why the order failed to be created."
     },
     "a1": {
       "status": "no",
       "msg": "Message about why the order failed to be created."
     },
     "a2": {
       "status": "ok",
       "orders": [
         1235
       ]
     }
   }
```
