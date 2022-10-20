---
title: Lowest price feature
altTitle: Lowest price
taxonomy:
    category: docs
---

## How does the lowest price feature work?

### Price calculation

Lowest price is calculated as minimal price of product attainable by using any active campaigns.

### Where can the lowest price be accessed?

In all the places where standard product response is returned:
* product listing
* product details
* selection product details

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