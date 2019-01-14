# List supplier deliveries

```eval_rst
.. api-name:: Order API
   :version: soon deprecated

.. endpoint::
   :method: GET
   :url: *base*/supplier-deliveries

.. authentication::
   :api_key: true
```

Get the incoming and not accepted deliveries that are connected to the warehouse this plugin is connected to.

Deliveries will be listed when these requirements are fulfilled:

* Delivery created on a confirmed Supplier Order.
* Supplier order has the Preferred Warehouse set to the "Supplier Delivery Warehouse" in the Plugin.
* Delivery is not accepted yet.
* Delivery has items in it.

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

   GET <base>/supplier-deliveries HTTP/1.1

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

   * - ``deliveries``

       .. type:: array
          :required: true

     - Array of supplier orders.

       .. list-table::
          :widths: auto

          * - ``id``

              .. type:: string

            - Internal ID for the supplier order delivery.

          * - ``deliveryId``

              .. type:: string

            - ID of the supplier order delivery. This is the ID communicated externally.

          * - ``orderId``

              .. type:: string

            - ID of the supplier order.

          * - ``supplierCountry``

              .. type:: string

            - ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc).

          * - ``created``

              .. type:: datetime

            - The date this supplier order delivery was created.

          * - ``ETA``

              .. type:: datetime

            - Estimated time of arrival to the warehouse. This will be used to calculate what orders that should be automatically connected to this specific delivery.

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
     "deliveries": [
       {
         "id": "364",
         "orderId": "957",
         "deliveryId": "957-1",
         "supplierName": "Falca",
         "supplierCountry": "ES",
         "created": "2019-01-28 01:15",
         "ETD": "2019-03-31 15:15",
         "ETA": "2019-04-05 20:15",
         "message": "Text entered by centra admin",
         "productsQty": 20000
       },
       {
         "id": "365",
         "orderId": "957",
         "deliveryId": "957-2",
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
