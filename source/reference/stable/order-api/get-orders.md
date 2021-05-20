```eval_rst
.. _order-api-get-orders:
```

# Get orders

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: GET
   :url: *base*/orders?[&limit=5][&offset=5][&order=83651][&customer_id=1][&xml=1]

.. authentication::
   :api_key: true
```

This will fetch the orders allowed for the plugin being set up. Any custom attributes assigned to orders
will also be returned as individual fields (see example).

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``limit``

       .. type:: int
          :required: false

     - Limit amount of orders returned. Default: 20.

   * - ``offset``

       .. type:: int
          :required: false

     - Offset how far in to start returning orders.

   * - ``order``

       .. type:: int
          :required: false

     - Return a specific order.

   * - ``customer_id``

       .. type:: int
          :required: false

     - Return orders for specified customer id.

   * - ``newer_than``

       .. type:: date/datetime
          :required: false

     - Return order newer than date.  Allowed formats ``YYYY-mm-dd`` and ``YYYY-mm-dd HH:MM:SS``. Timezone is system-wide and decided by the company using Centra.

   * - ``older_than``

       .. type:: date/datetime
          :required: false

     - Return order newer than date. Allowed formats ``YYYY-mm-dd`` and ``YYYY-mm-dd HH:MM:SS``. Timezone is system-wide and decided by the company using Centra.

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   GET <base>/orders?newer_than=2019-01-01+12:11:39&limit=10 HTTP/1.1

```

```eval_rst
.. _get-orders-response:
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

     - Array of orders returned.

       .. list-table::
          :widths: auto

          * - ``orderId``

              .. type:: string

            - Id of the order.
            
          * - ``orderStatus``

              .. type:: string

            - Status of the order.
            
          * - ``selectionId``

              .. type:: string

            - Selection ID of the order.

          * - ``orderDate``

              .. type:: datetime

            - Date when order was created.

          * - ``products``

              .. type:: array

            - Products inside the order.

              .. list-table::
                 :widths: auto

                 * - ``lineId``

                     .. type:: string

                   - Id of the specific product item in this order.

                 * - ``qty``

                     .. type:: int

                   - Quantity of this specific product item.

                 * - ``isBundle``

                     .. type:: bool

                   - Flag showing if product is bundle

                 * - ``isPartOfBundle``

                     .. type:: int

                   - Bundle id 

                 * - ``bundle``

                     .. type:: array

                   - Array of containing items for bundle
          * - ``taxBreakdown``

              .. type:: array

            - Lists all tax rules applied to the order.

              .. list-table::
                 :widths: auto

                 * - ``description``

                     .. type:: string

                   - Text description of tax rule. ex: VAT

                 * - ``taxPercent``

                     .. type:: float

                   - Percentage of tax. ex 25

                 * - ``value``

                     .. type:: float

                   - How much tax. ex 20
          * - Custom Attributes: ``<attribute>_<element>``
          
              .. type:: string
              
            - Any additional custom fields will also be included in response. The
              response's property will be named according to the name of the custom field and its elements.
              For example an attribute named ``attribute`` with element ``element`` will yield a field called
              ``attribute_element`` in the response (as in example below). Another, more real-life scenario might 
              include an
              attribute named ``order_attr`` with element ``external_id`` that would return a field
              ``order_attr_external_id``.
              
```

## Response example

