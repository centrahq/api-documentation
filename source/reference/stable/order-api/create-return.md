# Create return

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: POST
   :url: *base*/return

.. authentication::
   :api_key: true
```

This will create return for given shipment and items. Return will be created even if some of the provided items cannot be returned.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``shipment``

       .. type:: string
          :required: true

     - The ``shipmentId`` from :ref:`Get shipments <order-api-get-shipments>` or :ref:`Create shipment <order-api-create-shipment>`.

   * - ``products``

       .. type:: object
          :required: true

     - Key is ``lineID`` from the :ref:`Get shipments <order-api-get-shipments>` and value is the ``quantity``.

       Example: ``{"products":{"1441":2}}`` will create a return of 2 products from item ``1441``.

       .. list-table::
          :widths: auto

          * - key in object

              .. type:: string
                 :required: true

            - ``lineID`` from the :ref:`Get shipments <order-api-get-shipments>` referring to a specific product item in the order.

          * - value in object

              .. type:: int
                 :required: true

            - Quantity of the item that should be returned.

   * - ``returnStock``

       .. type:: boolean
          :required: false

     - Insert returned items into stock. If not provided ``Default stock action on return`` setting on the store will be used.
   
   * - ``handlingCost``

       .. type:: float
          :required: false

     - Handling cost.

   * - ``handlingCostFromShipment``

       .. type:: boolean
          :required: false
          :default: false

     - Set to `true` to use Handling cost from Shipment. You cannot provide handlingCost at the same time this option is used.

   * - ``shippingCost``

       .. type:: float
          :required: false

     - Shipping cost.

   * - ``shippingCostFromShipment``

       .. type:: boolean
          :required: false
          :default: false

     - Set to `true` to use Shipping cost from Shipment. You cannot provide shippingCost at the same time this option is used.
        
   * - ``returnCost``

       .. type:: float
          :required: false

     - Return cost. If the return itself should have a cost to it. Providing a value here will deduct the amount of money to refund.
     
   * - ``voucherValue``

       .. type:: float
          :required: false

     - Voucher value, should always be positive value.

   * - ``voucherValueFromShipment``

       .. type:: boolean
          :required: false
          :default: false

     - Set to `true` to use Voucher value from Shipment. You cannot provide voucherValue at the same time this option is used.
     
   * - ``comment``

       .. type:: string
          :required: false

     - Additional comment for return, for reference.

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.

   * - ``refund``

       .. type:: object
          :required: false

     - Refund object.

       Example: ``{"refund":{"refundPayment": true}}`` will make refund from return.

       .. list-table::
          :widths: auto

          * - ``refundPayment``

              .. type:: boolean
                 :required: false

            - If this is set to true the payment provider will get a refund request to pay back the money to the customer. The amount that will be refunded is the amount for the products, the handling, shipping and return costs.

          * - ``sendEmail``

              .. type:: boolean
                 :required: false

            - Send refund email. Default value is ``false``.
     
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   POST <base>/return HTTP/1.1
   Content-type: application/json

   {
     "shipment": "120276-1",
     "returnStock": 1,
     "comment": "Return created with Order Api",
     "products": {
       "268871": "1",
       "268870": "1"
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

   * - ``order``

       .. type:: int

     - Order ID that was captured.

   * - ``return``

       .. type:: int

     - Return ID that was created.

   * - ``returnedItems``

       .. type:: array of string

     - The items added to the return.

       Will look like this: ``["1456", "15654", "4343"]``

   * - ``msg``

       .. type:: string
          :required: false

     - If ``status`` returns ``no``, this value should send back a message why it failed.
```

## Response example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "ok",
     "return": 5397,
     "returnedItems": [
       "268871"
     ]
   }
```

## Error example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "no",
     "msg": "return could not be created."
   }
```
