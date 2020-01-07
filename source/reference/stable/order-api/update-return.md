```eval_rst
.. _order-api-update-return:
```

# Update return

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: PUT
   :url: *base*/returns/*returnId*

.. authentication::
   :api_key: true
```

Update information on Return.


## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``returnId``

       .. type:: string
          :required: true

     - The ID from ``return`` when creating or updating a return.
     
   * - ``completed``

       .. type:: boolean
          :required: false

     - Set to `true`/`false` to change Return status to Complete/Pending.

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   PUT <base>/returns/2 HTTP/1.1
   Content-type: application/json
   
   {"completed": true}
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

   * - ``return``

       .. type:: object
          :required: true

     - Object of fetched return.

       .. list-table::
          :widths: auto

          * - ``returnId``

              .. type:: int

            - ID of the return.
            
          * - ``completed``

              .. type:: boolean

            - Whether the return was completed or not.   

          * - ``shipment``

              .. type:: string

            - Number of the shipment.

          * - ``shipmentId``

              .. type:: int

            - ID of the shipment.

          * - ``orderId``

              .. type:: int

            - ID of the order.

          * - ``selectionId``

              .. type:: string

            - Selection ID of the order.

          * - ``customerId``

              .. type:: int

            - Customer ID of the order.

          * - ``date``

              .. type:: datetime

            - Date when return was created.

          * - ``returnCost``

              .. type:: float

            - Cost of the return.

          * - ``shippingCost``

              .. type:: float

            - Cost of shipping returned.

          * - ``handlingCost``

              .. type:: float

            - Handling cost of the return.

          * - ``voucherValue``

              .. type:: float

            - Voucher value included in the return.

          * - ``taxValue``

              .. type:: float

            - Tax value of the return, zero if deducted.

          * - ``taxDeduction``

              .. type:: float

            - Tax deduction in the return.

          * - ``currency``

              .. type:: string

            - Currency code in which order and also return was made.

          * - ``baseCurrency``

              .. type:: string

            - Code of the currency used as base in this store.

          * - ``baseCurrencyRate``

              .. type:: float

            - Exchange rate between ``currency`` and ``baseCurrency`` above.

          * - ``returnToStock``

              .. type:: boolean

            - Whether the return was marked as returned back to stock.

          * - ``comment``
                  
               .. type:: string

            - Optional description added to the return.

          * - ``createdFrom``
                  
               .. type:: string

            - Informs where this return originated, i.e. "Order API".

          * - ``products``

              .. type:: array

            - Products inside the return.

              .. list-table::
                 :widths: auto

                 * - ``returnLineId``

                     .. type:: int

                   - ID of the specific product item in this return.

                 * - ``shipmentLineId``

                     .. type:: int

                   - ID of the related shipment line.
                   
                 * - ``orderLineId``

                     .. type:: int

                   - ID of the related order line.

                 * - ``productId``

                     .. type:: int

                   - ID of the product.
                   
                 * - ``variantId``

                     .. type:: int

                   - ID of the product variant.
                   
                 * - ``productName``

                     .. type:: string

                   - Name of the product.

                 * - ``productBrand``

                     .. type:: string

                   - Brand name of the product.

                 * - ``variantName``

                     .. type:: string

                   - Name of the product variant.

                 * - ``size``

                     .. type:: string

                   - Size description, if any.

                 * - ``sku``

                     .. type:: string

                   - Product SKU.

                 * - ``variantSku``

                     .. type:: string

                   - Product variant SKU.

                 * - ``sizeSku``

                     .. type:: string

                   - Size SKU.

                 * - ``ean``

                     .. type:: string

                   - EAN of the item.

                 * - ``quantity``

                     .. type:: int

                   - Quantity of this specific product item returned.

                 * - ``price``

                     .. type:: float

                   - Unit price as seen on shipment.

```

## Response example

```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 200 OK
   Content-type: application/json

   {
       "status": "ok",
       "return": {
           "returnId": 18,
           "status": 1,
           "shipment": "44-1",
           "shipmentId": 1142,
           "orderId": 44,
           "selectionId": "be337d27e16564cadad0a340b8bc1fbe",
           "customerId": 31,
           "date": "2020-01-07 17:00:29",
           "returnCost": 5,
           "shippingCost": 5.55,
           "handlingCost": 9,
           "voucherValue": 0,
           "taxValue": 21.91,
           "taxDeduction": 0,
           "currency": "SEK",
           "baseCurrency": "SEK",
           "baseCurrencyRate": 1,
           "returnToStock": false,
           "comment": null,
           "createdFrom": "Order API",
           "products": [
               {
                   "returnLineId": 17,
                   "shipmentLineId": 2681,
                   "orderLineId": 112,
                   "productId": 7,
                   "variantId": 2460,
                   "productName": "Test Product STOCK",
                   "productBrand": null,
                   "variantName": null,
                   "size": null,
                   "sku": "TPSTOCK",
                   "variantSku": "",
                   "sizeSku": "",
                   "ean": "StockTestEAN",
                   "quantity": 1,
                   "price": 100
               }
           ]
       }
   }
```

## Error example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "no",
     "msg": "Return with id=100500 does not exist"
   }
```
