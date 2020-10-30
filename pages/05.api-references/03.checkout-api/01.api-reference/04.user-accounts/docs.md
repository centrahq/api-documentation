---
title: Checkout API - User accounts
altTitle: User accounts
excerpt: Overview of User accounts
taxonomy:
  category: docs
---

## Overview

Register:
- POST register
- POST login/{email}
- POST logout

Change the registered address, email, password:
- PUT address
- PUT email
- PUT password

Get pervious orders:
- POST orders

Password reset email sending and use:
- POST password-reset-email/{email}
- POST password-reset

Reminder of how the errors work in the API: If the response does not contain an "errors" object, there are no errors, the operation was successful. This is important here, for example the register operation does not return "register=success". (you also get a return code over 400 for errors)

When you are logged in, the response JSON contains a "loggedIn" object with the customers address. This is the data we have in Centra today, we have 1 address and no separate shipping addresses. The login is connected to the token:

```json
{
  "token": "cstvqilgkdkoijj8ac9fm9o0g0",
  ...
  "loggedIn": {
    "email": "hello@example.com",
    "firstName": "Hello",
    "lastName": "World",
    "address1": "Address One",
    "address2": "Address Two",
    "zipCode": "12345",
    "city": "add",
    "state": "",
    "country": "SE",
    "phoneNumber": "123456789"
  }
}
```

3 operations will login:
- POST login/{email}
- POST register
- POST password-reset (this is used when you click on the link in the password reset email)

When you are logged in, the items you add to your selection are saved to your account. If you log in on a different computer you have the same items.

If you have items in the selection before you login, they are added to your saved selection. So it will contain your previously saved items plus these new ones.

If you log out, the login is removed from the token, and the selection is empty.

Please see the swagger for the input fields.

Some operations are only allowed if you are logged in. If you are not, they will respond with http code 403 Forbidden and
```json
{
      "errors": {
          "accessRight": "denied"
      }
}
```

### POST register

This will register a new customer and login. If all goes well, you get back the regular JSON data with a "loggedIn" object.

Possible errors (there are more than this):
- response code 409: "email":"already registered"
- response code 406: "password":"not valid" if Centra thinks the password is not good enough. I dont know what criteria it has.

### POST login/{email}

This will login (yes, really). You get the same regular JSON back as with register.

If it fails you get response code 406 and errors with "password":"incorrect". This happens even if the email is not for a registered customer, this call will not reveal if a customer exists or not. You will find out if you use register or password-reset-email

### POST logout

This just logs out. You get the regular JSON response back, now the "loggedIn" is gone

### POST password-reset-email/{email} + POST password-reset

The first will send an email with a password reset link. You can specify the URI of the link, but the base URL must be set in the Centra checkout API plugin. So you cannot send emails to people that point to other domains.

The second is used when the customer clicks the link in the email. You need to pass on the hash from the link to the API.

Example:
```http request
POST /password-reset-email/same@example.com
{
    "linkUri": "my-uri/with/slashes"
}
```

The "linkUri" is optional, but Centra MUST be setup with a frontend URL.

The email contains this link:

https://mywebshop.example.com/my-uri/with/slashes?id=48&i=8a87a9e9fea3c3cfdea183b281ec43f3

When the customer clicks on it, you need to send the "id" and "i" and "newPassword" to the API:
```http request
POST /password-reset
{
  "newPassword":"secret!",
  "i":"8a87a9e9fea3c3cfdea183b281ec43f3",
  "id":"48"
}
```

After this the password is changed and you are logged in.

### PUT address, PUT email, PUT password

These just change the address, email and password. I hope the swagger is enough explanation.


### POST orders

This returns a list of the customers previous orders, with shipments and tracking links.

POST "from" and "size" paramters for paging. Without them all orders will be returned. If a customer has a lot of orders it could be slow to get all of them.

The response looks similar to the regular JSON response, except it contains an "orders" object that is an array of orders. And a "ordersPaging" object that keeps track of paging.

Example:
```http request
POST orders
{
    "from":3,
    "size":2
}
```

