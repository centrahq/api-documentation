---
title: Lowest price feature
altTitle: Lowest price
taxonomy:
    category: docs
---

## How does the lowest price feature work?

### Price calculation

The lowest price is calculated as the minimal price of the product attainable by using any active campaigns.

Those prices are calculated for each valid combination of:
- market
- price list
- product variant

### Where can the lowest price be accessed?

In Checkout and Shop APIs.

In all the places where standard product response is returned:
* Product listing (`POST /products`)
* Product details (`GET /products/{productId}`)
* Bundles (`GET/POST /bundles/{productId}`)
* Receipt (`GET /receipt`)
* Selection (`GET/PUT /selection`, `POST /items/{item}`, `POST/DELETE /lines/{line}`)
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