```eval_rst
.. _order-api-get-orders:
```

# Get orders

```eval_rst
.. api-name:: Order API
   :version: soon deprecated

.. endpoint::
   :method: GET
   :url: *base*/orders?[&limit=5][&offset=5][&order=83651][&customer_id=1][&xml=1]

.. authentication::
   :api_key: true
```

This will fetch the orders allowed for the plugin being set up.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``limit``

       .. type:: int
          :required: false

     - Limit amount of orders returned.

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

       .. type:: date
          :required: false

     - Return order newer than date (YYYY-MM-DD).

   * - ``older_than``

       .. type:: date
          :required: false

     - Return order newer than date (YYYY-MM-DD).

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   GET <base>/orders?newer_than=2019-01-01&limit=10 HTTP/1.1

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
         "internalComment": "",
         "otherComment": "",
         "products": [
           {
             "lineId": "43243",
             "sku": "S123K345U1",
             "variantSku": "",
             "sizeSku": "",
             "name": "Product #1",
             "variant": "White",
             "size": "XS",
             "ean": "1234567890123",
             "qty": 1,
             "originalPrice": 500.5,
             "price": 450.5,
             "weight": 2,
             "weightUnit": "kg",
             "countryOfOrigin": "DE",
             "harmCode": "12345",
             "comment": ""
           },
           {
             "lineId": "43244",
             "sku": "S123K345U2",
             "variantSku": "",
             "sizeSku": "",
             "name": "Product #2",
             "variant": "Blue",
             "size": "XS",
             "ean": "1234567890124",
             "qty": 2,
             "originalPrice": 200.5,
             "price": 180.5,
             "weight": 1.5,
             "countryOfOrigin": "CI",
             "harmCode": "12345",
             "comment": ""
           }
         ]
       }
     ]
   }
```
