---
title: Elements of a proper Centra Front End
altTitle: Front End elements
excerpt: Everything you need for a pleasant shopping and checkout experience, with examples using Centra's Checkout API.
taxonomy:
  category: docs
---

## Checkout API introduction

Checkout API is a hybrid webshop API, built to operate both in client and server mode. In client mode it exposes all endpoints necessary to fetch products, filter categories, build a selection (a.k.a. cart) and complete checkout process with a number of supported payment methods. In server (authenticated) mode it allows you to fetch details about all Markets, Pricelists and Warehouses, or explicitly set Market, Pricelist, Country or Language for current selection. In client mode the Country would be set either by GeoIP or using a country selector, and then Market, Pricelist and Language would be set automatically.

[notice-box=alert]
Server mode API calls made from a web browser will be blocked. Be careful to never expose your shared secret.  
You can further increase your store security by filtering allowed origins in the Checkout API plugin settings.
[/notice-box]

To read about and test the most commonly used endpoints, visit our [Swagger for Checkout API](https://docs.centra.com/swagger-ui/?api=CheckoutAPI).

[notice-box=readMore]
Most of the concepts below are described in [Centra overview](/overview) chapters. It's worth reading before you dive into specifics of Checkout API implementation.
[/notice-box]

### How does it work?

When using Checkout API, the end-user's session context is controlled by three main aspects:
* **Market**, which allows you to segment your store and control which products will be shown or hidden. Each Market connects to a specific Warehouse group and serves stock from Warehouses in that group.
* **Pricelist**, which controls the which product prices in which currency will be displayed to the end user. The products with no price will be returned, but are not purchasable, meaning it's impossible to add them to the selection.
* **Language**, which affects whether or not product details and categories would be translated, with a fallback to default if no translation exists for a given language.



## Elements of the webshop

Here is how you can achieve a pleasant shopping and checkout experience for your customers.

### Product catalog

Welcome to the store! Feel free to browse around.

#### Category picker

#### Search and filtering

#### Image galleries / carousels

#### Size charts

#### Measurement charts

### Country / language / market switcher

Welcome! Välkommen! Witamy! ¡Bienvenida! Wilkommen! Üdvözöljük! Velkommen!

### Consents

Here are the terms and conditions.

### My pages

Would you like your usual?

### Newsletter sign-up form

Here's some cool stuff we'd love to show you.

#### Sign-up voucher code

Would you sign up if we offered you a discount?

### Basket / selection

Sure you got everything you wanted?

### Shipping options

How quickly you can get your stuff, and how much it would cost.

### Checkout

Let us know everything we need to know to deliver your stuff to you!

#### Newsletter sign-up 2

Now that you've entered your e-mail, sure you wouldn't like to sign up for some promos?

### Payment

Make it rain!

#### Payment plugins

#### Payment country

#### Payment steps

### Receipt page

Thanks for your order!
