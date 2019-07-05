---
title: Order flow
taxonomy:
    category: docs
---

## Order flow in Centra

Here's the basic order flow as seen in Centra backend. Click image to enlarge.

<a rel="lightbox" data-width="600" href="../user/pages/01.guides/05.orderflow/Order-flow.png"><img title="Order flow" alt="Order flow" src="../user/pages/01.guides/05.orderflow/Order-flow-thumb.png" /></a>

### Create selection

> POST *base*/example/  

Request:
```json
{
    "lorem": "ipsum"
}
```

Response:
```json
{
    "result": "ok",
}
```

### Confirm order

> POST *base*/path/  

Request:
```json
{
    "lorem": "ipsum"
}
```

Response:
```json
{
    "result": "ok",
}
```

### Mark as paid

> POST /selections/ddff91abdd62069cc5fbf4cb23c6af68/payment  
> Request ID: 93ddb4320c3dea8741ad0b2ade4547c8

Request:
```json
{
    "selection": "ddff91abdd62069cc5fbf4cb23c6af68",
    "paymentMethod": "klarna-playground",
    "paymentMethodSpecificFields": [
    ],
    "paymentReturnPage": "http://localhost:3333/payment-status/",
    "paymentFailedPage": "http://localhost:3333/payment-fail/",
    "paymentMethodCallbackPage": "http://localhost:3333/payment-status/",
    "termsAndConditions": true,
    "consents": [
    ],
    "address": {
        "firstName": "Maximillian",
        "email": "hhh@maximilliangeorge.com",
        "lastName": "George",
        "address1": "Dybecksvu00e4gen 51",
        "address2": "",
        "city": "Stockholm",
        "zipCode": "16855",
        "country": "SE",
        "phoneNumber": "734444782",
        "password": "???", // Verified to be the correct hash
        "loggedIn": true,
        "register": false
    },
    "shippingAddress": null,
    "additionalFields": [
    ],
    "customerClubFields": [
    ],
    "internalOrder": false
}
```

Response:
```json
{
    "action": "form",
    "formHtml": "..." // Klarna form
}
```

### Get payment results

> POST /selections/payment-result  
Request ID: 47524dc7f3623581a4dcd7c6d3e9f51c

Request:
```json
{
    "selection": "ddff91abdd62069cc5fbf4cb23c6af68",
    "paymentMethodFields": {
        "centraPaymentMethod": "klarna-playground",
        "klarna_order": "bdf90ec3-0469-591f-85d4-57c5dca5fa00"
    }
}
```

Response:
```json
{
    "order": "588",
    "status": "untouched",
    "statusDescription": "Pending",
    "message": "Thank you for your order!",
    "date": "2019-06-17 11:18:58",
    "affiliateHtml": "...",
    "market": "1",
    "pricelist": "19",
    "language": null,
    "currency": "SEK",
    "paymentMethod": "klarna-playground",
    "paymentMethodName": "Klarna Playground",
    "shippingMethod": "sek",
    "shippingMethodName": "SEK",
    "warehouse": false,
    "items": [
        {
            "item": "23-281",
            "product": "23",
            "brandName": "CQP",
            "productName": "Chocolate",
            "size": "40",
            "sku": "CQP-ATLON-CHOCOLATE",
            "ean": "",
            "silkProduct": "27",
            "silkVariant": "1471",
            "quantity": 1,
            "comment": "",
            "storePickup": false,
            "line": "1f7602d3bbd19d05ccaf91411e96ca82",
            "priceEach": "3u00a0600.00u00a0SEK",
            "priceEachAsNumber": 3600,
            "totalPrice": "3u00a0600.00u00a0SEK",
            "totalPriceAsNumber": 3600,
            "priceEachBeforeDiscount": "3u00a0600.00u00a0SEK",
            "priceEachBeforeDiscountAsNumber": 3600,
            "anyDiscount": false,
            "taxPercent": 25,
            "priceEachWithoutTax": "2u00a0880.00u00a0SEK",
            "priceEachWithoutTaxAsNumber": 2880,
            "priceEachReduction": "0.00u00a0SEK",
            "priceEachReductionAsNumber": 0
        }
    ],
    "discounts": {
        "anyDiscount": false,
        "discount": "0.00u00a0SEK",
        "discountAsNumber": 0,
        "vouchers": [
        ],
        "automaticDiscounts": [
        ]
    },
    "totals": {
        "itemsTotalPrice": "3u00a0600.00u00a0SEK",
        "itemsTotalPriceAsNumber": 3600,
        "totalDiscountPrice": false,
        "totalDiscountPriceAsNumber": false,
        "shippingPrice": "0.00u00a0SEK",
        "shippingPriceAsNumber": 0,
        "handlingCostPrice": "0.00u00a0SEK",
        "handlingCostPriceAsNumber": 0,
        "totalQuantity": 1,
        "taxDeducted": false,
        "taxDeductedAsNumber": false,
        "taxAdded": false,
        "taxAddedAsNumber": false,
        "taxPercent": 25,
        "grandTotalPrice": "3u00a0600.00u00a0SEK",
        "grandTotalPriceAsNumber": 3600,
        "grandTotalPriceTax": "720.00u00a0SEK",
        "grandTotalPriceTaxAsNumber": 720
    },
    "vatExempt": false,
    "address": {
        "email": "hhh@maximilliangeorge.com",
        "firstName": "Maximillian",
        "lastName": "George",
        "company": "",
        "address1": "Dybecksvu00e4gen 51",
        "address2": "",
        "zipCode": "16855",
        "city": "Bromma",
        "state": "",
        "country": "SE",
        "countryName": "Sweden",
        "phoneNumber": "+46734444782",
        "vatNumber": ""
    },
    "shippingAddress": {
        "email": "hhh@maximilliangeorge.com",
        "firstName": "Maximillian",
        "lastName": "George",
        "company": "",
        "address1": "Dybecksvu00e4gen 51",
        "address2": "",
        "zipCode": "16855",
        "city": "Bromma",
        "state": "",
        "country": "SE",
        "countryName": "Sweden",
        "phoneNumber": "+46734444782"
    },
    "giftMessage": "",
    "additionalNotes": "",
    "shipments": [
    ],
    "paymentMethodData": {
        "snippet": "..."
    },
    "currencyFormat": {
        "currency": "SEK",
        "name": "SEK",
        "prefix": "",
        "suffix": " SEK",
        "decimalPoint": ".",
        "decimalDigits": "2",
        "uri": "sek"
    }
}
```

### The best is yet to come!
