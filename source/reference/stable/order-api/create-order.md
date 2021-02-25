# Create order

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: POST
   :url: *base*/order

.. authentication::
   :api_key: true
```

This will insert a new order directly into Centra bypassing any needs of a payment. This API could be used to directly import orders from external systems. The API-plugin needs to have "Allow Order Create" set as `true` to allow this call to be made.

```eval_rst
.. warning:: Remember that payments for these orders will not be handled at all by Centra. You must make sure the payments are handled and captured elsewhere.
```

```eval_rst
.. _create-order-parameters:
```

## Parameters

Here are the parameters allowed to create an order. There are some fields specific for B2B and B2C defined below.

```eval_rst
.. list-table::
   :widths: auto

   * - ``invoiceAddress`` ``deliveryAddress`` ``address``

       .. type:: object
          :required: false

     - For B2B the address object is not required as it will then use default address of the B2B-account.  If ``invoiceAddress`` and ``deliveryAddress`` are the same, ``address`` can be used instead.

       .. list-table::
          :widths: auto

          * - ``email``

              .. type:: string
                 :required: true

            - Customer e-mail

          * - ``firstName`` ``lastName``

              .. type:: string
                 :storetype: b2c
                 :required: false

            - Customer name

          * - ``tele`` ``cell``

              .. type:: string
                 :storetype: b2c
                 :required: false

            - Customer telephone / cellphone

          * - ``attn``

              .. type:: string
                 :storetype: b2b
                 :required: false

            - Attention (addressing memorandum)

          * - ``address`` ``coaddress`` ``city`` ``zipcode``

              .. type:: string
                 :required: false

            - Street Address

          * - ``state``

              .. type:: string
                 :required: false

            - Country state, might be required by the ``country``

          * - ``country``

              .. type:: string
                 :required: true

            - ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc)

   * - ``pricelistId``

       .. type:: int
          :required: false

     - ID of pricelist to use for the order, if not provided, the pricelist for the current country will be used.

   * - ``pricelist``

       .. type:: string
          :required: false

     - Name of pricelist to use for the order. Will only be used if ``pricelistId`` is not provided. If not provided, the pricelist for the current country will be used.
     
   * - ``marketId``

       .. type:: int
          :required: false

     - ID of the market to use for the order. If not provided, the market for the current country will be used.
     
   * - ``market``

       .. type:: string
          :required: false

     - Name of the market to use for the order. Will only be used if ``marketId`` is not provided. If not provided, the market for the current country will be used.

   * - ``customerRegister``

       .. type:: boolean
          :storetype: b2c
          :required: false

     - Default ``false``. If ``true``, the order will attach to the customer registered with the same e-mail provided in the API-call.

       If ``customerRegister`` is ``false``, the order will be created as a auto-created one and will not be visible by the signed in customer having the same e-mail.

   * - ``customerId``

       .. type:: int
          :storetype: b2c
          :required: false

     - If this one is set, the customer ID will be used as the way to attach the order to a customer, independently of the e-mail provided.

   * - ``customerSetNewPassword``

       .. type:: boolean
          :storetype: b2c
          :required: false

     - Default ``false``. Will flag the customer so the customer will receive a password reset e-mail when they try to sign in. This can be used when migrating customers over from another system.

   * - ``createdFromOrigin``

       .. type:: object
          :required: false

     - Specifies the origin that the order was created from. If used, it needs to refer to an internal object in Centra.
     
       .. list-table::
          :widths: auto

          * - ``type``

              .. type:: string
                 :required: true

            - Type of origin the order was created from. Allowed types: ``return``, ``order`` and ``plugin``

          * - ``id``

              .. type:: int
                 :required: true

            - ID of internal origin of the origin type. If Return #123 was used to create the order, ``id`` should be ``123``.

   * - ``accountId``

       .. type:: int
          :required: false
          :storetype: b2b

     - Account ID for B2B-customer. Required if order is placed for B2B.

   * - ``buyerId``

       .. type:: int
          :storetype: b2b
          :required: false

     - Buyer ID for B2B-customer. If not provided, the default buyer of the account will be used.

   * - ``buyerName``

       .. type:: string
          :storetype: b2b
          :required: false

     - Name of the buyer that placed the order.

   * - ``deliveryWindow``

       .. type:: string
          :storetype: b2b
          :required: false

     - Name of the Delivery Window being used when placing the order. Depending if the products are set to preorder or not, the order might extract stock or not.

   * - ``products``

       .. type:: object
          :required: true

     - Contains the products for the order.

       .. list-table::
          :widths: auto

          * - ``qty``

              .. type:: int
                 :required: true

            - Quantity ordered for this product.

          * - ``id``

              .. type:: int
                 :required: false

            - ID specific to the product size.

              Either ``id``, ``ean``, ``sku`` or ``item`` must be used.

          * - ``ean``

              .. type:: string
                 :required: false

            - EAN of product item.

              Either ``id``, ``ean``, ``sku`` or ``item`` must be used.

          * - ``sku``

              .. type:: string
                 :required: false

            - SKU of product item. Should either be the Size SKU or a combination of Product SKU + Variant SKU + Size SKU.

              Either ``id``, ``ean``, ``sku`` or ``item`` must be used.
              
          * - ``item``

              .. type:: string
                 :required: false

            - Item of product item. This is the same identifier as in Shop API / Checkout API item.

              Either ``id``, ``ean``, ``sku`` or ``item`` must be used.
              
          * - ``unitPrice``

              .. type:: decimal2 (0.00)
                 :required: false

            - Unit price used for the sale of this product. If not set, the pricelist value (in combination with current campaign discounts set up in Centra) will be used.

          * - ``originalPrice``

              .. type:: decimal2 (0.00)
                 :required: false

            - The original unit price used for the product. Will calculate what discount the customer got when the order was placed. If not set, the price from the current pricelist will be used.

          * - ``comment``

              .. type:: string
                 :required: false

            - A specific comment for the product. Can be used to define a specific date for each product, or a customized comment. Will show up on delivery notes and pack-lists.

          * - ``itemText``

              .. type:: object
                 :required: false

            - Ability to define every column specifying the product information. Very useful when importing old orders for products not in Centra.

              .. list-table::
                 :widths: auto

                 * - ``sku``

                     .. type:: string
                        :required: false

                   - The SKU for this product.

                 * - ``brand``

                     .. type:: string
                        :required: false

                   - The Brand name for this product.

                 * - ``product``

                     .. type:: string
                        :required: false

                   - Product name.

                 * - ``variant``

                     .. type:: string
                        :required: false

                   - The variant name of the product.

                 * - ``size``

                     .. type:: string
                        :required: false

                   - The size name for this product. To make sure all visual representations in Centra looks good, please make sure this size exists on the sizechart selected for the product you used inside ``id``, ``ean`` or ``sku``.

   * - ``shippingValue``

       .. type:: decimal2 (0.00)
          :required: false

     - Shipping cost, for example: `12.43`, without this one, the default shipping cost for the products and country will be used.

   * - ``voucherValue``

       .. type:: decimal2 (0.00)
          :required: false

     - Voucher value, should always be positive value, even though the value ends up reducing the order value. Without this one, the default shipping cost for the products and country will be used.

   * - ``orderNumber``

       .. type:: int
          :required: false

     - Explictly set the order number for the order. Will only work if the order does not already exist in Centra.

   * - ``sendEmail``

       .. type:: boolean
          :required: false

     - Send order confirmation or not, if not provided, the store settings will be used.

   * - ``applyVouchers``

       .. type:: boolean
          :required: false

     - Default ``true``. If Centra should calculate the voucher value depending on automatic voucher rules.

   * - ``adjustStock``

       .. type:: boolean
          :required: false

     - Default ``true``. Extract products from stock and fail with error if stock does not exist. If ``deliveryWindow`` is set as preorder this setting will not matter.

   * - ``forceCreate``

       .. type:: boolean
          :required: false

     - Default ``false``. Create the order even though products did not exist. These products will be marked as back ordered.

   * - ``comment``

       .. type:: string
          :required: false

     - Text to place inside the "Other Information" field. Might show up on pack-lists and delivery notes depending on store settings.

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

     - Used to define which allocation rule (previously known as "warehouse group") it should use. Default will use the one set for the market.

   * - ``createOnly``

       .. type:: boolean
          :required: false

     - Default ``false``. Only prepare the order with all data, can be finalized later using :doc:`completeOrder </reference/stable/order-api/complete-order>`.

   * - ``internalOrder``

       .. type:: boolean
          :required: false

     - Default ``false``. Mark the order as internal, will show up in reports as an internal order.

   * - ``payment``

       .. type:: object
          :required: false

     - Will contain information that should be inserted in regards to how the payment was handled outside of Centra.

       .. list-table::
          :widths: auto

          * - ``id``

              .. type:: int

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

                   - The amount that was authorized/captured.

                 * - ``external_url``

                     .. type:: string
                        :required: false

                   - If an external invoice was created, insert the URL to the invoice here.

