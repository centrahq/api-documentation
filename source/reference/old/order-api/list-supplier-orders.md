# List supplier orders

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: GET
   :url: *base*/supplier-orders

.. authentication::
   :api_key: true
```

Get all confirmed supplier orders visible by the plugin.

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

   GET <base>/supplier-orders HTTP/1.1

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

   * - ``orders``

       .. type:: array
          :required: true

     - Array of supplier orders.

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

```

## Response example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "ok",
     "orders": [
       {
         "orderId": "957",
         "supplierName": "Falca",
         "supplierCountry": "ES",
         "created": "2019-01-28 01:15",
         "ETD": "2019-03-31 15:15",
         "ETA": "2019-04-05 20:15",
         "message": "Text entered by centra admin",
         "productsQty": 20000
       },
       {
         "orderId": "957",
         "supplierName": "Falca",
         "supplierCountry": "ES",
         "created": "2019-01-28 01:15",
         "ETD": "2019-03-31 15:15",
         "ETA": "2019-04-05 20:15",
         "message": "Text entered by centra admin",
         "productsQty": 10000
       }
     ]
   }
```
