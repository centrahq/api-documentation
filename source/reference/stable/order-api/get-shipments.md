```eval_rst
.. _order-api-get-shipments:
```

# Get shipments

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: GET
   :url: *base*/shipments?[&limit=5][&order=83651]

.. authentication::
   :api_key: true
```

Will list all Good to Go-shipments that are not sent. Oldest first.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``limit``

       .. type:: int
          :required: false

     - Limit amount of shipments returned. For statuses `inprogress` and `completed` a positive value between 1 and 100.

   * - ``order``

       .. type:: int
          :required: false

     - Return shipments for a specific order.

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.

   * - ``offset``

       .. type:: int
          :required: false

     - Offset how far in to start returning orders.     
     
   * - ``status``

       .. type:: string
          :required: false

     - Default value: `goodtogo`. Allowed values: `inprogress`, `goodtogo`, `completed`
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   GET <base>/shipments?limit=5 HTTP/1.1

```

```eval_rst
.. _get-shipments-response:
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

   * - ``shipments``

       .. type:: array
          :required: true

     - Array of shipments returned.

       .. list-table::
          :widths: auto

          * - ``orderId``

              .. type:: string

            - Id of the order.

          * - ``shipmentId``

              .. type:: string

            - Id of the shipment.

          * - ``selectionId``

              .. type:: string

            - Selection ID of the order.

          * - ``orderDate``

              .. type:: datetime

            - Date when order was created.

          * - ``shouldCapture``

              .. type:: boolean

            - If the shipment needs to be captured before being shipped.

          * - ``deliveryNote``

              .. type:: string
                 :required: false

            - URL to a PDF delivery note for the shipment.

          * - ``shippingTerms``

              .. type:: object
                 :required: false

            - Shipping Terms object selected on this shipment.
            
              .. list-table::
                 :widths: auto

                 * - ``id``

                     .. type:: int

                   - Id of the specific shipping terms object.

                 * - ``name``

                     .. type:: string

                   - Name of the specific shipping terms object.
                   
                 * - ``description``

                     .. type:: string

                   - Description of the specific shipping terms object.
          
          * - ``paymentTerms``

              .. type:: object
                 :required: false

            - Payment Terms object selected on this shipment.
            
              .. list-table::
                 :widths: auto

                 * - ``id``

                     .. type:: int

                   - Id of the specific payment terms object.

                 * - ``name``

                     .. type:: string

                   - Name of the specific payment terms object.
                   
                 * - ``description``

                     .. type:: string

                   - Description of the specific payment terms object.
                      
          * - ``proforma``

              .. type:: string
                 :required: false

            - URL to a PDF proforma for the shipment.

          * - ``defaultCarrier``

              .. type:: string
                 :required: false

            - Name of the carrier for this shipment.

          * - ``deliveryService``

              .. type:: string
                 :required: false

            - Name of the delivery service for this shipment.

          * - ``invoices``

              .. type:: array
                 :required: false

            - URLs to PDF invoices for the shipment. Will only be set if any invoices exists.


          * - ``products``

              .. type:: array

            - Products inside the shipment.

              .. list-table::
                 :widths: auto

                 * - ``lineId``

                     .. type:: string

                   - Id of the specific product item in this shipment.

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
     "shipments": [
       {
         "orderId": "83651",
         "selectionId": "ff805e6dc70f905553e2225c6977a27a",
         "orderDate": "2012-02-04 15:16:13",
         "cancelDate": "2012-08-04 15:16:13",
         "preferredDeliveryDate": "2012-05-04 15:16:13",
         "estimatedDeliveryDate": "2012-05-04 15:16:13",
         "orderStore": "retail",
         "orderCurrency": "EUR",
         "shipmentId": "83651-1",
         "customerId": "11627",
         "accountId": "0",
         "deliveryName": "Someones Name",
         "deliveryCompany": "",
         "deliveryEmail": "someone@example.com",
         "deliveryCell": "+4912345678",
         "deliveryTele": "",
         "deliveryAddress": "Examplestreet 1",
         "deliveryCoaddress": "",
         "deliveryZipcode": "12345",
         "deliveryCity": "Somecity",
         "deliveryState": "",
         "deliveryCountry": "DE",
         "billingVAT": "",
         "poNumber": "",
         "shippingList": "standard",
         "shippingTerms": {
            "id": 5, 
            "name": "ShippingTermName", 
            "description": "ShippingTermDescription"
         },
         "paymentTerms": {
            "id": 10, 
            "name": "PaymentTermName", 
            "description": "PaymentTermDescription"
         },
         "proforma": "http://.../proforma?shipment=83651-1",
         "deliveryNote": "http://../delnote?shipment=83651-1",
         "defaultCarrier": "Delivery Carrier",
         "deliveryService": "Delivery Service",
         "shipmentDate": "2019-07-01 12:56:00",
         "trackingNumber": "123456789",
         "trackingUrl": "https://www.dhl.com.pl/exp-en/express/tracking.html?AWB=123456789",
         "returnSlipTracking": "123456789",
         "invoices": [
           "https://online.klarna.com/invoice_public_show.yaws/invoice.pdf?invno=&orgno="
         ],
         "suspect": 0,
         "hold": 0,
         "paid": 1,
         "shouldCapture": 0,
         "shippingValue": 25,
         "voucherValue": 0,
         "grandTotalValue": 3978.75,
         "grandTotalTaxValue": 795.75,
         "internalComment": "",
         "otherComment": "",
         "products": [
           {
             "lineId": "43243",
             "sku": "S123K456U1",
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
             "comment": "",
             "warehouses": [
                {
                    "name": "Default warehouse",
                    "itemQty": "1"
                }
             ]
           },
           {
             "lineId": "43244",
             "sku": "S123K456U2",
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
             "weightUnit": "kg",
             "countryOfOrigin": "CI",
             "harmCode": "12345",
             "comment": ""
           }
         ]
       }
     ]
   }
```
