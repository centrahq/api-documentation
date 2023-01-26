---
title: Checkout API - Introduction
altTitle: Introduction
excerpt: Introduction of Checkout API
taxonomy:
  category: docs
---

The Checkout API is a hybrid server-side / client-side API. By using a shared secret, you are able to extract data for the product catalog to use for saving your own local cache, or to generate static product pages. At the same time, the API can be used directly by the customer using Javascript to handle their cart and order finalization.

You can view our [OAS 3.0.2 specification for the CheckoutAPI](https://docs.centra.com/swagger-ui/?api=CheckoutAPI). It contains all models and request/response examples you need to get started.

## Introduction

### Centra basics

First, you need to know some Centra basics before you start, such as the concepts of Pricelists, Languages and Markets.

An important part for deciding upon how you will use the Checkout API is to understand the following rules:

1. The combination of Market, Pricelist and Language decides what products that will be visible, what price/currency they will use and what language the description fields will contain.

2. The only thing changing the existance of products is the market. If a specific market is used, it will list the exact same amount of products for every pricelist inside this market. This is really important if you want to do a server-side cache of the product data. If you would create a cache combination based on each version of market+pricelist+language, you could easily end up with an exponential amount of cache combinations.

3. A product without a price inside a pricelist will still be visible, however it will not be possible to purchase (`price` will be defined as `null`. You can always filter out the non-available items by using `onlyAvailable: true`, more on this below).

### Backend

While theoretically you could build a client-side only shoppable website on top of Checkout API using only HTML, JavaScript and CSS, **any practical implementation requires a backend**.
The backend communicates server-to-server with the Checkout API. While you have great freedom to design your backend the way you like, features likely include:
* Caching of the product catalog and other infrequently changing data (trying to call Checkout API on every page load would result in rate limiting/errors and/or API usage overage charges)
* Tracking using server-to-server tracking services for analytics and marketing purposes
* Accessing data through the Checkout API that is not available in client-side mode

The backend can be implemented in any technology you prefer as a full scale application or a serverless function.

### Installation

The Checkout API is a plugin that can be enabled on a B2C-store. You can select whatever URI (part of the URL) you want it located on. The URI set the plugin will enable the plugin under `/api/X` (Where `X` is the URI of the plugin).

![Plugin list](plugin-setup.png)

A plugin defined like this will be located at `/api/checkout/`.

### Permalink of a plugin

Since plugins in Centra can share the same URI (for allowing the same URI to be used across different segments of customers by markets, languages, etc) you can also specify the Plugin ID as a part of the URL, this will make sure that even if you have multiple plugins with the same URI you will always know that you will access the correct one. This means that if you have a set up like this on a store:

![Plugin list](plugin-list.png)

You can access this plugin also by the following path: `/api/checkout/52/`. This will make sure the URL does not suddenly use a different plugin if you would add multiple plugins with the same URI in the future. The "Absolute API Endpoint" will be shown in the plugin settings.

## Authentication

Since Checkout API is a hybrid API, the authentication for Checkout API is divided into two different usage scenarios. **Client-Side**, when the customer itself connects directly to the API using Javascript from a website. Or **Server-Side**, when you as a partner want to consume the API from your server, for creating a local cache, generating static websites for the product catalog, or for making modifications to a selection that the customer is not allowed to do themselves (such as modifying the market of the selection).

The biggest difference is that the **Server-Side** API needs a Shared Secret that can be set inside the plugin settings:

![Server-side auth](server-side-auth.png)

Using the Shared Secret header will enable endpoints and variables that can only be used when a valid secret is sent in the request.

Also, CORS (Cross Origin Resource Sharing) prevents you from accidentially using the shared secret in the client-side communication through the browser. If the headers `Authorization` or `API-Authorization` are used in the browser, the request will fail:

![Preflight error](pre-flight-error.png)

This is to prevent the secret from being used publicly when doing client-side communication.

### Client-side communication example

When the API is used client-side, the authentication is making sure that the Origin is validated against the list of "Allowed Origins":

![Allowed origins](allowed-origins.png)

To make sure that only the origins you allow can use the API, please make sure you add the endpoints that you're currently using to this list. When a non-allowed origin is used, the API will respond with a status `401 Unauthorized`.

Origins are not checked if not provided in the plugin configuration. This may be preferable when you have multiple or dynamic list of subdomains for your QA/testing environment.

## Token

To maintain a state of a selection for a customer, regardless if server-side or client-side, there's a `token`-parameter inside the response JSON that will be used to maintain the current client-session:

```json
{
  "token": "25c00dc1efe0ff94aa9f8c8ca0deb71d",
  "...": "..."
}
```

This token can then be sent back to the API to maintain the current state of the current session. For example, let's say you call `GET /selection` to get the current cart for the customer:

```http
GET /api/checkout/selection HTTP/1.1
Host: example.centraqa.com
Origin: https://allowed-origin.example.com
```

JS-equivalent:

```javascript
fetch('https://example.centraqa.com/api/checkout/selection')
  .then(e => e.json())
  .then(e => console.log(e))
```

Response:

```json
{
  "token":"f611707b97e18a902270223b79f743c2",
  "...": "...",
  "location": {
    "country": "US", 
    "name": "United States",
    "...": "..."
  }
}
```

Now, let's say the customer wants to change their current country, we do this by a `PUT /countries/XX` where `XX` is the country-code. If the customer wants to change country to Canada, we would make sure that we save the `token` for the current user, and send it together with the PUT-request:

```http
PUT /api/checkout/countries/CA HTTP/1.1
Host: example.centra.com
Origin: https://allowed-origin.example.com
API-token: f611707b97e18a902270223b79f743c2
```

Javascript-equivalent:

```javascript
fetch('https://example.centraqa.com/api/checkout/countries/CA',
  {
    headers: {
      'api-token': '30a2fc9338a84a22f60ecd2ede1cc1bd'
    },
    method: 'PUT'
  })
  .then(e => e.json())
  .then(e => console.log(e))
```

If we would now fetch the selection again using the same token:

```javascript
fetch('https://example.centraqa.com/api/checkout/selection',
  {
    headers: {
      'api-token': '30a2fc9338a84a22f60ecd2ede1cc1bd'
    }
  })
  .then(e => e.json())
  .then(e => console.log(e))
```

The cart and the session for the customer is now based on Canada instead of the United States:

```json
{
  "token": "f611707b97e18a902270223b79f743c2",
  "location": {
    "country": "CA",
    "name": "Canada",
    "...": "..."
  }
}
```

### Token expiration

The current token being used for a customer can expire. In the case of an expired token, the request you will make will give you back a new value in the `token`-property for any request being made. To make sure you support token-expiration, make sure you check if the token in the response matches your current token, and update yours if it has changed. Depending if you're using cookies or local storage, the update of the token might differ. An example of what to do could look like this:

```js
if (response.token != currentTokenInYourState) {
  updateCurrentTokenInYourState(response.token)
}
```

### Token-less communication

If you are using server-side caching of content based on Centra, you might not need any tokens to connect to the customers requesting the content at all, since you will be using the content for more than one customer. To avoid creation of tokens completely when you do not need them, you can provide `none` to the API-token:

```
API-token: none
```

This will make Centra not return any token at all in the response, and will not save the current settings. This allows the request to not talk with the token storage and will speed up the response.

### Encoding of dynamic parameters in routing

Some of the API-endpoints, like `DELETE /vouchers/{voucher}` contains a dynamic parameter in the URL. It's important to make sure you are **always** URL-encoding the dynamic URI-components properly. For example, having a voucher code with `+`, ie: `TEST+CODE` should be sent to `DELETE /vouchers/TEST%2BCODE` and not `DELETE /vouchers/TEST+CODE`.

**From a security perspective this is also important since if someone would provide a voucher code of `../something-else-than-vouchers/foo` the request would actually become `DELETE /something-else-than-vouchers/foo`.**

You can solve this by always use `encodeURIComponent` for the dynamic parameters in a URL:

```js
let voucherCode = 'TEST+CODE';
fetch('https://example.centra.com/api/checkout/vouchers/'
  .concat(encodeURIComponent(voucherCode)),
  {
    method: 'DELETE',
    headers: {
      'api-token': '4sshe934mj1hni18dvn6n73uev',
    }
  }
).then(e => e.json()).then(e => console.log(e))
```

#### Skipping pre-flight requests

When doing cross domain client-side requests in the browser, the browser will make a pre-flight request (An OPTIONS request), to make sure that the actual request is allowed. This will now end up as two requests for any POST/PUT/DELETE-request you do, which will slow down the performance, for example when fetching the current selection:

![Pre-flight](pre-flight.png)

However, since Centra is validating the origin itself, you can prevent pre-flight requests on GET-requests by appending the `api-token=xxx` inside the `Accept`-header instead of using the `API-token`-header:

```javascript
fetch('https://example.centraqa.com/api/checkout/selection',
  {
    headers: {
      Accept: '*/*; api-token=f611707b97e18a902270223b79f743c2'
    }
  })
  .then(e => e.json())
  .then(e => console.log(e))
```

This will make sure GET-requests will not make an OPTIONS-request for each GET-request you do:

![No Pre-flight](no-pre-flight.png)

(**2019-12-20**: Please note that Chrome will also do a pre-flight request if you use `Accept: */*; api-token:xxx`, but not when using `Accept: */*; api-token=xxx`)

### Server-Side communication example

The server-side communication enables additional endpoints to be used, primarily from accessing the complete product catalog based on defined markets and pricelists. This gives the ability for the server-side communication to modify the pricelist and market for a selection by providing the ID of what market/pricelist you want to use.

A regular customer using client-side communication can only change the country on a selection, the market/pricelist will be decided based on the default settings defined for that country.

This enables you to write additional server-side logic to when a customer should be upgraded to a VIP-market or similar.

It also enables you to fetch product catalog information based on a specified market and pricelist, instead of letting Centra decide based on the IP and session of the consumer of the API.

As an example of this, let's look at this set-up. First, we have two pricelists, one `SEK` and one `USD`:

![Pricelists](pricelists.png)

Now, let's use client-side communication to fetch products from the browser:

```javascript
fetch(
  'https://example.centraqa.com/api/checkout/products',
  {method: 'post'}
)
.then(e => e.json())
.then(e => console.log(e.products[0].price))
```

This will fetch products and list the first product's price based on the consumer's geo-IP location. For my request, this will show up as `100.00 SEK`, since it uses the geo-location for my IP to decide what pricelist to use. 

However, let's instead make a curl-request using Server-Side communication with our shared secret and by also providing `pricelist:20` to the request:

```bash
curl -s \
 -H "Authorization: Bearer SharedSecretExample1234" \
 -H "Content-type: application/json" \
 -X POST -d '{"pricelist":20}' \
 https://example.centraqa.com/api/checkout/products \
 | jq -r '.products[0].price'
```

We will now get `10.00 USD`. This is because Server-Side communication allows you to fetch products based on any pricelist you want from the store.

#### Additional features for server-side communication

To optimize creating server-side cache, for example when using a static website generator to create your product pages, you're able to fetch products with all pricelists defined, but only when using the Server-Side Shared Secret. By providing `pricelist:all` all prices will show up, instead of the current one selected by the Geo-IP logic. This will instead of giving you a `price`-element, give you an associative array with each pricelist-ID as the key:

```bash
curl -s \
 -H "Authorization: Bearer SharedSecretExample1234" \
 -H "Content-type: application/json" \
 -X POST -d '{"pricelist":"all"}' \
 https://example.centraqa.com/api/checkout/products \
 | jq -r '.products[0]'
```

This request will respond with:

```json
{
  "product": "61",
  "name": "Test Product Discounted",
  "uri": "test-product-discounted-blue",
  "...": "...",
  "prices": {
    "1": {
      "price": "3.00 USD",
      "priceAsNumber": 3,
      "priceBeforeDiscount": "3.00 USD",
      "priceBeforeDiscountAsNumber": 3,
      "discountPercent": 0,
      "showAsOnSale": false,
      "showAsNew": false
    },
    "19": {
      "price": "291.00 SEK",
      "priceAsNumber": 291,
      "priceBeforeDiscount": "300.00 SEK",
      "priceBeforeDiscountAsNumber": 300,
      "discountPercent": 3,
      "showAsOnSale": true,
      "showAsNew": false
    }
  },
  "...": "..."
}
```

### Security

**As mentioned above, a best practise is to make sure that the Server-Side communication secret is not publicly accessible**. To prevent a disaster if this would happen, we are still limiting the amount of data that can be accessed or modified.

1. Each selection uses a UUID (Universally unique identifier). The Server-Side secret can modify open selections, but needs to know every selection's UUID to be able to modify it.
2. Any active pricelist inside the store can be listed and used by the party knowing the shared secret. However, Centra will only allow to ship to the countries having that currency enabled inside a shipping list. Using another country as the shipping country will still revert to the preferred currency for that country.
3. Any active market can be used and accessed by the party knowing the shared secret. This means that if you have a limited subset of products only enabled for a VIP-market, these products would be possible to be sold if the shared secret was exposed.

### Updates of the API

We might add new routes or properties to objects in the API without bumping the version. We will not remove or change any existing properties or routes to an already released version. You should make sure us adding new properties to existing objects will not break anything in your end.

### Correlation ID

All our API:s supports listening to a `X-Correlation-ID`-header in the request being sent to us. This will add traceability and allows you to track each request you make to Centra using the API-logs. The Correlation-ID will be reflected back in our response and will also be sent to the additional plugins that supports it:

```javascript
fetch('https://example.centra.com/api/checkout/selection',
  {
    headers: {
      'api-token': '4sshe934mj1hni18dvn6n73uev',
      'x-correlation-id': 'un1qu3-1d3nt1f13r-f0r-th1s-r3qu3st'
    }
  }
).then(e => e.json()).then(e => console.log(e))
```

## Functionality

The functionality for the Checkout API consist of the following sections:

* **Product data**. The Checkout API allows you to filter products based on certain criteria. You're able to define certain filters in the plugin settings to allow the customer to filter on custom attributes, brands or availability.
* **Selection handling**. The selection handling allows you to finalize an order with third-party payment methods, by following our defined integration flows you're able to support all payment methods currently available in Centra without the need of doing too much of customization per each payment method.
* **Routing**. You can use the Checkout API to handle routing, giving you different options on what to render based on the URI being accessed. This allows you to use Centra's routing as a fallback to make sure the proper page is shown when navigating on your page.
* **Customer handling**. The API allows customer to register, modify their customer details, sign in, forgot password/reset password and sign out. This will also make sure the customer can maintain its cart across multiple sessions and browsers.
* **CMS articles/pages**. If the CMS-module is installed on the Centra-instance, the Checkout API allows you to extract CMS-articles, both using the routing mechanism, but also based on a similar filter like the product data. You are allowed to disable the CMS-endpoints completely in the plugin if you do not want the data to be public.

## Webhooks

Webhooks whenever content changes can be really good if you're using any form of caching of Centra's data. By listening and invalidating depending on what webhooks Centra will send you you will be able to keep a fresh cache and only refresh it when Centra tells you the content was modified.

The first version of the Webhook plugin is a simplified version of the models in Centra based on what is exposed in the CheckoutAPI, this means that the events you get only contains the type of object and the unique identifier of what object that was modified. You are then supposed invalidate your cache for this object and fetch it again from the Checkout API.

You can find the Webhook as a separate plugin, and how to set it up is explained under [Plugins / Centra Webhook](/plugins/centra-webhook).

## API as a routing mechanism

As mentioned above, the Checkout API has a `/uri`-endpoint that allows you to send in the current path (URI) where Centra will respond with the content for the page provided. This allows you to use Centra as a fallback routing option to allow rendering of product, category and CMS-pages. This also opens up preview-modes directly from the Centra backend.

## Performance and caching

The Checkout API is built to fetch as little data as possible. For a regular consumer of the Checkout API, endpoints fetching data stored in Centra, like `/products`, `/uri`, `/items`, `/countries` and `/selection` should respond in and around 100 ms. Other endpoints, especially ones involving 3rd party APIs (like payment and shipping providers) introduce additional delay, not controlled by Centra directly. This is why `/payment` and `/payment-result` endpoints may take longer to respond, still likely no longer than 250 ms in normal circumstances. Please only treat those numbers as rough estimates, as the precise times may depend on the complexity of the features enabled in your Centra instance, and the unpredictable nature of Internet routing.

[notice-box=info]
Checkout API is great at quickly serving data, but to a reasonable number of sources. Unless you run a really small online store, with very few concurrent customers, we highly recommend you to design your own cache, and mostly use Checkout API to feed the data into it. Having your own server-side cache in case of larger websites is a hard requirement, without which you may have trouble scaling up the performance of your solution as customers numbers increase.
[/notice-box]

We mostly recommend you to cache the `/products` data, with descriptions, categories, translations and related products. You can choose to pre-load products images, which in Centra are served from CDN caches spread around the globe.

How can you know when the data in Centra has changed and your cache needs to be updated? [By using our Centra webhook plugin](/plugins/centra-webhook), of course! First, use the webhooks to only update the relevant parts of cache on demand. Add to that a method to completely re-build your cache from scratch in case of recovery after a critical application or network failure. With both solutions, your cache should be both light to run, which will work great with Checkout API, as well as resiliant to issues, when you have the big red button to refresh it completely. And if you're planning to integrate with external search engines in the future, building your own cache is a great first step to take.