```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   POST <base>/order HTTP/1.1
   Content-type: application/json

   {
      "invoiceAddress": {
          "country": "SE",
          "firstName": "John",
          "lastName": "Smith",
          "address": "12 Alto Road",
          "coaddress": "c/o Peter",
          "zipcode": "90212",
          "city": "San Francisco",
          "email": "x@example.com"
      },
      "deliveryAddress": {
          "country": "US",
          "firstName": "John",
          "lastName": "Smith",
          "address": "1500 California St",
          "coaddress": "c/o Peter",
          "zipcode": "90210",
          "city": "San Francisco",
          "state": "CA"
      },
      "products": [
          {
              "qty": 2,
              "ean": "ABCDEFGHIJKL",
              "unitPrice": 14.11,
              "originalPrice": 100.11,
              "itemText" : {
                "sku": "SPECIAL-SKU-FOR-THIS-ONE",
                "product": "A special product",
                "variant": ""
              }
          },
          {
              "qty": 1,
              "sku": "SKUASKUBSKUC",
              "unitPrice": 12.11,
              "originalPrice": 50.22
          }
      ],
      "payment": {
          "id": 49,
          "auth": {
              "status": 1,
              "response": "[PSP response]",
              "transaction": "[Auth transation ID]",
              "method": "cc",
              "amount": 100.00
          },
          "capture": {
              "status": 1,
              "response": "[PSP response]",
              "transaction": "[Capture transation ID]",
              "method": "cc",
              "amount": 100.00
          }
       }
    }
```

The response will return an array of orders when the call was successful (unless you used `createOnly` set as `true`). This is because the order might have been split into different orders depending on rules inside Centra.

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
          :required: false

     - Will return if ``createOnly`` was set as ``true``.

   * - ``orders``

       .. type:: array of int
          :required: false

     - List of order numbers created. An order might split up in multiple orders after completing it, this is why you might get multiple orders back.

   * - ``msg``

       .. type:: string
          :required: false

     - If ``status`` returns ``no``, this value should send back a message why it failed.
```

## Response examples

```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 200 OK
   Content-type: application/json

   {
      "status": "ok",
      "orders": [
        1234
      ]
   }
```

If `createOnly` is set to `true`, the response looks like this:

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "ok",
     "order": 1234
   }
```

## Error example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "no",
     "msg": "Message about why the order failed to be created."
   }
```
