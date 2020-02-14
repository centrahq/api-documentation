---
title: Elements of a proper Centra Front End
altTitle: Front End building
excerpt: Everything you need for a pleasant shopping and checkout experience, with examples using Centra's Checkout API.
taxonomy:
  category: docs
---

## Checkout API introduction

Checkout API is a hybrid webshop API, built to operate both in client and server mode. In client mode it exposes all endpoints necessary to fetch products, filter categories, build a selection (a.k.a. cart) and complete checkout process with a number of supported payment methods. In server (authenticated) mode it allows you to fetch details about all Markets, Pricelists and Warehouses, or explicitly set Market, Pricelist, Country or Language for current selection.

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

In standard operation those three variables are set based on the end-customer's country, which can either be set based on GeoIP location, or explicitly chosen with a country selector in your webshop. Once the country is changed, following things will change as well:
* Is there a Pricelist specific for this country? If so, change to it and update the prices in current selection.
* Is there a Market specific for this country? If so, change to it and update the products in current selection, removing the unavailable ones.
* Is there a Language specific for this country? If so, translate all available content to the proper language.

You can display the full list of countries to which your store can ship to by calling `GET /countries`. Alternatively, in authenticated server mode you can display a list of all countries using `GET /countries/all`, where shippable countries will be returned with `"shipTo": true` parameter. Shippable countries:
* Have at least one active Pricelist,
* Have at least one active Shipping list.

## Elements of the webshop

Here is how you can achieve a pleasant shopping and checkout experience for your customers.

### Product catalog

```text
Welcome to the store! Feel free to browse around.
```



#### Category picker

#### Search and filtering

#### Image galleries / carousels

#### Size charts

#### Measurement charts

### Country / language / market switcher

```text
Welcome! Välkommen! Witamy! ¡Bienvenida! Wilkommen! Üdvözöljük! Velkommen!
```

Both Markets and Pricelists can be configured to automatically apply to selections in specific countries. Because this needs to be deterministic, we have the following limitation to using countries as Geo-locations:
* One country can only be a geo-location for one Market per Store,
* One country can only be a geo-location for one Pricelist per currency per Store.

To fetch a list of shippable countries, you can call [GET /countries](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/1.%20general%20settings/get_countries). Alternatively, you can call [GET /countries/all](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/1.%20general%20settings/get_countries_all) in authenticated mode.

To switch the current selection to specific country, call [PUT /countries/{country}](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/3.%20selection%20handling%2C%20modify%20selection/put_countries__country_). If the country requires specifying a state as well, you can call [PUT /countries/{country}/states/{state}](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/3.%20selection%20handling%2C%20modify%20selection/put_countries__country__states__state_).

[alert-box=alert]
If you switch to a country which is not shippable (`"shipTo": false`), you will still be able to browse products and add them to selection, but you won't be able to complete the checkout process.
[/alert-box]

### Consents

Here are the terms and conditions.

### My pages

Would you like your usual?

### Newsletter sign-up form

```text
We have some cool stuff we'd love to show you now and in the future!
```

You can subscribe your customers for e-mail newsletter using [POST /newsletter-subscription/{email}](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/6.%20customer%20handling/post_newsletter_subscription__email_) endpoint. In it, you can choose to send `country` and `language` parameters, which can be used to control the newsletter language and to filter newsletter updates on products available in customer's Market. Registered newsletter e-mails can be found in Centra backend under Retail -> Customers -> Newsletter.

[alert-box=alert]
Be mindful to properly parse and encode the e-mail subscription field in your Front End. It's especially important characters like `@` and `+` are properly handled. Otherwise, for example, the plus `+` character can be wrongly replaced with a space, which can throw `Expected type e-mail` error.
[/alert-box]

#### Sign-up voucher code

Would you sign up if we offered you a discount?

### Basket / selection

```text
Sure you got everything you wanted?
```

GET /selection  
1. Available payment methods is based on Plugins (which can be restricted by pricelist/market/country)
2. Available shipping methods
3. Selection model
4. Form fields
5. Country list

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
