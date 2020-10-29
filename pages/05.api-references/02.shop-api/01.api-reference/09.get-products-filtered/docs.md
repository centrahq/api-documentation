---
title: Shop API - GET Filtered Products
altTitle: GET Filtered Products
excerpt: Fetching a list products based on filters.
taxonomy:
  category: docs
---

# Get filtered products

```text
POST  *base*/products/filter
```

<!--
```eval_rst
.. api-name:: Shop API
   :version: 1

.. endpoint::
   :method: POST
   :url: *base*/products/filter

.. authentication::
   :api_key: true
```
-->

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

<!--
```eval_rst
.. list-table::
   :widths: auto

   * - ``products``

       .. type:: string or array
          :required: false

     - Product IDs, passed as string or array of strings

       ``"products": "123"`` or ``"products": ["124", "125"]``

   * - ``uri``

       .. type:: string
          :required: false

     - Product URI

       ``"uri": "the-uri-of-the-product"``

   * - ``quantity``

       .. type:: int
          :required: false

     - Maximum amount of returned products.

   * - ``offset``

       .. type:: int
          :required: false

     - Offset in the filtered list from where results will be returned

   * - ``silkProduct``

       .. type:: string
          :required: false

     - Centra product ID.

   * - ``silkVariant``

       .. type:: string
          :required: false

     - Centra variant ID.

   * - ``categories``

       .. type:: string or array of strings
          :required: false

     - Filter on the category ID for the products.

       ``"categories": "123"`` or ``"categories": ["123", "124"]``.

   * - ``sku``

       .. type:: string
          :required: false

     - Filter on product SKU.

   * - ``market``

       .. type:: string or int
          :required: false

     - Filter on market ID.

   * - ``preview``

       .. type:: boolean
          :required: false

     - Return products not being activated yet.

       * ``"preview": true`` return products for preview
       * ``"preview": false`` only return live products

```
-->

## Request example

```http request
   POST <base>/products/filter HTTP/1.1
   Content-type: application/json

   {
      "market": 123,
      "products": ["514", "515"],
      "categories": 1
   }
```
<!--
```eval_rst
.. code-block:: http
   :linenos:

   POST <base>/products/filter HTTP/1.1
   Content-type: application/json

   {
      "market": 123,
      "products": ["514", "515"],
      "categories": 1
   }
```
-->

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
<!--
```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 200 OK
   Content-type: application/json

   {
      "1": {"product-object"},
      "2": {"product-object"},
   }
```
-->

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
<!--
```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 404 Not Found
   Content-type: application/json

   {
      "errors" : {
         "categories" : "not found: 1"
      }
   }
```
-->

## Filter on categories

```text
GET  *base*/products/categories/*categories*
```

<!--
```eval_rst
.. endpoint::
   :method: GET
   :url: *base*/products/categories/*categories*
```
-->

Parameters explained under [Multi parameter filtering parameters](shop-api-filter-products-parameters).

## Filter on internal IDs

```text
GET  *base*/products/silk-product/*silkProduct*
```

```text
GET  *base*/products/silk-variant/*silkVariant*
```

<!--
```eval_rst
.. endpoint::
   :method: GET
   :url: *base*/products/silk-product/*silkProduct*

.. endpoint::
   :method: GET
   :url: *base*/products/silk-variant/*silkVariant*
```
-->

Parameters explained under [Multi parameter filtering parameters](shop-api-filter-products-parameters).

## Filter on SKU or URI

```text
GET  *base*/products/sku/*sku*
```

```text
GET  *base*/products/uri/*uri*
```

<!--
```eval_rst
.. endpoint::
   :method: GET
   :url: *base*/products/sku/*sku*

.. endpoint::
   :method: GET
   :url: *base*/products/uri/*uri*
```
-->

Parameters explained under [Multi parameter filtering parameters](shop-api-filter-products-parameters).
