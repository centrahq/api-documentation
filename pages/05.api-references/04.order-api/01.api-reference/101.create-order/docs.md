---
title: Order API - Create Order
altTitle: Create Order
excerpt: Creating Order.
taxonomy:
  category: docs
---

# Create order

Endpoint: `POST  *base*/order`  
Authentication: [API Key](/api-references/api-intro#authentication)

This will insert a new order directly into Centra bypassing any needs of a payment. This API could be used to directly import orders from external systems. The API-plugin needs to have "Allow Order Create" set as `true` to allow this call to be made.

[notice-box=alert]
Remember that payments for these orders will not be handled at all by Centra. You must make sure the payments are handled and captured elsewhere.
[/notice-box]

## Parameters

Here are the parameters allowed to create an order. There are some fields specific for B2B and B2C defined below.

[parameter data="invoiceAddress deliveryAddress address" datatype="object" isRequired=false sublevel=1]
For B2B the address object is not required as it will then use default address of the B2B-account.  If ``invoiceAddress`` and ``deliveryAddress`` are the same, ``address`` can be used instead.
[/parameter]

[parameter data="email" datatype="string" isRequired=true sublevel=2]
Customer e-mail
[/parameter]

[parameter data="firstName lastName" datatype="string" isRequired=false storeType="b2c" sublevel=2]
Customer name
[/parameter]

[parameter data="tele cell" datatype="string" isRequired=false storeType="b2c" sublevel=2]
Customer telephone / cellphone
[/parameter]

[parameter data="attn" datatype="string" isRequired=false storeType="b2b" sublevel=2]
Attention (addressing memorandum)
[/parameter]

[parameter data="address coaddress city zipcode" datatype="string" isRequired=false sublevel=2]
Street Address
[/parameter]

[parameter data="state" datatype="string" isRequired=false sublevel=2]
Country state, might be required by the ``country``
[/parameter]

[parameter data="country" datatype="string" isRequired=true sublevel=2]
ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc)
[/parameter]

[parameter data="pricelistId" datatype="int" isRequired=false sublevel=1]
ID of pricelist to use for the order, if not provided, the pricelist for the current country will be used.
[/parameter]

[parameter data="pricelist" datatype="string" isRequired=false sublevel=1]
Name of pricelist to use for the order. Will only be used if ``pricelistId`` is not provided. If not provided, the pricelist for the current country will be used.
[/parameter]

[parameter data="marketId" datatype="int" isRequired=false sublevel=1]
ID of the market to use for the order. If not provided, the market for the current country will be used.
[/parameter]

[parameter data="market" datatype="string" isRequired=false sublevel=1]
Name of the market to use for the order. Will only be used if ``marketId`` is not provided. If not provided, the market for the current country will be used.
[/parameter]

[parameter data="customerRegister" datatype="boolean" isRequired=false storeType="b2c" sublevel=1]
Default ``false``. If ``true``, the order will attach to the customer registered with the same e-mail provided in the API-call.
If ``customerRegister`` is ``false``, the order will be created as a auto-created one and will not be visible by the signed in customer having the same e-mail.
[/parameter]

[parameter data="customerId" datatype="int" isRequired=false storeType="b2c" sublevel=1]
If this one is set, the customer ID will be used as the way to attach the order to a customer, independently of the e-mail provided.
[/parameter]

[parameter data="customerSetNewPassword" datatype="boolean" isRequired=false storeType="b2c" sublevel=1]
Default ``false``. Will flag the customer so the customer will receive a password reset e-mail when they try to sign in. This can be used when migrating customers over from another system.
[/parameter]

[parameter data="createdFromOrigin" datatype="object" isRequired=false sublevel=1]
Specifies the origin that the order was created from. If used, it needs to refer to an internal object in Centra.
[/parameter]

[parameter data="type" datatype="string" isRequired=true sublevel=2]
Type of origin the order was created from. Allowed types: ``return``, ``order`` and ``plugin``
[/parameter]

[parameter data="id" datatype="int" isRequired=true sublevel=2]
ID of internal origin of the origin type. If Return #123 was used to create the order, ``id`` should be ``123``.
[/parameter]

[parameter data="extraAttributes" datatype="object" isRequired=false sublevel=1]
Object for sending in custom order attributes.
[/parameter]

[parameter data="attributeName_elementName" datatype="any" isRequired=false sublevel=2]
List of key-value pairs for every attribute element you want to set. Send it as an empty string to remove the current content.
[/parameter]

[parameter data="accountId" datatype="int" isRequired=false storeType="b2b" sublevel=1]
Account ID for B2B-customer. Required if order is placed for B2B.
[/parameter]

[parameter data="buyerId" datatype="int" isRequired=false storeType="b2b" sublevel=1]
Buyer ID for B2B-customer. If not provided, the default buyer of the account will be used.
[/parameter]

