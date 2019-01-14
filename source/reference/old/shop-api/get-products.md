# Get products

```eval_rst
.. api-name:: Shop API
   :version: soon deprecated

.. endpoint::
   :method: GET
   :url: *base*/products

.. endpoint::
   :method: GET
   :url: *base*/products/*productId*

.. authentication::
   :api_key: true
```

Fetches a specific product referenced by its ID, or the **full** product list.

If the `productId` parameter is specified, one product is fetched, otherwise **all products** in the catalog are fetched.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``productId``

       .. type:: int
          :required: false

     - Product ID. This is an internal ID for a product variant in Centra. It's not visible in the Centra admin panel; only through the API. The "Product ID" shown in the General Attributes for a product in Centra's admin is returned as the ``silkProduct`` field in the API response.

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
         "product" : "not found"
      }
   }
```
