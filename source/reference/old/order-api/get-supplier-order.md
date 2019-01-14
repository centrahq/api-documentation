# Get supplier order

```eval_rst
.. api-name:: Order API
   :version: soon deprecated

.. endpoint::
   :method: GET
   :url: *base*/supplier-orders/*supplierOrderId*

.. authentication::
   :api_key: true
```

List the products inside a supplier order.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   GET <base>/supplier-orders/*supplierOrderId* HTTP/1.1

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

   * - ``order``

       .. type:: object
          :required: true

     - Information about this specific supplier order.

       .. list-table::
          :widths: auto

          * - ``orderId``

              .. type:: string

            - ID of the supplier order.

          * - ``supplierCountry``

              .. type:: string

            - ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc).

          * - ``created``

              .. type:: datetime

            - The date this supplier order was created.

          * - ``ETA``

              .. type:: datetime

            - Estimated time of arrival to the warehouse. This will be used to calculate what orders that fits into a specific delivery window.

          * - ``ETD``

              .. type:: datetime

            - Estimated time of delivery for the customer.

          * - ``productsQty``

              .. type:: int

            - The total quantity of products in this supplier order.

          * - ``products``

              .. type:: array

            - The product items in this supplier order. Most of the fields are described in the :ref:`Get stock response <order-api-get-stock-response>` but the following ones are specific to supplier orders:

              .. list-table::
                 :widths: auto

                 * - ``quantity``

                     .. type:: int

                   - The amount of product items ordered.

                 * - ``cost``

                     .. type:: string

                   - The cost / pcs for this item.

                 * - ``costCurrency``

                     .. type:: string

                   - The currency code for the cost / pcs. ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc).

```

## Response example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "ok",
     "order": {
       "orderId": "957",
       "supplierName": "Falca",
       "supplierCountry": "ES",
       "created": "2019-01-28 01:15",
       "ETD": "2019-03-31 15:15",
       "ETA": "2019-04-05 20:15",
       "message": "Text entered by centra admin",
       "productsQty": 20000,
       "products": [
         {
           "sku": "12019005",
           "variantSku": "A",
           "sizeSku": "",
           "brand": "Kronan",
           "collection": "ALL",
           "product": "Bike Lady 0 speed BLACK",
           "variant": "SVART",
           "size": "ONE SIZE",
           "ean": "898989891212",
           "weight": 22,
           "weightUnit": "kg",
           "quantity": 122
           "cost": "9.40",
           "costCurrency": "USD"
         },
         {
           "sku": "12019007",
           "variantSku": "A",
           "sizeSku": "",
           "brand": "Kronan",
           "collection": "ALL",
           "product": "Bike Lady 0 speed BLUE",
           "variant": "BLUE",
           "size": "ONE SIZE",
           "ean": "898989891213",
           "weight": 22,
           "weightUnit": "kg",
           "quantity": 342,
           "cost": "12.40",
           "costCurrency": "EUR"
         }
       ]
     }
   }
```
