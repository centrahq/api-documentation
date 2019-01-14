# Get filtered products

```eval_rst
.. api-name:: Shop API
   :version: soon deprecated

.. endpoint::
   :method: POST
   :url: *base*/products/filter

.. authentication::
   :api_key: true
```

Fetches a list of products based on the provided filter parameters. The GET calls below filter the product list on the parameter given in the URI. If you want to filter on several fields at once, you should use POST to `/products/filter`.

```eval_rst
.. _shop-api-filter-products-parameters:
```

## Parameters

One, or many (for POST), of the following parameters can be specified:

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

## Request example

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

## Response

`200` `Content-type: application/json`

The object returned will have the `productId` for each product as the key. The product object is explained under [Product data model](shop-api-product-data-model).

## Response example

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

## Error example

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

## Filter on categories

```eval_rst
.. endpoint::
   :method: GET
   :url: *base*/products/categories/*categories*
```

Parameters explained under [Multi parameter filtering parameters](shop-api-filter-products-parameters).

## Filter on internal IDs

```eval_rst
.. endpoint::
   :method: GET
   :url: *base*/products/silk-product/*silkProduct*

.. endpoint::
   :method: GET
   :url: *base*/products/silk-variant/*silkVariant*
```

Parameters explained under [Multi parameter filtering parameters](shop-api-filter-products-parameters).

## Filter on SKU or URI

```eval_rst
.. endpoint::
   :method: GET
   :url: *base*/products/sku/*sku*

.. endpoint::
   :method: GET
   :url: *base*/products/uri/*uri*
```

Parameters explained under [Multi parameter filtering parameters](shop-api-filter-products-parameters).