[parameter data="buyerName" datatype="string" isRequired=false storeType="b2b" sublevel=1]
Name of the buyer that placed the order.
[/parameter]

[parameter data="deliveryWindow" datatype="string" isRequired=false storeType="b2b" sublevel=1]
Name of the Delivery Window being used when placing the order. Depending if the products are set to preorder or not, the order might extract stock or not.
[/parameter]

[parameter data="products" datatype="object" isRequired=true sublevel=1]
Contains the products for the order.
[/parameter]

[parameter data="qty" datatype="int" isRequired=true sublevel=2]
Quantity ordered for this product.
[/parameter]

[parameter data="id" datatype="int" isRequired=false sublevel=2]
ID specific to the product size.
Either ``id``, ``ean`` or ``sku`` must be used.
[/parameter]

[parameter data="ean" datatype="string" isRequired=false sublevel=2]
EAN of product item.
Either ``id``, ``ean`` or ``sku`` must be used.
[/parameter]

[parameter data="sku" datatype="string" isRequired=false sublevel=2]
SKU of product item. Should either be the Size SKU or a combination of Product SKU + Variant SKU + Size SKU.
Either ``id``, ``ean`` or ``sku`` must be used.
[/parameter]

[parameter data="unitPrice" datatype="decimal2 (0.00)" isRequired=false sublevel=2]
Unit price used for the sale of this product. If not set, the pricelist value (in combination with current campaign discounts set up in Centra) will be used.
[/parameter]

[parameter data="originalPrice" datatype="decimal2 (0.00)" isRequired=false sublevel=2]
The original unit price used for the product. Will calculate what discount the customer got when the order was placed. If not set, the price from the current pricelist will be used.
[/parameter]

[parameter data="comment" datatype="string" isRequired=false sublevel=2]
A specific comment for the product. Can be used to define a specific date for each product, or a customized comment. Will show up on delivery notes and pack-lists.
[/parameter]

[parameter data="itemText" datatype="object" isRequired=false sublevel=2]
Ability to define every column specifying the product information. Very useful when importing old orders for products not in Centra.
[/parameter]

[parameter data="sku" datatype="string" isRequired=false sublevel=3]
The SKU for this product.
[/parameter]

[parameter data="brand" datatype="string" isRequired=false sublevel=3]
The Brand name for this product.
[/parameter]

[parameter data="product" datatype="string" isRequired=false sublevel=3]
Product name.
[/parameter]

[parameter data="variant" datatype="string" isRequired=false sublevel=3]
The variant name of the product.
[/parameter]

[parameter data="size" datatype="string" isRequired=false sublevel=3]
The size name for this product. To make sure all visual representations in Centra looks good, please make sure this size exists on the sizechart selected for the product you used inside ``id``, ``ean`` or ``sku``.
[/parameter]

[parameter data="localizedProdSize" datatype="object" isRequired=false sublevel=3]
The localized size information for this product size. It contains the localized size ``localizedSize`` and localized size chart name ``localizationDefinitionName``.
[/parameter]

[parameter data="shippingList" datatype="string" isRequired=false sublevel=1]
Shipping option URI, for example: `ups-standard`, without this one, the default shipping option for the products and country will be used.
[/parameter]

[parameter data="shippingValue" datatype="decimal2 (0.00)" isRequired=false sublevel=1]
Shipping cost, for example: `12.43`, without this one, the default shipping cost for the products and country will be used.
[/parameter]

[parameter data="voucherValue" datatype="decimal2 (0.00)" isRequired=false sublevel=1]
Voucher value, should be a positive value or zero, even though the value ends up reducing the order value.
[/parameter]

[parameter data="orderNumber" datatype="int" isRequired=false sublevel=1]
Explictly set the order number for the order. Will only work if the order does not already exist in Centra.
[/parameter]

[parameter data="sendEmail" datatype="boolean" isRequired=false sublevel=1]
Send order confirmation or not, if not provided, the store settings will be used.
[/parameter]

[parameter data="adjustStock" datatype="boolean" isRequired=false sublevel=1]
Default ``true``. Extract products from stock and fail with error if stock does not exist. If ``deliveryWindow`` is set as preorder this setting will not matter.
[/parameter]

[parameter data="forceCreate" datatype="boolean" isRequired=false sublevel=1]
Default ``false``. Create the order even though products did not exist. These products will be marked as back ordered.
[/parameter]

[parameter data="comment" datatype="string" isRequired=false sublevel=1]
Text to place inside the "Other Information" field. Might show up on pack-lists and delivery notes depending on store settings.
[/parameter]

[parameter data="internalComment" datatype="string" isRequired=false sublevel=1]
Text for the "Internal comment"-field. Will only be shown internally in Centra.
[/parameter]

[parameter data="poNumber" datatype="string" isRequired=false storeType="b2b" sublevel=1]
PO number used when placing the order. Will be visible on delivery notes and invoices.
[/parameter]

