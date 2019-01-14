# Get supplier delivery details

```eval_rst
.. api-name:: Order API
   :version: soon deprecated

.. endpoint::
   :method: GET
   :url: *base*/supplier-delivery/*supplierDeliveryId*/details

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

          * - ``orders``

              .. type:: array

            - The list of orders that has reserved products for this supplier order delivery.

              .. list-table::
                 :widths: auto

                 * - ``orderId``

                     .. type:: string

                   - The order ID for the customer order.

                 * - ``accountId``

                     .. type:: string

                   - The account ID for the customer.

                 * - ``accountName``

                     .. type:: string

                   - The name of the account.

                 * - ``buyer``

                     .. type:: string

                   - The name of the buyer from account placing the order.

                 * - ``carrier``

                     .. type:: string

                   - The preferred carrier for this account.

                 * - ``service``

                     .. type:: string

                   - The preferred carrier service for this account.

                 * - ``paymentTerms``

                     .. type:: string

                   - The payment terms defined for this order.

                 * - ``shippingTerms``

                     .. type:: string

                   - The shipping terms defined for this order.

                 * - ``poNumber``

                     .. type:: string

                   - PO number used when placing the order.

                 * - ``deliveryName`` ``deliveryCompany`` ``deliveryEmail`` ``deliveryCell``
                     ``deliveryTele`` ``deliveryAddress`` ``deliveryCoaddress`` ``deliveryZipcode``
                     ``deliveryCity`` ``deliveryState``

                     .. type:: string

                   - The address the order should be delivered to.

                 * - ``deliveryCountry``

                     .. type:: string

                   - ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc).

                 * - ``products``

                     .. type:: array

                   - The product items in this supplier order delivery. Most of the fields are described in the :ref:`Get stock response <order-api-get-stock-response>` but the following ones are specific to supplier order deliveries:

                     .. list-table::
                        :widths: auto

                        * - ``quantity``

                            .. type:: int

                          - The amount of product items reserved from this supplier order delivery to the customer order.

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
       "orders": [
         {
           "orderId": "83982",
           "accountId": "478",
           "accountName": "Internal ROW",
           "buyer": "Internal ROW, John ",
           "carrier": "",
           "service": "",
           "other": "Other Comment",
           "paymentTerms": "30 Net",
           "shippingTerms": "Ex. Works",
           "poNumber": "Pre Spring 17",
           "deliveryName": "John Doe",
           "deliveryCompany": "A Company",
           "deliveryEmail": "info@example.com",
           "deliveryCell": "",
           "deliveryTele": "0",
           "deliveryAddress": "Skogsgatan 123",
           "deliveryCoaddress": "C/O: Warehouse",
           "deliveryZipcode": "12345",
           "deliveryCity": "Stockholm",
           "deliveryState": "0",
           "deliveryCountry": "SE",
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
         },
         { "orderId": "..."}
       ]
     }
   }
```
