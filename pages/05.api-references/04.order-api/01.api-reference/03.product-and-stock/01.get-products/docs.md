---
title: Order API - GET Products
altTitle: GET Products
excerpt: Returning product data from Centra with categories.
taxonomy:
  category: docs
---

# Get products

```text
GET  *base*/products
```

This will return product data from Centra with categories.

## Parameters

[parameter data="sku" datatype="string" isRequired=false sublevel=1]
Get products with a specific SKU.
[/parameter]

[parameter data="modified" datatype="date/datetime" isRequired=false sublevel=1]
Get all products modified after a certain date. Allowed formats ``YYYY-mm-dd`` and ``YYYY-mm-dd HH:MM:SS``. Timezone is system-wide and decided by the company using Centra.
[/parameter]

[parameter data="created" datatype="date/datetime" isRequired=false sublevel=1]
Get all products added after a certain date. Allowed formats ``YYYY-mm-dd`` and ``YYYY-mm-dd HH:MM:SS``. Timezone is system-wide and decided by the company using Centra.
[/parameter]

[parameter data="ean" datatype="string" isRequired=false sublevel=1]
Get a product with specified EAN code.
[/parameter]

[parameter data="productId variantId stockItemID" datatype="int" isRequired=false sublevel=1]
Filter products based on product, variant and stock item IDs.
[/parameter]

[parameter data="limit" datatype="int" isRequired=false sublevel=1]
You will get this amount of products, and a "next" parameter in return if there are multiple pages. This will go a lot faster to fetch, instead of fetching all products at once.
[/parameter]

[parameter data="include" datatype="string" isRequired=false sublevel=1]
``include=attributes`` will also make the products include the custom attributes defined for each product and variant.
[/parameter]

[parameter data="xml" datatype="boolean" isRequired=false sublevel=1]
Response in xml format instead of json.
[/parameter]

## Request example

```http request
   GET <base>/products HTTP/1.1
   Content-type: application/json
```

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="products" datatype="array" isRequired=true sublevel=1]
List of the products.
[/parameter]

[parameter data="products" datatype="array" sublevel=1]
List of the products.
[/parameter]

[parameter data="sku" datatype="string" sublevel=2]
SKU for this product.
[/parameter]

[parameter data="product" datatype="string" sublevel=2]
The internal name for this product.
[/parameter]

[parameter data="productId" datatype="int" sublevel=2]
ID for this product.
[/parameter]

[parameter data="name" datatype="string" sublevel=2]
The externally facing name for this product.
[/parameter]

[parameter data="variantSku" datatype="string" sublevel=2]
SKU for this variant.
[/parameter]

[parameter data="variantId" datatype="int" sublevel=2]
ID for this variant.
[/parameter]

[parameter data="sizeSku" datatype="string" sublevel=2]
SKU for this size.
[/parameter]

[parameter data="stockItemId" datatype="int" sublevel=2]
ID for this specific stock item.
[/parameter]

[parameter data="ean" datatype="string" sublevel=2]
The EAN for this product item size.
[/parameter]

[parameter data="weight" datatype="decimal2 (0.00)" sublevel=2]
The weight specified for this product.
[/parameter]

[parameter data="weightUnit" datatype="string" sublevel=2]
The unit used for the weight.
* ``kg``
* ``lb``
[/parameter]

[parameter data="size" datatype="string" sublevel=2]
Name of the size for this specific product item.
[/parameter]

[parameter data="active" datatype="boolean" sublevel=2]
If the product item is active or not.
[/parameter]

[parameter data="folder" datatype="string" sublevel=2]
String with names of the folders the product belongs to.

Like this: ``Collection / Jackets``.
[/parameter]

[parameter data="countryOfOrigin" datatype="string" sublevel=2]
ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc)
[/parameter]

[parameter data="store" datatype="string" sublevel=2]
Store name product is related to.
[/parameter]

[parameter data="categories" datatype="array|string" sublevel=2]
Array with names of the categories the product belongs to.

Like this: ``["Collection / Jackets\/Outerwear", "..."]``.
[/parameter]

[parameter data="images" datatype="array|string" sublevel=2]
URLs with the images connected to this product item.

Like this: ``["https://xxx.centracdn.net/x/y/z.jpg", "https://..."]``.
[/parameter]

[parameter data="prices" datatype="array" sublevel=2]
Array of the pricelists for this product.
[/parameter]

[parameter data="id" datatype="int" sublevel=3]
ID of the pricelist.
[/parameter]

[parameter data="pricelist" datatype="string" sublevel=3]
Name of the pricelist.
[/parameter]

