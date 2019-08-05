---
title: Order flow in Centra
altTitle: Order flow
taxonomy:
    category: docs
---

Here's the basic order flow as seen in Centra backend. Click image to enlarge.

<!--<a rel="lightbox" data-width="600" href="../user/pages/01.guides/05.orderflow/Order-flow.png"><img title="Order flow" alt="Order flow" src="../user/pages/01.guides/05.orderflow/Order-flow-thumb.png" /></a>-->
![OrderFlow](order-flow.png?lightbox=3333x4000&resize=1200)

### Order statuses

* Incomplete (0)  
  This is a selection before it’s checked out. It contains the list of selected items, information about language and currency or discounts, plus a list of optional shipping methods.
* Pending (1)  
  This order has been checked out, with payment steps being completed. In addition to the incomplete order, it contains information on customer, selected shipping and payment.
* Confirmed (2)  
  This order has been manually confirmed in the Centra admin panel. Only confirmed orders can have a shipment created for them. This step can be skipped by enabling store option “Direct to Shipment”, in which case the checked out order will transfer to status Processing (3) with a shipment created and marked Good-To-Go.
* Processing (3)  
  This order has at least one shipment related to it, and at least one of those shipments is not completed. Ordered items can be split into multiple shipments depending on availability and other factors.
* Completed (4)  
  This order has completed payment capture and expedited all related shipments. Additional information on shipping details and tracking number can be added when completing each shipment.
* Archived (5)  
  This order has been archived and will not show up in search results in Centra. Depending on plugin configuration, it may also be hidden in API responses.
* Cancelled (6)  
  This ordered has been cancelled at any stage before the payment was captured (once the payment has been successful, a refund should be made instead of cancelling the order). Cancelled orders have the option to be fully and irreversibly deleted from the database.
* Hold (flag)  
  This order is on hold by manual intervention in Centra backend. Its details can still be edited, but it cannot proceed with shipment or payment until resumed.


<!--
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
-->
