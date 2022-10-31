---
title: Lowest price feature
altTitle: Lowest price
taxonomy:
    category: docs
---

## How does the lowest price feature work?

### Price calculation

The lowest price is calculated as the minimal price of a product attainable by using any active campaigns.

These prices are calculated for each valid combination of:
- market
- pricelist
- product variant

Only buyable product prices will be recorded. That means that all the following conditions must be met for a price to be considered during calculations:
- active product display
- store is direct to consumer
- product display is enabled for given market
- product variant is active
- pricelist is active

Recorded prices will be adjusted by any relevant campaigns that met the following conditions:
- the campaign is enabled for the market
- product variant is enabled for the campaign
- campaign status is active
- campaign date restrictions are satisfied (start and end dates)

**Vouchers are not considered**.

### What about correcting price errors?

There is no mechanism in place to correct a historical price. If a price was available, even for a split second, then it will show no matter what.
That also applies to setting the price to `0` - it will show as `0` (free product) in the API.

### When are the prices calculated?

They are calculated asynchronously on any modification to a:
- campaign
- market
- pricelist
- product variant

They are also verified daily after midnight.

### Where can the lowest price be accessed?

Lowest price feature is supported in both Checkout and Shop APIs. Prices are recorded **only for direct to consumer stores**.

In all the places where a product or selection response is returned:
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