[parameter data="orderDate" datatype="date/datetime" isRequired=false sublevel=1]
The time when the order was placed. Timezone is based on the location of the organization's Centra settings.
[/parameter]

[parameter data="deliveryDate" datatype="date/datetime" isRequired=false sublevel=1]
Expected time of delivery.
[/parameter]

[parameter data="cancelDate" datatype="date/datetime" isRequired=false sublevel=1]
Date when order should be cancelled if not confirmed.
[/parameter]

[parameter data="warehouseGroup" datatype="string" isRequired=false sublevel=1]
Used to define which allocation rule (previously known as "warehouse group") it should use. Default will use the one set for the market.
[/parameter]

[parameter data="createOnly" datatype="boolean" isRequired=false sublevel=1]
Default ``false``. Only prepare the order with all data, can be finalized later using :doc:`completeOrder </reference/stable/order-api/complete-order>`.
[/parameter]

[parameter data="internalOrder" datatype="boolean" isRequired=false sublevel=1]
Default ``false``. Mark the order as internal, will show up in reports as an internal order.
[/parameter]

[parameter data="payment" datatype="object" isRequired=false sublevel=1]
Will contain information that should be inserted in regards to how the payment was handled outside of Centra.
[/parameter]

[parameter data="id" datatype="int" sublevel=2]
The ID of the payment plugin used from Centra. If not used, the order will not be marked with a payment type at all.
[/parameter]

[parameter data="auth / capture" datatype="object" isRequired=false sublevel=2]
Information about the authorization and capture of the order. Authorization was the reservation of the order, capture is when the value also has been charged. You can add separate information via `payment.auth` and `payment.capture` objects.
[/parameter]

[parameter data="response" datatype="string" isRequired=false sublevel=3]
The response string from the payment type. Will be shown verbose inside Centra.
[/parameter]

[parameter data="status" datatype="int" isRequired=true sublevel=3]
If the authorization/capture went through or not. ``0`` means pending, ``1`` means success, ``2`` means failed.
[/parameter]

[parameter data="transaction" datatype="string" isRequired=false sublevel=3]
The transaction ID of the authorization/capture.
[/parameter]

[parameter data="method" datatype="string" isRequired=false sublevel=3]
Will be shown on reports to summarize what payment method was used.
[/parameter]

[parameter data="amount" datatype="decimal2 (0.00)" isRequired=true sublevel=3]
The amount that was authorized.
[/parameter]

[parameter data="external_url" datatype="string" isRequired=false sublevel=3]
If an external invoice was created, insert the URL to the invoice here.
[/parameter]

[parameter data="applyVouchers" datatype="boolean" isRequired=false sublevel=1]
Default ``true``. If Centra should calculate the voucher value depending on automatic voucher rules.
[/parameter]

[parameter data="voucherCodes" datatype="array" isRequired=false sublevel=1]
Array of voucher codes to apply on the order.
[/parameter]

## Request example

```http
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
      "id": 36,
      "auth": {
          "status": 1,
          "transaction": "894751945132",
          "method": "cc",
          "amount": 26.22
      },
      "capture": {
          "status": 1,
          "transaction": "154342468439",
          "method": "cc",
          "amount": 26.22
      }
  },
  "voucherCodes": ["MyFirstGiftcard", "New10PercentOff"]
}
```

The response will return an array of orders when the call was successful (unless you used `createOnly` set as `true`). This is because the order might have been split into different orders depending on rules inside Centra.

## Response

`200` `Content-type: application/json`

[parameter data="status" datatype="string" isRequired=true sublevel=1]
``ok`` if success, else ``no``.
[/parameter]

[parameter data="order" datatype="int" isRequired=false sublevel=1]
Will return if ``createOnly`` was set as ``true``.
[/parameter]

[parameter data="orders" datatype="array of int" isRequired=false sublevel=1]
List of order numbers created. An order might split up in multiple orders after completing it, this is why you might get multiple orders back.
[/parameter]

[parameter data="msg" datatype="string" isRequired=false sublevel=1]
If ``status`` returns ``no``, this value should send back a message why it failed.
[/parameter]

## Response examples

```http
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

```json
{
  "status": "ok",
  "order": 1234
}
```

## Error example

Errors will always be returned with "status" as "no" it will also contain a code and a message with more details
the codes and their general meaning is as follows


|Code|Description|
|---|-------|
|-1|Some of the provided products are not possible to add to the order, product status, market or pricelist might not be properly configured inside centra.|
|-2|Stock error, one or more products are missing stock|
|-3|Order is empty|
|-4|One or more required fields are missing|
|-5|An order with the provided order number already exists|
|-6|Customer registration failed|
|-7|General error, see message for details|

```json
{
  "status": "no",
  "code": -7,
  "msg": "Message about why the order failed to be created."
}
```
