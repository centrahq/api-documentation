# Complete order

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: POST
   :url: *base*/order/*orderId*

.. authentication::
   :api_key: true
```

If [Create Order](/reference/stable/order-api/create-order) was used with `createOnly` set as `true`, the order will only be prepared but not finalized. By using the Complete Order-endpoint you can finalize the order to be placed properly as a second step from creating the order. This might be necessary if you first need to make sure the order can be placed (Create Order) and then finalize it after you've verified the payment (Complete Order).

```eval_rst
.. note:: You can use this endpoint multiple times for the same order, for example to save details on payment auth and capture at different times.
```

The Create Order call is the one validating that the products exists in stock, so if the Complete Order-call is made much later than the Create Order-call, there might be products back ordered inside the finalized order.

## Parameters

The following parameters are explained in the [Create Order](/reference/stable/order-api/create-order)-call, but are also supported when completing the order.

```eval_rst
.. list-table::
   :widths: auto

   * - ``payment``

       .. type:: object
          :required: false

     - Will contain information that should be inserted in regards to how the payment was handled outside of Centra.

       .. list-table::
          :widths: auto

          * - ``id``

              .. type:: int
                 :required: false

            - The ID of the payment plugin used from Centra. If not used, the order will not be marked with a payment type at all.

          * - ``auth`` ``capture``

              .. type:: object
                 :required: false

            - Information about the authorization and capture of the order. Authorization was the reservation of the order, capture is when the value also has been charged.

              .. list-table::
                 :widths: auto

                 * - ``response``

                     .. type:: string
                        :required: false

                   - The response string from the payment type. Will be shown verbose inside Centra.

                 * - ``status``

                     .. type:: int
                        :required: true

                   - If the authorization/capture went through or not. ``0`` means pending, ``1`` means success, ``2`` means failed.

                 * - ``transaction``

                     .. type:: string
                        :required: false

                   - The transaction ID of the authorization/capture.

                 * - ``method``

                     .. type:: string
                        :required: false

                   - Will be shown on reports to summarize what payment method was used.

                 * - ``amount``

                     .. type:: decimal2 (0.00)
                        :required: true

                   - The amount that was authorized.

                 * - ``external_url``

                     .. type:: string
                        :required: false

                   - If an external invoice was created, insert the URL to the invoice here.

   * - ``buyerName``

       .. type:: string
          :storetype: b2b
          :required: false

     - Name of the buyer that placed the order.

   * - ``internalComment``

       .. type:: string
          :required: false

     - Text for the "Internal comment"-field. Will only be shown internally in Centra.

   * - ``poNumber``

       .. type:: string
          :storetype: b2b
          :required: false

     - PO number used when placing the order. Will be visible on delivery notes and invoices.

   * - ``orderDate``

       .. type:: date/datetime
          :required: false

     - The time when the order was placed. Timezone is based on the location of the organization's Centra settings.

   * - ``deliveryDate``

       .. type:: date/datetime
          :required: false

     - Expected time of delivery.

   * - ``cancelDate``

       .. type:: date/datetime
          :required: false

     - Date when order should be cancelled if not confirmed.

   * - ``warehouseGroup``

       .. type:: string
          :required: false

     - Used to define what warehouse group it should use. Default will use the one set for the market.

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   POST <base>/order/123 HTTP/1.1
   Content-type: application/json

   {
     "comment": "Completed order, here is a comment"
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

   * - ``orders``

       .. type:: array of string

     - List of order numbers created. An order might split up in multiple orders after completing it, this is why you might get multiple orders back.

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
     "orders": [
       "44"
     ],
     "status": "ok"
   }
```

## Error example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "no",
     "msg": "Message about why the order failed to be completed."
   }
```