Response:
```json
{
  "token": "cstvqilgkdkoijj8ac9fm9o0g0",
  "orders": [
    {
      "order": "575",
      "status": "untouched",
      "statusDescription": "Pending",
      "message": "Thank you for your order!",
      "date": "2015-10-20 16:01:34",
      "currency": "USD",
      "paymentMethod": "paypal",
      "paymentMethodName": "P\u00e4jP\u00e4l",
      "shippingMethod": "",
      "shippingMethodName": "",
      "items": [
        {
          "item": "2-1",
          "product": "2",
          "brandName": "Brand",
          "productName": "\u221aEtt",
          "size": "",
          "sku": "p1v1",
          "ean": "",
          "quantity": 1,
          "storePickup": false,
          "line": "17d0eaf6e6a165676cf39222ffc81bff",
          "priceEach": "$\u00a04\u00a0USD",
          "priceEachAsNumber": 4,
          "totalPrice": "$\u00a04\u00a0USD",
          "totalPriceAsNumber": 4,
          "priceEachBeforeDiscount": "$\u00a04\u00a0USD",
          "priceEachBeforeDiscountAsNumber": 4,
          "anyDiscount": false,
          "taxPercent": 25,
          "priceEachWithoutTax": "$\u00a03\u00a0USD",
          "priceEachWithoutTaxAsNumber": 3.2
        }
      ],
      "discounts": {
        "anyDiscount": false,
        "discount": "$\u00a00\u00a0USD",
        "discountAsNumber": 0,
        "automaticDiscounts": [
        ],
        "vouchers": [
        ]
      },
      "totals": {
        "itemsTotalPrice": "$\u00a04\u00a0USD",
        "itemsTotalPriceAsNumber": 4,
        "totalDiscountPrice": false,
        "totalDiscountPriceAsNumber": false,
        "shippingPrice": "$\u00a099\u00a0USD",
        "shippingPriceAsNumber": 99,
        "handlingCostPrice": "$\u00a00\u00a0USD",
        "handlingCostPriceAsNumber": 0,
        "totalQuantity": 1,
        "taxDeducted": "$\u00a0-21\u00a0USD",
        "taxDeductedAsNumber": -20.6,
        "taxAdded": false,
        "taxAddedAsNumber": false,
        "taxPercent": 0,
        "grandTotalPrice": "$\u00a082\u00a0USD",
        "grandTotalPriceAsNumber": 82.4,
        "grandTotalPriceTax": "$\u00a00\u00a0USD",
        "grandTotalPriceTaxAsNumber": 0
      },
      "vatExempt": true,
      "address": {
        "email": "fr@example.com",
        "firstName": "First",
        "lastName": "Last",
        "company": "",
        "address1": "Rue",
        "address2": "",
        "zipCode": "75000",
        "city": "Paris",
        "state": "Alsace",
        "country": "FR",
        "countryName": "France",
        "phoneNumber": "1234556"
      },
      "shippingAddress": {
        "email": "fr@example.com",
        "firstName": "First",
        "lastName": "Last",
        "company": "",
        "address1": "Rue",
        "address2": "",
        "zipCode": "75000",
        "city": "Paris",
        "state": "Alsace",
        "country": "FR",
        "countryName": "France",
        "phoneNumber": "12345678"
      },
      "giftMessage": null,
      "shipments": [
      ],
      "currencyFormat": {
        "currency": "USD",
        "name": "USD",
        "prefix": "$ ",
        "suffix": " USD",
        "decimalPoint": ".",
        "decimalDigits": "0",
        "uri": "usd"
      }
    },
    {
      "order": "574",
      "status": "untouched",
      "statusDescription": "Pending",
      "message": "Thank you for your order!",
      "date": "2015-10-20 15:58:21",
      "currency": "USD",
      "paymentMethod": "paypal",
      "paymentMethodName": "P\u00e4jP\u00e4l",
      "shippingMethod": "",
      "shippingMethodName": "",
      "items": [
        {
          "item": "2-1",
          "product": "2",
          "brandName": "Brand",
          "productName": "\u221aEtt",
          "size": "",
          "sku": "p1v1",
          "ean": "",
          "quantity": 1,
          "storePickup": false,
          "line": "58b36250237a1d67e67fc95ce18c8f7d",
          "priceEach": "$\u00a04\u00a0USD",
          "priceEachAsNumber": 4,
          "totalPrice": "$\u00a04\u00a0USD",
          "totalPriceAsNumber": 4,
          "priceEachBeforeDiscount": "$\u00a04\u00a0USD",
          "priceEachBeforeDiscountAsNumber": 4,
          "anyDiscount": false,
          "taxPercent": 25,
          "priceEachWithoutTax": "$\u00a03\u00a0USD",
          "priceEachWithoutTaxAsNumber": 3.2
        }
      ],
      "discounts": {
        "anyDiscount": false,
        "discount": "$\u00a00\u00a0USD",
        "discountAsNumber": 0,
        "automaticDiscounts": [
        ],
        "vouchers": [
        ]
      },
      "totals": {
        "itemsTotalPrice": "$\u00a04\u00a0USD",
        "itemsTotalPriceAsNumber": 4,
        "totalDiscountPrice": false,
        "totalDiscountPriceAsNumber": false,
        "shippingPrice": "$\u00a099\u00a0USD",
        "shippingPriceAsNumber": 99,
        "handlingCostPrice": "$\u00a00\u00a0USD",
        "handlingCostPriceAsNumber": 0,
        "totalQuantity": 1,
        "taxDeducted": false,
        "taxDeductedAsNumber": false,
        "taxAdded": false,
        "taxAddedAsNumber": false,
        "taxPercent": 25,
        "grandTotalPrice": "$\u00a0103\u00a0USD",
        "grandTotalPriceAsNumber": 103,
        "grandTotalPriceTax": "$\u00a021\u00a0USD",
        "grandTotalPriceTaxAsNumber": 20.6
      },
      "vatExempt": false,
      "address": {
        "email": "fr@example.com",
        "firstName": "First",
        "lastName": "Last",
        "company": "",
        "address1": "Rue",
        "address2": "",
        "zipCode": "75000",
        "city": "Paris",
        "state": "Alsace",
        "country": "FR",
        "countryName": "France",
        "phoneNumber": "1234556"
      },
      "shippingAddress": {
        "email": "fr@example.com",
        "firstName": "First",
        "lastName": "Last",
        "company": "",
        "address1": "Rue",
        "address2": "",
        "zipCode": "75000",
        "city": "Paris",
        "state": "Alsace",
        "country": "FR",
        "countryName": "France",
        "phoneNumber": "12345678"
      },
      "giftMessage": null,
      "shipments": [
      ],
      "currencyFormat": {
        "currency": "USD",
        "name": "USD",
        "prefix": "$ ",
        "suffix": " USD",
        "decimalPoint": ".",
        "decimalDigits": "0",
        "uri": "usd"
      }
    }
  ],
  "ordersPaging": {
    "from": 3,
    "size": 2,
    "totalSize": 38
  },
  "products": [
    {
      "product": "2",
      "name": "\u221aEtt1",
      "uri": "ett-v1",
      "sku": "p1v1",
      "productSku": "p1",
      "brandName": "Brand",
      "silkProduct": "1",
      "silkVariant": "1",
      "variantName": "V1",
      "primaryVariant": true,
      "excerpt": "Min korta display description",
      "description": "Min l\u00e5nga display description!",
      "metaTitle": "min display meta title!",
      "metaDescription": "Min display meta description!",
      "metaKeywords": "Min display meta keywords!",
      "stockUnit": "",
      "harmCode": "",
      "harmCodeDescription": "",
      "twilfitMultiSwatch": {
        "primary": {
          "color_text": "xzcx",
          "color_hex": "eqwe",
          "parent": "asdads",
          "parent_hex": "adsasd"
        },
        "additional": {
          "8": {
            "color_text": "Hejsan",
            "color_hex": "deadbeef",
            "color_img": {
              "type": "image",
              "url": "http:\/\/7c965611.ngrok.io\/client\/dynamic\/attributes\/concorde32_7663_png.jpg",
              "width": "24",
              "height": "24",
              "mimeType": "image\/jpeg"
            },
            "parent": "parenten",
            "parent_hex": "cafe"
          }
        }
      },
      "price": "$\u00a04\u00a0USD",
      "priceBeforeDiscount": "$\u00a04\u00a0USD",
      "priceReduction": "$\u00a00\u00a0USD",
      "priceAsNumber": 4,
      "priceBeforeDiscountAsNumber": 4,
      "priceReductionAsNumber": 0,
      "discountPercent": 0,
      "showAsOnSale": false,
      "newProduct": false,
      "inStock": true,
      "items": [
        {
          "item": "2-1",
          "name": "",
          "ean": "",
          "sku": "p1v1",
          "inStock": true
        }
      ],
      "canonicalUri": "vaxt\/buske\/nypon\/ett-v1",
      "media": {
        "s_big": [
          "https:\/\/7c965611.ngrok.io\/client\/dynamic\/images\/1_7c19db6361-hagebutten_am_strauch-s_big.jpg",
          "https:\/\/7c965611.ngrok.io\/client\/dynamic\/images\/1_c1d15594e8-nypon_994760a-s_big.jpg",
          "https:\/\/7c965611.ngrok.io\/client\/dynamic\/images\/1_c1a16a4381-casio_exilim_ex-z1050_nypon-s_big.jpg"
        ]
      },
      "relatedProducts": [
        {
          "product": "5",
          "relation": "standard"
        },
        {
          "product": "4",
          "relation": "variant"
        },
        {
          "product": "3",
          "relation": "silkProduct"
        },
        {
          "product": "37",
          "relation": "silkProduct"
        },
        {
          "product": "37",
          "relation": "display"
        }
      ]
    }
  ],
  "location": {
    "country": "US",
    "name": "United States",
    "eu": false,
    "language": "en",
    "state": null,
    "stateName": "",
    "shipTo": true
  },
  "language": {
    "language": "en",
    "name": "English"
  },
  "loggedIn": {
    "email": "same@example.com",
    "firstName": "H\u00e9ll\u00f6 \u30d7\u30ec\u30a4\u30b9\u30c6\u30fc\u30b7\u30e7\u30f3",
    "lastName": "W\u00f6\u00aeld \u0625\u0646 \u0634\u0627\u0621 \u0627\u0644\u0644\u0647\u200e",
    "address1": "Address One",
    "address2": "Address Two",
    "zipCode": "12345",
    "city": "add",
    "state": "",
    "country": "US",
    "phoneNumber": "123456789"
  }
}
```

The orders do have shipments on them, although not in the example abve. If an order is shipped, it has an array of shipments in "shipments" like this:

```json
"shipments": [
    {
        "shippedDate": "2017-08-04 16:22:20",
        "carrier": "UPS",
        "service": "Ground",
        "trackingId": "1Z123123123123",
        "trackingUrl": "http://example.com/tracking?1Z123123123123"
    }
],

```
