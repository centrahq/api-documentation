---
title: Checkout with PayPal
altTitle: PayPal
excerpt: Learn how to use PayPal - one of the most popular credit card and bank transfer PSPs
taxonomy:
    category: docs
---

[Intro]

### Flow

[FixMe]  
The flow works like this:

1. Customer fills in address information on the website.
2. When the customer is done, they can select a payment option.
3. ...
11. Centra will respond with either a success or a payment failed.

### Implementation

[FixMe]

### Set up

The PayPal plugin in Centra looks like this:

(...)

Save the Centra plugin.

### Webhooks

[Copied from Stripe - needed or not?]

### Going live

When going live, these are the things that needs to be done for it to work:  
[FixMe]

#### Market/Pricelist/Country/Language restrictions

You can also restrict the Stripe Checkout to only work for specified markets, pricelists, countries or languages.

### API

The PayPal plugin will show up in the API as a payment method:

```json
"paypal": {
    "paymentMethod": "paypal",
    "name": "PayPal",
    "useForDigitalContent": true,
    "providesCustomerAddressAfterPayment": ?,
    "addressRequiredFields": [
        "email",
        "firstName",
        "lastName",
        "address1",
        "city",
        "zipCode",
        "country"
    ],
    "hasTermsAndConditionsAgreement": ?
},
```

(...)

### Additional configuration

[Anything?]

### Testing

[FixMe]
