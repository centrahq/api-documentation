# Update shipment

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: PUT
   :url: *base*/shipments/*shipmentId*

.. authentication::
   :api_key: true
```

This will modify the products on the shipment, keeping the same `shipmentId`. This function can only be done on existing shipments that:

* Has not been shipped.
* Has not been captured or paid.
* Does not have any returns.

To be able to use this call, you need to create a shipment using `"capture": false` so the create shipment call is not trying to capture the money.

```eval_rst
.. warning:: If the automatic capture when creating shipments is disabled, to avoid sending shipments that has not been captured you need to :ref:`Capture Shipment <order-api-capture-shipment>` before you ship it.
```

If no products are sent, the products will not be updated. This can be used to only update the GTG (Good to Go) status of an order.

If you need to remove the shipment, use the [Delete Shipment](delete-shipment) method.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``shipmentId``

       .. type:: string
          :required: true

     - The ID from ``shipment`` when creating or updating a shipment.
     
   * - ``gtg``

       .. type:: boolean
          :required: false

     - Default ``0``. Update shipment with Good to Go.

   * - ``products``

       .. type:: object
          :required: false

     - Key is ``lineID`` from the :ref:`Get orders response <get-orders-response>` and value is the ``quantity``.

       Example: ``{"products":{"1441":3}}`` will update a shipment to 3 products from item ``1441``.

       .. list-table::
          :widths: auto

          * - key in object

              .. type:: string
                 :required: true

            - ``lineID`` from the :ref:`Get orders response <get-orders-response>` referring to a specific product item in the order.

          * - value in object

              .. type:: int
                 :required: true

            - Quantity of the item that should be set for the shipment.

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   PUT <base>/shipments/23123 HTTP/1.1
   Content-type: application/json

   {
     "gtg":1,
     "products": {
       "43243": 1,
       "43244": 2,
       "43245": {
         "serialNumber": "newSerialNumber",
         "qty": 5
       }
     }
   }

```

## Response

`200` `Content-type: application/json`

Response is explained in the [Create Shipment Response](create-shipment-response).

## Response example

```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 200 OK
   Content-type: application/json

   {
     "status": "ok",
     "shipment": {
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
       "deliveryEmail": "tetete@ttet.com",
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
       "proforma": "http://.../proforma?shipment=83651-1",
       "deliveryNote": "http://../delnote?shipment=83651-1",
       "invoices": [
         "https://online.klarna.com/invoice_public_show.yaws/invoice.pdf?invno=<>&orgno="
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
           "sku": "B405916999",
           "variantSku": "",
           "sizeSku": "",
           "name": "Product #1",
           "variant": "White",
           "size": "XS",
           "ean": "7332577534606",
           "qty": 1,
           "originalPrice": 500.5,
           "price": 450.5,
           "weight": 2,
           "weightUnit": "kg",
           "countryOfOrigin": "DE",
           "harmCode": "345345435",
           "comment": ""
         },
         {
           "lineId": "43244",
           "sku": "C00622469B",
           "variantSku": "",
           "sizeSku": "",
           "name": "Product #2",
           "variant": "Blue",
           "size": "XS",
           "ean": "7332577652942",
           "qty": 2,
           "originalPrice": 200.5,
           "price": 180.5,
           "weight": 1.5,
           "weightUnit": "kg",
           "countryOfOrigin": "CI",
           "harmCode": "423432",
           "comment": ""
         }
       ]
     }
   }
```

## Error examples

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "no",
     "msg": "shipment is sent and can not be updated",
     "shipment": "4-1"
   }
```

```eval_rst
.. code-block:: json
   :linenos:

   {
       "status": "no",
       "msg": "shipment has refunds and can not be updated",
       "shipment": "4-1"
   }
```
