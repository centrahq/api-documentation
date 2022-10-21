---
title: Lowest price feature
altTitle: Lowest price
taxonomy:
    category: docs
---

## How does the lowest price feature work?

### Price calculation

Lowest price is calculated as minimal price of product attainable by using any active campaigns.

Those prices are calculated for each valid combination of:
- store
- market
- price list
- product
- product variant

### Where can the lowest price be accessed?

In Checkout and Shop APIs.

In all the places where standard product response is returned:
* product listing (`POST /products`)
* product details (`GET /products/{productId}`)
* bundles (`GET/PUT /bundles/{productId}`)
* receipt items (`GET /recipt`)
* selection items (`GET/PUT /selection`, `POST /items/{item}`, `POST/DELETE /lines/{line}`)
* etc.

There will be a new field `lowestPrice` in the response:
```json
{
  ...,
  "price": "200.00 SEK",
  "priceAsNumber": 200,
  "priceBeforeDiscount": "200.00 SEK",
  "priceBeforeDiscountAsNumber": 200,
  "discountPercent": 0,
  "lowestPrice": [
    {
      "periodDays": 30,
      "price": "100.00 SEK",
      "priceAsNumber": 100,
      "priceBeforeDiscount": "200.00 SEK",
      "priceBeforeDiscountAsNumber": 200
    }
  ],
  "showAsOnSale": false,
  "showAsNew": false,
  ...,
}
```