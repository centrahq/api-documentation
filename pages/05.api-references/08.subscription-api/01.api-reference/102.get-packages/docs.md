---
title: Subscription API - Get packages
altTitle: Get packages
excerpt: Receive a list of all the active packages and their price in the provided pricelist.
taxonomy:
  category: docs
---

# Get packages

```text
GET  *base*/subscription/packages
```

Receive a list of all the active packages and their price in the provided pricelist.
## Parameters

[parameter data="pricelist" datatype="string" isRequired=true sublevel=1]
Name of pricelist to list packages for.
[/parameter]

## Request example

```http
    GET <base>/subscription/packages?pricelist=SEK HTTP/1.1
    Content-Type: application/x-www-form-urlencoded
```

## Response

`200` `Content-type: application/json`

[parameter data="packages" datatype="array" isRequired=true sublevel=1]
List of all packages in the selected currency.
[/parameter]

[parameter data="id" datatype="int" isRequired=true sublevel=2]
ID of the package
[/parameter]

[parameter data="name" datatype="string" sublevel=2]
Name of the package
[/parameter]

[parameter data="price" datatype="string" sublevel=2]
Price amount for the package
[/parameter]

[parameter data="currency" datatype="string" sublevel=2]
Currency code for the package. ``SEK``, ``USD``, ``EUR``, etc.
[/parameter]

[parameter data="products" datatype="array" sublevel=2]
Array of products inside the package.
[/parameter]

[parameter data="id" datatype="int" sublevel=3]
ID of the product
[/parameter]

[parameter data="size" datatype="string" sublevel=3]
Size name of the product selected in the package.
[/parameter]

[parameter data="variant" datatype="string" sublevel=3]
Variant name of the product selected in the package.
[/parameter]

[parameter data="product" datatype="string" sublevel=3]
Product name
[/parameter]

## Response examples

```http
   HTTP/1.1 200 OK
   Content-type: application/json

{
     "packages": [
       {
         "id": 1,
         "name": "Super Package 5000",
         "price": "123.50",
         "currency": "SEK",
         "products": [
           {
             "id": "1",
             "size": "S",
             "variant": "Red",
             "product": "T-shirt"
           }
         ]
       },
       {
         "id": 2,
         "name": "Super Package 10000",
         "price": "246.50",
         "currency": "SEK",
         "products": [
           {
             "id": "1",
             "size": "L",
             "variant": "Red",
             "product": "T-shirt"
           }
         ]
       }
     ]
   }
```


