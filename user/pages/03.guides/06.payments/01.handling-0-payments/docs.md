---
title: Handling payments with 0 amount
altTitle: 0 amount payments
excerpt: Ever gave your customer a 100% discount? Click here to learn how to properly handle it in your payment flow.
taxonomy:
  category: docs
---

In case your customer uses a voucher that applies 100% discount on the whole order (including shipping cost), you may be faced with a dilemma: how to handle a payment with 0 amount?

To understand it, first we need to explain the two different approaches to handling customer's shipping address during checkout. There are two possible scenarios: either Centra is sending the address **to** the PSP (Payment Service Provider), or the provider is displaying their checkout iframe, in which the customer fills in their details, and then the address is sent **from** the PSP to Centra. We call this second scenario `AddressAfterPayment`.

There are three payment methods that use `AddressAfterPayment`:
- Klarna Checkout v2/v3,
- Pilibaba,
- PayPal (only when plugin setting `Override Shipping Address` is set to `No`).

If the payment method you used is a `AddressAfterPayment` method, Centra will continue to send the order to the PSP even though the amount is 0. This, however, requires the payment provider to allow a 0 amount order to pass through their flow.

If the payment method is not using `AddressAfterPayment`, Centra will ignore the payment flow and complete the order directly. This will only happen if:
1. There are products in the order - you cannot finalize an order without products,
2. The orderTotal is 0, including shipping cost. If shipping is not free, the order will not count as a free order.
