```eval_rst
.. _order-api-get-supplier-delivery:
```

# Get supplier delivery

```eval_rst
.. api-name:: Order API
   :version: soon deprecated

.. endpoint::
   :method: GET
   :url: *base*/supplier-delivery/*supplierDeliveryId*

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

Both `id` and `deliveryId` from [List supplier deliveries](list-supplier-deliveries) can be used to fetch a supplier delivery.

```eval_rst
.. code-block:: http
   :linenos:

   GET <base>/supplier-delivery/*supplierDeliveryId* HTTP/1.1

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

   * - ``delivery``

       .. type:: object
          :required: true

     - Information about this specific supplier order delivery.

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

          * - ``products``

              .. type:: array

            - The product items in this supplier order delivery. Most of the fields are described in the :ref:`Get stock response <order-api-get-stock-response>` but the following ones are specific to supplier order deliveries:

              .. list-table::
                 :widths: auto

                 * - ``quantity``

                     .. type:: int

                   - The amount of product items attached to this delivery.

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
     "delivery": {
       "id": "364",
       "orderId": "957",
       "deliveryId": "957-1",
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
