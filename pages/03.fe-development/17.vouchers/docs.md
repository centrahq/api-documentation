---
title: Working with vouchers
altTitle: Working with vouchers
taxonomy:
    category: docs
excerpt: Explains and gives examples for how to work with Centras voucher data
---

## The responses from my centra instance does not have this data!

This feature has not yet bee ndeployed everywhere, please contact partner support and we will look into having it enabled on your instance. 

## What data is available ?

For discount type vouchers you can find on the item how they have been affected.
```json
"items": [
  {
    "item": "1-1",
    // ...
    "discounts": {
      "vouchers": [
        {
          "voucher": "priceoffexclcamp",
          "priceOff": "-160.00 SEK",
          "priceOffAsNumber": -160,
          "hasAffectedItemPrice": false
        }
      ],
      "automaticDiscounts": [
        {
          "voucher": 506,
          "priceOff": "-10.00 SEK",
          "priceOffAsNumber": -10,
          "hasAffectedItemPrice": false
        }
      ]
    },
  }
]
```

| Field | Type | Explanation |
|---|---|---|
| voucher | string/int | for objects under "vouchers" this is the code of the voucher, for objects udner "automaticDiscounts" this is the ID of teh voucher. use this for lookups in order level "discounts" object for detaield data |
| priceoff | string | how much in total has this voucher discounted this line |
| priceoffAsNumber | float | float version of "priceoff" |
| hasAffectedItemPrice | boolean | has the priceOff shown here already been reduced on this items prices ?, always false for selections, true for voucehrs set as "order items" for orders (receipt and payment-result) |

You will also be able to see on teh order level how the order was affected
```json
"discounts": {
  "anyDiscount": true,
  "discount": "-10.00 SEK",
  "discountAsNumber": -10,
  "vouchers": {
    "priceoffexclcamp": {
      "voucher": "priceoffexclcamp",
      "type": "code",
      "priceOff": "-629.25 SEK",
      "priceOffAsNumber": -629.25,
      "description": "75% off excluding campaign",
      "lines": [
        "a445a490763931115e547fee706cf159",
        "37b9877c23b3f6d93a7d3462bfef8f3c",
        "9fb8ffafaace556a359f048022e5a5de"
      ],
      "shippingDiscount": "0.00 SEK",
      "shippingDiscountAsNumber": -0,
      "expiryDate": "2099-10-21 16:25:00"
    }
  },
  "automaticDiscounts": {
      "506": {
        "automaticDiscount": "506",
        "name": "My Test Auto",
        "priceOff": "-10.00 SEK",
        "priceOffAsNumber": -10,
        "lines": [
          "a445a490763931115e547fee706cf159"
        ],
        "shippingDiscount": "0.00 SEK",
        "shippingDiscountAsNumber": 0,
        "expiryDate": "2024-08-08 16:30:21"
      }
    }
},
```

all typeds of vouchers will have some data in common:
| Field | Type | Explanation |
|---|---|---|
| anyDiscount | boolean | Does the order have any order level discount |
| discount | string | a sum of all the discount given by automaticDiscounts |
| discountAsNumber | float | float version of "discount" |
| voucher | string/int | voucher code for objects under "vouchers", ID for objects udner "automaticDiscounts" |
| type | string | only for object under "vouchers", is eitehr "code" or "url" |
| description / name | string | the name of the voucher |
| priceoff | string | how much in total has this voucher discounted the order |
| priceoffAsNumber | float | float version of "priceoff" |
| expiryDate | string | When does the voucher stop working |

Some additional fields might be present depending on what the voucher discounts, a voucher can give many different benefits so some voucher might contain more than one set of special fields. 

for vouchers discounting items we will see the following fields:

| Field | Type | Explanation |
|---|---|---|
| lines | array | a list of the lines this voucher has affected, uses "line" field of "items" |
| shippingDiscount | string | how much has this voucher discounted shipping |
| shippingDiscountAsNumber | float | float version of "shippingDiscount" |

For vouchers giving a free product we will see:

```json
"discounts": {
  "anyDiscount": false,
  "discount": "0.00 SEK",
  "discountAsNumber": 0,
  "vouchers": {
    "freeproductrevertnoremove": {
      "voucher": "freeproductrevertnoremove",
      "type": "code",
      "priceOff": "0.00 SEK",
      "priceOffAsNumber": -0,
      "description": "freeproductrevert-no-remove",
      "freeProductAdded": {
        "line": "39f381e72d15a7126a34a9cdd9126352",
        "allowRemove": true,
        "allowAddMore": true
      },
      "expiryDate": "2099-10-22 09:47:00"
    }
  },
  "automaticDiscounts": []
}
```

| Field | Type | Explanation |
|---|---|---|
| freeProductAdded.line | string | the "line" if of the added line |
| freeProductAdded.allowRemove | boolean | Is the custoemr allowed to remove the added product |
| freeProductAdded.allowAddMore | boolean | Is the custoemr allowed to add more (none free) quantity of the product |

For a voucher giving free shippign we will see:

```json
"discounts": {
  "anyDiscount": false,
  "discount": "0.00 SEK",
  "discountAsNumber": 0,
  "vouchers": {
    "freeship": {
      "voucher": "freeship",
      "type": "code",
      "priceOff": "0.00 SEK",
      "priceOffAsNumber": -0,
      "description": "Free Shipping",
      "freeShippingFor": [
        "sek",
        "usd",
        "jpy-std",
        "sekalt",
        "sek2"
      ],
      "expiryDate": "2099-10-21 16:25:00"
    }
  },
  "automaticDiscounts": []
}
```

| Field | Type | Explanation |
|---|---|---|
| freeShippingFor | array | a list of which shipping methjods are allowed to get free shipping |

For a credit voucher we will see:
Credit vouchers only have the normal fields. 

## How to's

### I wish to show how much discount an item in the custoemrs selection has received
Summarise all `priceOffAsNumber` found for the wanted discounts on item. depending on how you wish to show the vouchers on order level you might wish to deduct item voucher values from this. 

### How can i get voucher on receipt to always show the same way as on checkout.
This is a little tricky due to how vouchers have worked historicaly. but there is a way, and the trick lies in the `hasAffectedItemPrice` field in the item level voucher data. 
