---
title: How to build a proper Centra Front End
altTitle: Building a Front End
excerpt: Everything you need for a pleasant shopping and checkout experience, with examples using Centra's Checkout API.
taxonomy:
  category: docs
---

## Checkout API introduction

Checkout API is a hybrid webshop API, built to operate both in client and server mode. In client mode it exposes all endpoints necessary to fetch products, filter categories, build a [selection](/glossary/glossary-basic#selection) (a.k.a. cart) and complete checkout process with a number of supported payment and shipping methods. In server (authenticated) mode it allows you to fetch details about all Markets, Pricelists and Warehouses, or explicitly set Market, Pricelist, Country or Language for current selection.

[notice-box=alert]
Server mode API calls made from a web browser will be blocked. Be careful to never expose your shared secret.
[/notice-box]
[notice-box=info]
You can further increase your store security by filtering allowed origins in the Checkout API plugin settings.
[/notice-box]

To read about and test the most commonly used endpoints, visit our [Swagger for Checkout API](https://docs.centra.com/swagger-ui/?api=CheckoutAPI). It also contains details of all data models used in Centra.

[notice-box=readMore]
Most of the concepts below are described in [Centra overview](/overview) chapters. It's worth reading before you dive into specifics of Checkout API implementation.
[/notice-box]

### How does it work?

When using Checkout API, the end-user's session context is controlled by three main aspects:
* **Market**, which allows you to segment your store and control which products will be shown or hidden. Each Market connects to a specific Warehouse group and serves stock from Warehouses in that group.
* **Pricelist**, which controls the which product prices in which currency will be displayed to the end user. The products with no price will be returned, but are not purchasable, meaning it's impossible to add them to the selection.
* **Language**, which affects whether or not product details and categories would be translated, with a fallback to default if no translation exists for a given language.

In standard operation those three variables are set based on the end-customer's country, which can either be set based on GeoIP location, or explicitly chosen with a country selector in your webshop. Once the country is changed, following things will change as well:
* If there is a Pricelist specific for this country, change to it and update the prices in current selection.
* If there is a Market specific for this country, change to it and update the products in current selection, removing the unavailable ones.
* If there is a Language specific for this country, and content (descriptions, category names, etc.) translations for this language are available, return translated content. Otherwise, fallback to the default language.

You can display the full list of countries to which your store can ship to by calling `GET /countries`. Alternatively, in authenticated server mode you can display a list of all countries using `GET /countries/all`, where shippable countries will be returned with `"shipTo": true` parameter. Shippable countries:
* Have at least one active Pricelist,
* Have at least one active Shipping list.

## Elements of the webshop

Here is how you can achieve a pleasant shopping and checkout experience for your customers.

### Product catalog

```text
Welcome to the store! Feel free to browse around.
```

[notice-box=info]
Whenever you use Centra API to fetch products, the product IDs used are actually the display IDs of the products. Like described in the [Product model chapter](/overview/products), the displays act as a presentation layer for your products.
[/notice-box]

There are a few ways to fetch products using Checkout API. To fetch a specific product, you can use the [GET /products/{product}](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/5.%20product%20catalog/get_products__product_) endpoint. The response object will contain the following data:

```json
{
  "token": "esf1p3tgchfg5ggtpqdpgqjtt6",
  "products": [...],
  "productCount": 344,
  "filter": [...]
}
```

* Token: Your session token
* Products: An array of products
* ProductCount: Total number of products without paging. This way you can show “page 1 of 7” even if you only fetch 50 at a time
* Filter: The filter values of the products you are viewing now, also without paging. This way you know there are for example 35 red and 12 blue ones

Another method is the [POST /products](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/5.%20product%20catalog/post_products) endpoint. An request with an empty body will return all active products. Results can be filtered using the following parameters:

```json
{
    "skipFirst": 5,
    "limit": 10,
    "categories": [1,2,3],
    "collections": [1,2,3],
    "silkProduct": 123,
    "search": "hello world",
    "products": [1,2,3],
    "relatedProducts": true,
    "brands": [1,2,3],
    "swatch.desc": ["Red", "Blue", "Green"],
    "items.name":["W24\/L30"],
    "onlyAvailable":true,
    "uri":{
        "uri":"jeans\/black",
        "for":["product", "category"]
    }
},
```

* `skipFirst` and `limit`: can be used for paging
* categories: you want products in these categories
* search: free text search
* relatedProducts: when a product has relatedProducts and this is true, you get the complete data for those releated products. Otherwise you will get a small subset of the data back: only the media and product id.
* swatch.desc: filtering based on the color swatch (This is a client specific field, and not all Centra instances will have this field)
* items.name: filtering on specific item names
* onlyAvailable: true means you only get back products that are in stock or available for preorder. If you also specify items.name, those items must be available.
* uri: filter on a product or category with a specific URI

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

To switch the current selection to specific country, call [PUT /countries/{country}](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/3.%20selection%20handling%2C%20modify%20selection/put_countries__country_). If the country requires specifying a state as well, you should use [PUT /countries/{country}/states/{state}](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/3.%20selection%20handling%2C%20modify%20selection/put_countries__country__states__state_).

[notice-box=alert]
If you switch to a country which is not shippable (`"shipTo": false`), you will still be able to browse products and add them to selection, but you won't be able to complete the checkout process.
[/notice-box]

### Consents

```text
Here are the terms and conditions.
```

Don't forget that for a proper payment you need to add a Front End consent check-box (or or check-boxes). This needs to be verified by sending a boolean `"termsAndConditions": true` in your [POST /payment](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/4.%20selection%20handling%2C%20checkout%20flow/post_payment) call. Otherwise, you will receive the below error, which you should handle by displaying a message abount consents being required for checkout process to complete.

```json
{
    "token": "ca4c5e132179eaaa06a61e8c53a12500",
    "errors": {
        "termsAndConditions": "must be true"
    }
}
```

### My pages

```text
Would you like your usual?
```

### Newsletter sign-up form

```text
We have some cool stuff we'd love to show you now and in the future!
```

You can subscribe your customers for e-mail newsletter using [POST /newsletter-subscription/{email}](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/6.%20customer%20handling/post_newsletter_subscription__email_) endpoint. In it, you can choose to send `country` and `language` parameters, which can be used to control the newsletter language and to filter newsletter updates on products available in customer's Market. Registered newsletter e-mails can be found in Centra backend under Retail -> Customers -> Newsletter.

[notice-box=alert]
Be mindful to properly parse and encode the e-mail subscription field in your Front End. It's especially important characters like `@` and `+` are properly handled. Otherwise, for example, the plus `+` character can be wrongly replaced with a space, which can throw `Expected type e-mail` error.
[/notice-box]

### Newsletter sign-up for "Let me know when the product is back in stock"

If product which is out of stock shows "Notify me when back in stock", the customer can be registered under Customers > Newsletter with their e-mail address and the product that they wish to be notified about. This list  should automatically go to your audience ID or mailing list inside your ESP (E-mail Service Provider). However, there is no automation from Centra in terms of when stock is added, this is something that you would have to manually handle. So when the stock is back, you would go to the ESP and send e-mails to customers with that product and/or size.

To register products or specific product sizes for customer newsletter, you should call [POST /newsletter-subscription/{email}](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/6.%20customer%20handling/post_newsletter_subscription__email_) endpoint with optional parameters:  
* `country` - allows you to specify the country for the newsletter, which can affect the products availability you display based on the Market,
* `language` - allows you to specify the language of the newsletter, which helps you send a correct translation to specific customers,
* `product` - sent as `[display ID]` registers customer e-mail in the Newsletter list with a specific product,
* `item` - sent as `[display ID]-[size ID]`, same as in [POST /items/{item}](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/2.%20selection%20handling%2C%20cart/post_items__item_) or [POST /items/{item}/quantity/{quantity}](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/2.%20selection%20handling%2C%20cart/post_items__item__quantity__quantity_), registers customer e-mail in the Newsletter list with a specific product size.

#### Sign-up voucher code

```text
Would you sign up if we offered you a discount?
```

[Automatic voucher on newsletter signup?]

### Basket / selection

```text
Sure you got everything you wanted?
```

```text
GET /selection  
1. Available payment methods is based on Plugins (which can be restricted by pricelist/market/country)
2. Available shipping methods
3. Selection model
4. Form fields
5. Country list
```

### Shipping options

```text
How quickly you can get your stuff, and how much it would cost.
```

### Checkout

```text
Let us know everything we need to know to deliver your stuff to you!
```

#### Newsletter sign-up 2

```text
Now that you've entered your e-mail, sure you wouldn't like to sign up for some promos?
```

### Payment

```text
Make it rain! / Pay up!
```

#### Payment plugins

#### Payment country

#### Payment steps

```text
POST /payment REQUEST
- paymentMethod: kco
- address: {...}
- shippingAddress: {...}
- paymentReturnPage: URL
- paymentFailedPage: URL

POST /payment RESPONSE
- action: redirect/success/failed
- formHTML
- formFields
- URL (for redirect)

POST /payment-results
- 201 success
  OrderCreatedModel

POST /payment:
- Checks payment methods
- Checks stock
- Checks shipping
- Checkout details (addres, e-mail, phone)
```

### Receipt page

```text
Thanks for your order!
```
