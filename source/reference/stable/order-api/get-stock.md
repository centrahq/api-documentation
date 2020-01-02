```eval_rst
.. _order-api-get-stock:
```

# Get stock

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: GET
   :url: *base*/stock

.. authentication::
   :api_key: true
```

This will return product data from Centra with stock info. The values of the stock depends on the connected warehouses for the API-plugin.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``sku``

       .. type:: string
          :required: false

     - Get products with a specific SKU.

   * - ``modified``

       .. type:: date
          :required: false

     - Get all products modified after a certain date.

   * - ``stock_modified``

       .. type:: date
          :required: false

     - Get all products which had stock changes after a certain date.

   * - ``created``

       .. type:: date
          :required: false

     - Get all products added after a certain date.

   * - ``ean``

       .. type:: string
          :required: false

     - Get a product with specified EAN code.

   * - ``productId``, ``variantId``, ``stockItemId``

       .. type:: integer
          :required: false

     - Get a product with specified productId, variantId or stockItemId.

   * - ``limit``

       .. type:: int
          :required: false

     - You will get this amount of products, and a "next" parameter in return if there are multiple pages. This will go a lot faster to fetch, instead of fetching all products at once.

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   GET <base>/stock?[&limit=2][&sku=DCG001][&modified=2016-01-01][&created=2011-01-01] HTTP/1.1

```

```eval_rst
.. _order-api-get-stock-response:
```

## Response

`200` `Content-type: application/json`

```eval_rst
.. list-table::
   :widths: auto

   * - ``status``

       .. type:: string
          :required: true

     - ``ok`` if success, else ``no``.

   * - ``products``

       .. type:: array

     - List of the products.

       .. list-table::
          :widths: auto

          * - ``sku``

              .. type:: string

            - SKU for this product.

          * - ``product``

              .. type:: string

            - The internal name for this product.

          * - ``productId``

              .. type:: integer

            - The ID for this product.

          * - ``variantSku``

              .. type:: string

            - SKU for this variant.

          * - ``variantId``

              .. type:: integer

            - ID for this variant.

          * - ``sizeSku``

              .. type:: string

            - SKU for this size.

          * - ``stockItemId``

              .. type:: integer

            - ID for this specific stock item.

          * - ``ean``

              .. type:: string

            - The EAN for this product item size.

          * - ``weight``

              .. type:: decimal2 (0.00)

            - The weight specified for this product.

          * - ``weightUnit``

              .. type:: string

            - The unit used for the weight.

              * ``kg``
              * ``lb``

          * - ``size``

              .. type:: string

            - Name of the size for this specific product item.

          * - ``active``

              .. type:: boolean

            - If the product item is active or not.

          * - ``countryOfOrigin``

              .. type:: string

            - ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc)

          * - ``physicalStock``

              .. type:: int

            - The amount of items in the physical stock. If an order is placed without being shipped, the physical stock of the product does not change. However, as soon as a shipment is completed, the physical stock will decrease.

              ``physicalStock = allocatedStock + availableStock``

          * - ``allocatedStock``

              .. type:: int

            - The amount of items in the physical stock that is currently allocated against orders.

          * - ``availableStock``

              .. type:: int

            - The amount of items in the physical stock that is currently available to sell.

   * - ``previous``

       .. type:: string
          :required: false

     - Will contain a URL to the previous page.

   * - ``next``

       .. type:: string
          :required: false

     - Will contain a URL to the next page.

```

## Response example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "ok",
     "products": [
       {
         "sku": "12019005",
         "productId": 10,
         "variantSku": "A",
         "variantId": 9,
         "sizeSku": "X",
         "brand": "Kronan",
         "collection": "ALL",
         "product": "Bike Lady 0 speed BLACK",
         "variant": "SVART",
         "size": "ONE SIZE",
         "stockItemId": 3131,
         "ean": "1234567890123",
         "weight": 22,
         "weightUnit": "kg",
         "countryOfOrigin": "",
         "harmCode": "87120030",
         "harmDescription": "Cyklar",
         "active": 1,
         "physicalStock": 5,
         "allocatedStock": 1,
         "availableStock": 4
       },
       {
         "sku": "12028008",
         "productId": 11,
         "variantSku": "B",
         "variantId": 10,
         "sizeSku": "Y",
         "brand": "Kronan",
         "collection": "ALL",
         "product": "Bike Man 0 speed BROWN",
         "variant": "BRUN",
         "size": "ONE SIZE",
         "stockItemId": 3132,
         "ean": "9876543210123",
         "weight": 22,
         "weightUnit": "kg",
         "countryOfOrigin": "",
         "harmCode": "87120030",
         "harmDescription": "CYKEL",
         "active": 1,
         "physicalStock": 141,
         "allocatedStock": 10,
         "availableStock": 131
       }
     ],
     "previous": "?limit=2&page=2",
     "next": "?limit=2&page=3"
   }
```
