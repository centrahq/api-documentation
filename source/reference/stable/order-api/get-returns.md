```eval_rst
.. _order-api-get-returns:
```

# Get returns

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: GET
   :url: *base*/returns?[&limit=5][&page=2][&return=23]

.. authentication::
   :api_key: true
```

Will list all returns, newest first.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``limit``

       .. type:: int
          :required: false

     - Limit the number of returns returned.

   * - ``page``

       .. type:: int
          :required: false

     - Number of page of results to return.     

   * - ``return``

       .. type:: int
          :required: false

     - Only show a return with given ID.

   * - ``shipment``

       .. type:: string
          :required: false

     - Only show a return with given shipment number.

   * - ``order``

       .. type:: int
          :required: false

     - Only fetch returns for a specific order.

   * - ``selection``

       .. type:: int
          :required: false

     - Only fetch returns for a specific selection.

   * - ``customer_id``

       .. type:: int
          :required: false

     - Only fetch returns for a specific customer.

   * - ``newer_than``

       .. type:: date
          :required: false

     - Only fetch returns created after given date or datetime (inclusive).
     
   * - ``older_than``

       .. type:: date
          :required: false

     - Only fetch returns created before given date or datetime (exclusive).
     
   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   GET <base>/returns?limit=2 HTTP/1.1

```

```eval_rst
.. _get-returns-response:
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

   * - ``returns``

       .. type:: array
          :required: true

     - Array of fetched returns.

       .. list-table::
          :widths: auto

          * - ``returnId``

              .. type:: int

            - ID of the return.

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
       "returns": [
           {
               "returnId": 385,
               "shipment": "20059-1",
               "shipmentId": 8039,
               "orderId": 20059,
               "selectionId": "8bf93dd57e9ebf9291c8c3a5f0cb63bf",
               "customerId": 416715,
               "date": "2019-07-11 14:34:32",
               "returnCost": 0,
               "shippingCost": 0,
               "handlingCost": 0,
               "voucherValue": 0,
               "taxValue": 21.41,
               "taxDeduction": 0,
               "currency": "EUR",
               "baseCurrency": "SEK",
               "baseCurrencyRate": 10.6453,
               "returnToStock": true,
               "comment": "Godkänd retur",
               "createdFrom": "Order API",
               "products": [
                   {
                       "returnLineId": 555,
                       "shipmentLineId": 30672,
                       "orderLineId": 60288,
                       "productId": 159,
                       "variantId": 372,
                       "productName": "Muffin man",
                       "productBrand": "Handcrafted",
                       "variantName": "Big cart",
                       "size": "One Size",
                       "sku": "MUF1042",
                       "variantSku": "",
                       "sizeSku": "",
                       "ean": "7340112910426",
                       "quantity": 1,
                       "price": 124.1
                   }
               ]
           },
           {
               "returnId": 384,
               "shipment": "20179-1",
               "shipmentId": 8094,
               "orderId": 20179,
               "selectionId": "ae6eb1befe5d6f850a016932ca4276dc",
               "customerId": 734042,
               "date": "2019-07-11 14:33:56",
               "returnCost": 0,
               "shippingCost": 0,
               "handlingCost": 0,
               "voucherValue": 0,
               "taxValue": 9.08,
               "taxDeduction": 0,
               "currency": "GBP",
               "baseCurrency": "SEK",
               "baseCurrencyRate": 11.61479,
               "returnToStock": true,
               "comment": null,
               "createdFrom": "Order API",
               "products": [
                   {
                       "returnLineId": 553,
                       "shipmentLineId": 30800,
                       "orderLineId": 60669,
                       "productId": 196,
                       "variantId": 430,
                       "productName": "Plush Guitar",
                       "productBrand": "",
                       "variantName": "Pink",
                       "size": null,
                       "sku": "PNKG8484",
                       "variantSku": "",
                       "sizeSku": "",
                       "ean": "7340082321862",
                       "quantity": 1,
                       "price": 54.5
                   }
               ]
           }
       ]
   }
```
