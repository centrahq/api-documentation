# Update stock

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: POST
   :url: *base*/stock

.. authentication::
   :api_key: true
```

This updates the `physicalStock` quantities in Centra. This is the number of products in stock including those that are reserved for orders.

```eval_rst
.. warning:: You cannot set the quantity below the number that is reserved for orders, the value specified in ``allocatedStock`` from :ref:`Get stock <order-api-get-stock>`. In the case the stock update contains a lower amount than the allocated stock, Centra will set the quantity to ``allocatedStock`` which the lowest possible value without affecting any reserved orders.

             The request will not return any error message, but an email notification can be sent to a Centra-administrator from the plugin settings.
```

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``products``

       .. type:: array
          :required: true

     - Array of products to update stock on.

       .. list-table::
          :widths: auto

          * - ``product``

              .. type:: string
                 :required: true

            - String to update a product item. Use ``ean`` or a combination of ``sku``, ``variantSku`` and ``sizeSku`` to update the quantity for each product.

          * - ``quantity``

              .. type:: int
                 :required: true

            - The quantity of the physical stock for the item.

          * - ``costPrice``

              .. type:: string
                 :required: false

            - The internal cost price for this item.

          * - ``costPriceCurrency``

              .. type:: string
                 :required: false

            - ISO code for the currency for the cost price. ``USD``, ``EUR``, ``SEK``, etc.

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

The example above uses EAN, this is the same field as the [Get stock](get-stock) product field `ean`. The example below uses SKU by combining the [Get stock](get-stock) fields `sku`, `variantSku` and `sizeSku`:

```eval_rst
.. code-block:: http
   :linenos:

   POST <base>/stock HTTP/1.1
   Content-type: application/json

   {
     "products": [
       {
         "product": "1234567890123",
         "quantity": 54
       },
       {
         "product": "9876543210123",
         "quantity": 55
       },
       {
         "product": "5432167890123",
         "quantity": 1
       }
     ]
   }
```

Optionally you can also include a cost / pcs value for the items.

```eval_rst
.. code-block:: http
   :linenos:

   POST <base>/stock HTTP/1.1
   Content-type: application/json

   {
     "products":[
       {
         "product": "1234567890123",
         "quantity": 54,
         "costPrice": 12.54,
         "costPriceCurrency": "SEK"
       },
       {
         "product": "9876543210123",
         "quantity": 55,
         "costPrice": 8.12,
         "costPriceCurrency": "EUR"
       },
       {
         "product": "5432167890123",
         "quantity": 1,
         "costPrice": 54.24,
         "costPriceCurrency": "USD"
       }
     ]
   }
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

   * - ``msg``

       .. type:: string
          :required: false

     - If ``status`` returns ``no``, this value should send back a message why it failed.

   * - ``errors``

       .. type:: object
          :required: false

     - If ``status`` returns ``no``, this object might contain information about products that could not be updated.

       .. list-table::
          :widths: auto

          * - ``productsNotFound``

              .. type:: array of string
                 :required: false

            - This will be an array with the product identifiers that could not be updated from the request.

              Like this: ``["43242342", "43243294", "432432232"]``

          * - ``productsAreBundles``

              .. type:: array of string
                 :required: false

            - This will be an array with the product identifiers that are bundled products. This means that they can not be updated directly, since they are based on products the bundle is connected to.

              Like this: ``["43242342", "43243294", "432432232"]``

```

## Response example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status":"ok"
   }
```

## Error example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "no",
     "msg": "Some of the products were not updated",
     "errors": {
       "productsNotFound": [
         "9876543210123",
         "5432167890123"
       ]
     }
   }
```
