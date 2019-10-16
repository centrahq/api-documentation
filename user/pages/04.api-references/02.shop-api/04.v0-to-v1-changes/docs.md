---
title: Shop API changes between v0 and v1
altTitle: v0 to v1 changes
excerpt: Click here to learn about the changes between v0 and v1 versions of Shop API
taxonomy:
  category: docs
---

This article explains the current changes from Shop API v0 to v1.

### Errors

v1 has a consistent way of reporting errors. The response contains an “errors” object. If there are no “errors” in the JSON, there are no errors and everything went well. There’s no need to check for “success” key in the response of the API v1. We need to only check if there’s errors key. v1 also validates input, v0 does not. This means v1 will return an error when you send unknown fields in the request, while v0 would have just silently discarded them.

Example:

```json
POST http://centra.com/api/shop/selections
{
  "country": "xx",
  "hello": "world"
}
```

Response:

```json
HTTP/1.1 400 Bad Request
{
  "errors": {
    "country": "country not found",
    "hello": "unknown"
  }
}
```

Also, the API will now fail if you send unknown fields like “hello” above.

### Selection (aka cart, basket) changes

v1 has a new set of API operations on selection “lines”. Each item in the selection has a unique “line” id. And the API operations change that specific line. This is because it is possible to have the same product many times in the same selection, on separate lines, with different prices. This can happen with discounts, for example, when you get one for a reduced price and the rest for the regular price. Usually on the checkout page you can change the quantity of the selection lines with numbers or +- buttons. These should be changed to use the “line” API operations.

### POST selections/{selection}/payment-result

This has changed significantly. In v0 you would post PHPs `$_REQUEST` directly to Centra:

```text
json_encode($_REQUEST);
```

In v1 you need to post in paymentMethodFields like this:

```text
json_encode(['paymentMethodFields' => $_REQUEST]);
```

### POST selections/{selection}/payment

v0 has a field called `extra_data` that is used for the Ingrid integration. In v1, use `additionalFields` instead.

### Endpoints missing in v0

There are some endpoints that are only available for v1, e.g. `categories/markets/{id}`, which is not available for v0.

### Shipping Methods

In v0 this was called `shippingList`, in v1 it was renamed to `shippingMethods`.

### Built in documentation

This part will become better, but right now you can get a list of API calls from the API with a `GET http://demo.centra.com/api/shop/v1` And each call will have a `helpUri` that will show more details about it, for example your new shipping-address thing: `PUT http://demo.centra.com/api/shop/v1/help/customers/{email}/orders/{order}/shipping-address`.

Right now all input is documented like this, we still need to add better descriptions of what the call does and document the output JSON.

### Many operations in one request

You can post a special JSON directly to the API endpoint to do many API operations with one HTTP request. This is a very quick and basic example of how it works, lets say you post this to your API endpoint `http://centra.com/api/shop`:

```json
{
 "first":{
  "method":"POST",
  "uri":"selections",
  "request":{
   "country":"se"
  }
 },
 "second":{
  "method":"POST",
  "uri":[
   "selections",
   {"previousResponse":"first:selection"},
   "items",
   "2-1"
  ]
 }
}
```

It creates a selection, then adds an item to that selection. The response is below because it’s long.

This is two requests. The `uri` field can be a regular string like `some/uri/lalala` or it can be an array split where the / would be like it is in the "second" request. The interesting thing is the `previousResponse`. This refers to a field in the response from the first operation. You can use this `previousResponse` syntax for any field in the uri (it must be an array then) or in the request. In this case it uses the selection id from the first request.

The API operations are run in order, and if anyone returns an error it will stop there and not run any more. You get all responses back so you know what has happened. You can use any names for the operations, you don’t have to use "first" and "second".

For Symfony sites, you can use the v1 API from the regular shop API endpoint by adding v1 to the url like `http://centra.com/api/shop/v1`. Also if you GET to the API endpoint you get a list of the API operations.

#### Example response

