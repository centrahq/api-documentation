# Accept supplier delivery

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: POST
   :url: *base*/supplier-deliveries/*supplierDeliveryId*

.. endpoint::
   :method: POST
   :url: *base*/supplier-deliveries/*supplierDeliveryId*/sku

.. authentication::
   :api_key: true
```

Will accept the delivery with the proper quantities in the physical delivery. This will be inserted into the preferred warehouse.

```eval_rst
.. note:: This can only be done once per supplier delivery.
```

It is possible to over deliver or under deliver when accepting the delivery. This will be visible inside Centra when delivery was accepted.

In case of under delivery a new delivery containing the undelivered products will be created.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``products``

       .. type:: object
          :required: true

     - Key is from the :ref:`Get supplier delivery <order-api-get-supplier-delivery>` and value is the ``quantity``.

       .. list-table::
          :widths: auto

          * - key in object

              .. type:: string
                 :required: true

            - Use ``ean`` from the :ref:`Get supplier delivery <order-api-get-supplier-delivery>` referring to a specific product item in the supplier order delivery.

              If the endpoint used is ``/sku``, the combination of ``sku``, ``variantSku`` and ``sizeSku`` should be used instead.

              Example: ``{"products":{"1441":2}}`` will create a shipment of 2 products from item ``1441``.

          * - value in object

              .. type:: int
                 :required: true

            - Quantity of the item that should be accepted.

   * - ``insertStock``

       .. type:: boolean
          :required: false

     -  Default ``true``. Flag that defines whether to insert items to warehouse stock.
     
        * ``"insertStock": true`` insert items to warehouse stock 
        * ``"insertStock": false`` do not insert items to warehouse stock
       
   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

Both `id` and `deliveryId` from [List supplier deliveries](list-supplier-deliveries) can be used to accept a supplier delivery.

```eval_rst
.. code-block:: http
   :linenos:

   POST <base>/supplier-delivery/364 HTTP/1.1
   Content-type: application/json

   {
     "products": {
       "73213213123": 32,
       "73213213124": 12,
     },
     "insertStock": false
   }
```

### Accept using SKU instead of EAN

Append /sku to the URL and switch from EAN to SKU for the product keys.

```eval_rst
.. code-block:: http
   :linenos:

   POST <base>/supplier-delivery/364/sku HTTP/1.1
   Content-type: application/json

   {
     "products": {
       "PRODSKUVARIANTSKUSIZESKU": 32,
       "PRODSKUVARIANTSKUSIZESKU2": 12,
     }
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

   * - ``additionalDelivery``

       .. type:: object
          :required: false

     - If not all products from the supplier order delivery was accepted, this is the new created delivery for the remaining products of the supplier order delivery.

       .. list-table::
          :widths: auto

          * - ``id``

              .. type:: string

            - Internal ID for the created supplier order delivery.

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

            - The total quantity of products remaining in the accepted supplier order delivery.

```

## Response example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status":"ok",
     "additionalDelivery": {
       "id": "365",
       "orderId": "957",
       "deliveryId": "957-2",
       "supplierName": "Falca",
       "supplierCountry": "ES",
       "created": "2019-01-28 01:15",
       "ETD": "2019-03-31 15:15",
       "ETA": "2019-04-05 20:15",
       "message": "Text entered by centra admin",
       "productsQty": 19891
     }
   }
```