```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 200 OK
   Content-type: application/json

   {
     "status": "ok",
     "orders": [
       {
         "orderId": "83651",
         "selectionId": "7dee9426b07b13ec452f87a3b67aa6be",
         "orderDate": "2012-02-04 15:16:13",
         "cancelDate": "2012-08-04 15:16:13",
         "preferredDeliveryDate": "2012-05-04 15:16:13",
         "estimatedDeliveryDate": "2012-05-04 15:16:13",
         "orderStore": "retail",
         "orderCurrency": "EUR",
         "customerId": "12345",
         "accountId": "",
         "deliveryName": "Someones Name",
         "deliveryCompany": "",
         "deliveryEmail": "deliveries@example.com",
         "deliveryCell": "+4912345678",
         "deliveryTele": "",
         "deliveryAddress": "Examplestreet 1",
         "deliveryCoaddress": "",
         "deliveryZipcode": "12345",
         "deliveryCity": "Somecity",
         "deliveryState": "",
         "deliveryCountry": "DE",
         "billingName": "Someones Name",
         "billingCompany": "",
         "billingEmail": "billing@example.com",
         "billingTele": "",
         "billingAddress": "Examplestreet 1",
         "billingCoaddress": "",
         "billingZipcode": "12345",
         "billingCity": "Somecity",
         "billingState": "",
         "billingCountry": "DE",
         "billingVAT": "",
         "poNumber": "",
         "shippingList": "standard",
         "suspect": 0,
         "internalOrder": 0,
         "hold": 0,
         "shippingValue": 25,
         "voucherValue": 0,
         "grandTotalValue": 3978.75,
         "grandTotalTaxValue": 795.75,
         "taxAdded": 0,
         "taxDeducted": 0,
         "internalComment": "",
         "otherComment": "",
         "marketId": 1,
         "pricelistId": 1,
         "ipAddress": "127.0.0.1",
         "paymentType": "free",
         "paymentDescription": "",
         "defaultCarrier": "",
         "shipments": [
            {
                "shipmentId": "16-1",
                "shippedDate": "0000-00-00 00:00:00",
                "carrier": "",
                "service": "",
                "trackingId": "",
                "trackingUrl": "",
                "returnSlipTracking": "",    
            }
         ],
         "totalItemsPriceTax": -202.88,
         "totalItemsPrice": 811.5,
         "totalItemsWithoutTax": 608.62,
         "taxBreakdown": [
           {
             "description": "VAT",
             "taxPercent": 25,
             "value": 795.75
           }
         ],
         "attribute_element": "A custom attribute value",
         "products": [
           {
             "lineId": "43243",
             "sku": "S123K345U1",
             "variantSku": "",
             "sizeSku": "",
             "ean": "1234567890123",
             "name": "Product #1",
             "variant": "White",
             "brand": "Brand",
             "size": "XS",
             "qty": 1,
             "originalPrice": 500.5,
             "price": 450.5,
             "weight": 2,
             "weightUnit": "kg",
             "countryOfOrigin": "DE",
             "harmCode": "12345",
             "comment": "",
             "otherComment": "",
             "taxPercent": 0,
             "priceDiscount": 50.0,
             "priceDiscountAsPercent": 0,
             "taxValue": 112.63,
             "totalPrice": 450.5,
             "anyDiscount": false,
             "priceEachWithoutTax": 337.87,
             "priceEachReduction": 0,
             "warehouses": [
                {
                    "name": "Default",
                    "itemQty": 1
                }
             ],
            "isBundle": false,
            "isPartOfBundle": "217"
           },
           {
             "lineId": "43244",
             "sku": "S123K345U2",
             "variantSku": "",
             "sizeSku": "",
             "ean": "1234567890124",
             "name": "Product #2",
             "variant": "Blue",
             "brand": "Brand",
             "size": "XS",
             "qty": 2,
             "originalPrice": 200.5,
             "price": 180.5,
             "weight": 1.5,
             "weightUnit": "kg",
             "countryOfOrigin": "CI",
             "harmCode": "12345",
             "comment": "",
             "taxPercent": 25,
             "priceDiscount": 0,
             "priceDiscountAsPercent": 0,
             "taxValue": 90.25,
             "totalPrice": 361,
             "anyDiscount": false,
             "priceEachWithoutTax": 270.75,
             "priceEachReduction": 0,
             "warehouses": [
                {
                    "name": "Default",
                    "itemQty": 2
                }
             ],
             "isBundle": true,
             "bundle": [
               {
                 "lineId": "43243",
                 "sku": "S123K345U1",
                 "variantSku": "",
                 "sizeSku": "",
                 "ean": "1234567890123",
                 "name": "Product #1",
                 "variant": "White",
                 "brand": "Brand",
                 "size": "XS",
                 "qty": 1,
                 "originalPrice": 500.5,
                 "price": 450.5,
                 "weight": 2,
                 "weightUnit": "kg",
                 "countryOfOrigin": "DE",
                 "harmCode": "12345",
                 "comment": "",
                 "otherComment": "",
                 "taxPercent": 0,
                 "priceDiscount": 50.0,
                 "priceDiscountAsPercent": 0,
                 "taxValue": 112.63,
                 "totalPrice": 450.5,
                 "anyDiscount": false,
                 "priceEachWithoutTax": 337.87,
                 "priceEachReduction": 0,
                 "warehouses": [
                    {
                        "name": "Default",
                        "itemQty": 1
                    }
                 ],
                "isBundle": false,
                "isPartOfBundle": "217"
               },
            ]
           }
         ],
         "totalItemsDiscount": 38.11,
         "discounts": {
            "anyDiscount": false,
            "discount": "0.00 USD",
            "discountAsNumber": 0,
            "vouchers": [
              {
                "voucher": "vip123",
                "name": "Some voucher",
                "priceOff": "-150.00 USD",
                "priceOffAsANumber": -150.0,
                "description": "This is VIP code description"
              }
            ],
            "automaticDiscounts": [
              {
                "automaticDiscount": "12345",
                "name": "Some discount",
                "priceOff": "0.00 USD",
                "priceOffAsANumber": 0 
              }
            ]
         }
       }
     ]
   }
```
