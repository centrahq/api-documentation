---
title: Shop API - Get Filtered Products
altTitle: Get Filtered Products
excerpt: Fetching a list products based on filters.
taxonomy:
  category: docs
---

# Get filtered products

`POST  *base*/products/filter`

Fetches a list of products based on the provided filter parameters. The GET calls below filter the product list on the parameter given in the URI. If you want to filter on several fields at once, you should use POST to `/products/filter`.

<!--
```eval_rst
.. _shop-api-filter-products-parameters:
```
-->

## Parameters

One, or many (for POST), of the following parameters can be specified:

[parameter data="products" datatype="string or array" isRequired=false storetype="b2b b2c" sublevel=1]
Product IDs, passed as string or array of strings
``"products": "123"`` or ``"products": ["124", "125"]``
[/parameter]

[parameter data="uri" datatype="string" isRequired=false storetype="b2b b2c" sublevel=1]
Product URI
``"uri": "the-uri-of-the-product"``
[/parameter]

[parameter data="quantity" datatype="int" isRequired=false storetype="b2b b2c" sublevel=1]
Maximum amount of returned products.
[/parameter]

[parameter data="offset" datatype="int" isRequired=false storetype="b2b b2c" sublevel=1]
Offset in the filtered list from where results will be returned
[/parameter]

[parameter data="silkProduct" datatype="string" isRequired=false storetype="b2b b2c" sublevel=1]
Centra product ID.
[/parameter]

[parameter data="silkVariant" datatype="string" isRequired=false storetype="b2b b2c" sublevel=1]
Centra variant ID.
[/parameter]

[parameter data="categories" datatype="string or array of strings" isRequired=false storetype="b2b b2c" sublevel=1]
Filter on the category ID for the products.
``"categories": "123"`` or ``"categories": ["123", "124"]``.
[/parameter]

[parameter data="sku" datatype="string" isRequired=false storetype="b2b b2c" sublevel=1]
Filter on product SKU.
[/parameter]

[parameter data="market" datatype="string or int" isRequired=false storetype="b2b b2c" sublevel=1]
Filter on market ID.
[/parameter]

[parameter data="preview" datatype="boolean" isRequired=false storetype="b2b b2c" sublevel=1]
Return products not being activated yet.
* ``"preview": true`` return products for preview
* ``"preview": false`` only return live products
[/parameter]

## Request example

```http
POST <base>/products/filter HTTP/1.1
Content-type: application/json

{
  "market": 123,
  "products": ["514", "515"],
  "categories": 1
}
```

## Response

`200` `Content-type: application/json`

The object returned will have the `productId` for each product as the key. The product object is explained under [Product data model](shop-api-product-data-model).

## Response example

```http
HTTP/1.1 200 OK
Content-type: application/json

{
  "1": {"product-object"},
  "2": {"product-object"},
}
```

## Error example

```http
HTTP/1.1 404 Not Found
Content-type: application/json

{
  "errors" : {
      "categories" : "not found: 1"
  }
}
```

## Filter on categories

`GET  *base*/products/categories/*categories*`

Parameters explained under [Multi parameter filtering parameters](shop-api-filter-products-parameters).

## Filter on internal IDs

`GET  *base*/products/silk-product/*silkProduct*`

`GET  *base*/products/silk-variant/*silkVariant*`

Parameters explained under [Multi parameter filtering parameters](shop-api-filter-products-parameters).

## Filter on SKU or URI

`GET  *base*/products/sku/*sku*`

`GET  *base*/products/uri/*uri*`

Parameters explained under [Multi parameter filtering parameters](shop-api-filter-products-parameters).