[parameter data="price" datatype="string" sublevel=3]
Price for the product in this pricelist.
[/parameter]

[parameter data="currency" datatype="string" sublevel=3]
ISO code of the currency for this pricelist.
[/parameter]

[parameter data="campaigns" datatype="array" sublevel=3]
List of campaigns this product is connected to in this pricelist.
[/parameter]

[parameter data="id" datatype="int" sublevel=4]
ID of the campaign.
[/parameter]

[parameter data="campaign" datatype="string" sublevel=4]
Name of the campaign.
[/parameter]

[parameter data="price" datatype="decimal2 (0.00)" sublevel=4]
The price when this campaign is applied to the price. Currency will always be the same as in the pricelist.
[/parameter]

[parameter data="previous" datatype="string" isRequired=false sublevel=1]
Will contain a URL to the previous page.
[/parameter]

[parameter data="next" datatype="string" isRequired=false sublevel=1]
Will contain a URL to the next page.
[/parameter]

## Response example

```json
   {
     "status": "ok",
     "products": [
       {
         "sku": "M411-740",
         "productId": 232,
         "variantSku": "",
         "variantId": 1211,
         "sizeSku": "",
         "brand": "Odd Molly",
         "collection": "Molly Prefall 2011",
         "product": "bakers cross 3\/4 blouse",
         "variant": "LITE ROSE",
         "size": "3",
         "stockItemId": 3424,
         "ean": "",
         "weight": 0.17,
         "weightUnit": "kg",
         "countryOfOrigin": "PT",
         "harmCode": "6206300090",
         "harmDescription": "Cotton - blouse",
         "active": 0,
         "folder": "Folder 1 / Folder 2"
         "name": "Bakers Cross",
         "description": "",
         "shortDescription": "",
         "comment": "",
         "store": "Retail",
         "categories": [
           "Collection \/ Jackets\/Outerwear",
           "New Arrivals"
         ],
         "images": [
           "https:\/\/...\/images\/1_0d2f67cd05.jpg",
           "https:\/\/...\/images\/1_318da2ad06.jpg",
           "https:\/\/...\/images\/1_c4e1c20d34.jpg"
         ],
         "prices": [
           {
             "id": "36",
             "price": "329.00",
             "pricelist": "EUR Europe",
             "currency": "EUR",
             "campaigns": [
               {
                 "id": "40",
                 "campaign": "OUTLET 50% NY",
                 "price": 164.5
               }
             ]
           },
           {
             "id": "35",
             "price": "269.00",
             "pricelist": "GBP",
             "currency": "GBP",
             "campaigns": [
               {
                 "id": "40",
                 "campaign": "OUTLET 50% NY",
                 "price": 134.5
               }
             ]
           }
         ]
       },
       {
         "sku": "M411-740",
         "productId": 232,
         "variantSku": "",
         "variantId": 1211,
         "sizeSku": "",
         "brand": "Odd Molly",
         "collection": "Molly Prefall 2011",
         "product": "bakers cross 3\/4 blouse",
         "variant": "LITE ROSE",
         "size": "4",
         "stockItemId": 3425,
         "ean": "",
         "weight": 0.17,
         "weightUnit": "kg",
         "countryOfOrigin": "PT",
         "harmCode": "6206300090",
         "harmDescription": "Cotton - blouse",
         "active": 0,
         "name": "Bakers Cross",
         "description": "",
         "shortDescription": "",
         "comment": "",
         "store": "Retail",
         "categories": [
           "Collection \/ Jackets\/Outerwear",
           "New Arrivals"
         ],
         "images": [
           "https:\/\/...\/images\/1_0d2f67cd05.jpg",
           "https:\/\/...\/images\/1_318da2ad06.jpg",
           "https:\/\/...\/images\/1_c4e1c20d34.jpg"
         ]
         "prices": [
           {
             "id": "36",
             "price": "329.00",
             "pricelist": "EUR Europe",
             "currency": "EUR",
             "campaigns": [
               {
                 "id": "40",
                 "campaign": "OUTLET 50% NY",
                 "price": 164.5
               }
             ]
           },
           {
             "id": "35",
             "price": "269.00",
             "pricelist": "GBP",
             "currency": "GBP",
             "campaigns": [
               {
                 "id": "40",
                 "campaign": "OUTLET 50% NY",
                 "price": 134.5
               }
             ]
           }
         ]
       }
     ],
     "previous": "?limit=10&page=2",
     "next": "?limit=10&page=3"
   }
```