```json
{
"first": {
  "httpCode": 201,
  "httpHeader": "HTTP\/1.1 201 Created",
  "response": {
    "selection": "a3f33734b1fec73465229a5c41783c36",
    "country": "SE",
    "customer": "",
    "market": "2",
    "pricelist": "20",
    "currency": "SEK",
    "paymentMethod": null,
    "shippingMethod": "",
    "shippingMethodName": "",
    "paymentMethodsAvailable": {
      "adyen": {
        "paymentMethod": "adyen",
        "name": "Adyen",
        "useForDigitalContent": true,
        "providesCustomerAddressAfterPayment": false,
        "addressRequiredFields": [
          "firstName",
          "lastName",
          "address1",
          "zipCode",
          "city",
          "phoneNumber",
          "country"
        ],
        "clientSide": {
          "generation_date": "2015-08-12T19:07:27+02:00",
          "key": "hejsan"
        }
      },
      "dibs": {
        "paymentMethod": "dibs",
        "name": "dibs",
        "useForDigitalContent": true,
        "providesCustomerAddressAfterPayment": false,
        "addressRequiredFields": [
          "firstName",
          "lastName",
          "address1",
          "zipCode",
          "city",
          "phoneNumber",
          "country"
        ]
      },
      "dummy": {
        "paymentMethod": "dummy",
        "name": "dummy",
        "useForDigitalContent": true,
        "providesCustomerAddressAfterPayment": false,
        "addressRequiredFields": [
          "firstName",
          "lastName",
          "address1",
          "zipCode",
          "city",
          "phoneNumber",
          "country"
        ]
      },
      "klarna": {
        "paymentMethod": "klarna",
        "name": "Klarna",
        "useForDigitalContent": false,
        "providesCustomerAddressAfterPayment": false,
        "addressRequiredFields": [
          "firstName",
          "lastName",
          "address1",
          "zipCode",
          "city",
          "phoneNumber",
          "country"
        ]
      },
      "klarna-checkout": {
        "paymentMethod": "klarna-checkout",
        "name": "Klarna Checkout",
        "useForDigitalContent": false,
        "providesCustomerAddressAfterPayment": true,
        "addressRequiredFields": [
          "country"
        ]
      },
      "nets": {
        "paymentMethod": "nets",
        "name": "Nets",
        "useForDigitalContent": true,
        "providesCustomerAddressAfterPayment": false,
        "addressRequiredFields": [
          "firstName",
          "lastName",
          "address1",
          "zipCode",
          "city",
          "phoneNumber",
          "country"
        ]
      },
      "paypal": {
        "paymentMethod": "paypal",
        "name": "P\u00e4jP\u00e4l",
        "useForDigitalContent": true,
        "providesCustomerAddressAfterPayment": true,
        "addressRequiredFields": [
          "country"
        ]
      }
    },
    "shippingMethodsAvailable": [
    ],
    "items": [
    ],
    "discounts": {
      "anyDiscount": false,
      "discount": "0.00\u00a0SEK",
      "discountAsNumber": 0,
      "vouchers": [
      ]
    },
    "totals": {
      "itemsTotalPrice": "0.00\u00a0SEK",
      "itemsTotalPriceAsNumber": 0,
      "totalDiscountPrice": false,
      "totalDiscountPriceAsNumber": false,
      "shippingPrice": "0.00\u00a0SEK",
      "shippingPriceAsNumber": 0,
      "handlingCostAddedToShippingPrice": false,
      "totalQuantity": 0,
      "taxDeducted": false,
      "taxDeductedAsNumber": false,
      "taxAdded": false,
      "taxAddedAsNumber": false,
      "taxPercent": 0,
      "grandTotalPrice": "0.00\u00a0SEK",
      "grandTotalPriceAsNumber": 0,
      "grandTotalPriceTax": "0.00\u00a0SEK",
      "grandTotalPriceTaxAsNumber": 0
    },
    "vatExempt": false
  }
},
"second": {
  "httpCode": 201,
  "httpHeader": "HTTP\/1.1 201 Created",
  "response": {
    "line": "58a93367d233f53587c7ec38b70c3473",
    "selection": "a3f33734b1fec73465229a5c41783c36",
    "country": "SE",
    "customer": "",
    "market": "2",
    "pricelist": "20",
    "currency": "SEK",
    "paymentMethod": null,
    "shippingMethod": "",
    "shippingMethodName": "",
    "paymentMethodsAvailable": {
      "adyen": {
        "paymentMethod": "adyen",
        "name": "Adyen",
        "useForDigitalContent": true,
        "providesCustomerAddressAfterPayment": false,
        "addressRequiredFields": [
          "firstName",
          "lastName",
          "address1",
          "zipCode",
          "city",
          "phoneNumber",
          "country"
        ],
        "clientSide": {
          "generation_date": "2015-08-12T19:07:27+02:00",
          "key": "hejsan"
        }
      },
      "dibs": {
        "paymentMethod": "dibs",
        "name": "dibs",
        "useForDigitalContent": true,
        "providesCustomerAddressAfterPayment": false,
        "addressRequiredFields": [
          "firstName",
          "lastName",
          "address1",
          "zipCode",
          "city",
          "phoneNumber",
          "country"
        ]
      },
      "dummy": {
        "paymentMethod": "dummy",
        "name": "dummy",
        "useForDigitalContent": true,
        "providesCustomerAddressAfterPayment": false,
        "addressRequiredFields": [
          "firstName",
          "lastName",
          "address1",
          "zipCode",
          "city",
          "phoneNumber",
          "country"
        ]
      },
      "klarna": {
        "paymentMethod": "klarna",
        "name": "Klarna",
        "useForDigitalContent": false,
        "providesCustomerAddressAfterPayment": false,
        "addressRequiredFields": [
          "firstName",
          "lastName",
          "address1",
          "zipCode",
          "city",
          "phoneNumber",
          "country"
        ]
      },
      "klarna-checkout": {
        "paymentMethod": "klarna-checkout",
        "name": "Klarna Checkout",
        "useForDigitalContent": false,
        "providesCustomerAddressAfterPayment": true,
        "addressRequiredFields": [
          "country"
        ]
      },
      "nets": {
        "paymentMethod": "nets",
        "name": "Nets",
        "useForDigitalContent": true,
        "providesCustomerAddressAfterPayment": false,
        "addressRequiredFields": [
          "firstName",
          "lastName",
          "address1",
          "zipCode",
          "city",
          "phoneNumber",
          "country"
        ]
      },
      "paypal": {
        "paymentMethod": "paypal",
        "name": "P\u00e4jP\u00e4l",
        "useForDigitalContent": true,
        "providesCustomerAddressAfterPayment": true,
        "addressRequiredFields": [
          "country"
        ]
      }
    },
    "shippingMethodsAvailable": [
    ],
    "items": [
      {
        "item": "2-1",
        "product": "2",
        "brandName": "Brand",
        "productName": "\u221aEtt",
        "size": "",
        "sku": "p1v1",
        "ean": "",
        "silkProduct": "1",
        "silkVariant": "1",
        "quantity": 1,
        "comment": "",
        "line": "58a93367d233f53587c7ec38b70c3473",
        "priceEach": "99.99\u00a0SEK",
        "priceEachAsNumber": 99.99,
        "totalPrice": "99.99\u00a0SEK",
        "totalPriceAsNumber": 99.99,
        "priceEachBeforeDiscount": "99.99\u00a0SEK",
        "priceEachBeforeDiscountAsNumber": 99.99,
        "anyDiscount": false,
        "taxPercent": 25
      }
    ],
    "discounts": {
      "anyDiscount": false,
      "discount": "0.00\u00a0SEK",
      "discountAsNumber": 0,
      "vouchers": [
      ]
    },
    "totals": {
      "itemsTotalPrice": "99.99\u00a0SEK",
      "itemsTotalPriceAsNumber": 99.99,
      "totalDiscountPrice": false,
      "totalDiscountPriceAsNumber": false,
      "shippingPrice": "0.00\u00a0SEK",
      "shippingPriceAsNumber": 0,
      "handlingCostAddedToShippingPrice": false,
      "totalQuantity": 1,
      "taxDeducted": false,
      "taxDeductedAsNumber": false,
      "taxAdded": false,
      "taxAddedAsNumber": false,
      "taxPercent": 25,
      "grandTotalPrice": "99.99\u00a0SEK",
      "grandTotalPriceAsNumber": 99.99,
      "grandTotalPriceTax": "20.00\u00a0SEK",
      "grandTotalPriceTaxAsNumber": 20
    },
    "vatExempt": false
  }
}
}
```

You can also fallback on default values if the response does not contain anything:

```json
{
  "previousResponse":"some:field:somewhere",
  "default":"hello"
}
```
