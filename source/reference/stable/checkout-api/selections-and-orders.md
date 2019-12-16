# Selections and Orders

```eval_rst
.. api-name:: Checkout API
   :version: 1
```

## Overview

A *selection* is an open order, or a shopping cart. You add *items* to the selection, the product items to buy.

If you have found an item `1313-19728` using the products endpoint, you can add it to your selection:

```
POST items/1313-19728 HTTP/1.1
```

You get back the `selection`. The response also has the session `token`. Use the token for the API-token header, like `API-Token 297qi56173p6sm0l5bii30ois3`

## API Errors

The API reports errors by returning response code 400 or above.

The response body will contain an "errors" object when there is an error. So there are no errors if there is no "errors".

### Example:

`POST https://example.com/api/checkout/items/123-456`

Response:

```json
{
    "token": "0ms3rnl09a4i4brtbitt1o0cu1",
    "errors": {
        "item": "product item not found"
    }
}
```

## Payment flow

### 1: Add something to the selection:

`POST https://example.com/api/checkout/items/1313-19728`

In the response object you get back, there is
- token: the token to use for the "API-Token" header, session cookie
- selection: the selection (aka cart) with prices, currency
- products: the product data
- location: the customers country, we detect this with Geo-IP
- paymentMethods: the payment methods you can select
- paymentFields: the fields for the checkout.
- countries: all countries that we ship to. includes states for example for USA

### 2: (optional) change country

`PUT https://example.com/api/checkout/countries/SE`

You get back the same structure as in 1. This can change prices/currency and in some cases can remove items that are not for sale in the selected country.

### 3: (optional) select a specific payment method

`PUT https://example.com/api/checkout/payment-methods/payex`

`payex` here is from the `paymentMethods` in the previous responses. You get back the same structure as in #1.

### 4: Begin payment

`POST https://example.com/api/checkout/payment`

```json
{
    "paymentReturnPage":"https://mywebshop.example.com/payment-return-page",
    "paymentFailedPage":"https://mywebshop.example.com/payment-failed-page",
    "termsAndConditions":true,
    "address":{
        "firstName":"asd",
        "lastName":"asd",
        "email":"hello@example.com",
        "address1":"asd",
        "city":"asd",
        "country":"dk",
        "phoneNumber":"123123",
        "zipCode":"123"
    }
}
```

```eval_rst
.. warning:: Some integrations, like DHL shipping, require that you format the zip code (postal code) in a format that is commonly used in the shipping country. If you pass the zip code in a different format, creating a shipment can fail. It is therefore important that you follow the zip code formatting recommendation for every country you intend to ship to. For example, Swedish codes are formatted as `NNN NN` (with a space), in Germany you have: `NNNNN`, in Poland: `NN-NNN`, in Denmark: `NNNN`. A full list of postal codes formats by country can be found on Wikipedia: https://en.wikipedia.org/wiki/List_of_postal_codes. If you encounter any problems after following these guidelines, we recommend to contact DHL support.
```

Response:

```json
{
  "token": "0ms3rnl09a4i4brtbitt1o0cu1",
  "action": "redirect",
  "url": "https:\/\/ecommerce.externaltest.payex.com\/CreditCard\/Pay?orderRef=45bf8288461fa82be9014758f341f1b930"
}
```

This means you should redirect the visitor to the URL, to the payment page of `payex`.
The `paymentReturnPage` and `paymentFailedPage` in the request is where the visitor will return after the payment at `payex`. These must on your frontend.

 When the customer ends up on `paymentFailedPage`, you know that payment failed.

 When the customer ends up on `paymentReturnPage`, you MUST ask the API if the payment was a success. It can still fail. You do this by forwarding the GET and POST variables that the visitor had when it accessed the `paymentReturnPage` to the API:

### 5: Get the result of the payment

`POST https://example.com/api/checkout/payment-result`

```json
{
    "paymentMethodFields": {
        "orderNum": "1114",
        "paymentMethod": "payex",
        "orderRef": "ad0eccd6a1e9402facf09f6ac49e848f"
    }
}
```

You take the GET and POST variables that visitor had when it returned to the "paymentReturnPage" and send them to the API inside "paymentMethodFields".

Response (cut down):

```json
HTTP/1.1 200 OK
{
    "token": "dacdi99cb9q3vv5gl5lac6gmj6",
    "order": "1114",
    "status": "untouched",
    "..."
}
```

This response is a success. But i will change the format of this to match the other responses better.

## Payment flow, with klarna checkout
Similar to the above, with the following changes:

### 3: select klarna checkout as payment method

`PUT https://example.com/api/checkout/payment-methods/klarna-checkout`

### 4: Begin payment

`POST https://example.com/api/checkout/payment`

```json
{
    "paymentReturnPage":"https://example.com/payment-return-page",
    "paymentFailedPage":"https://example.com/payment-failed-page",
    "termsAndConditions":true,
    "address":{
        "country":"se"
    }
}
```

Response:

```eval_rst
.. code-block:: json
   :linenos:

   {
   "token":"0ms3rnl09a4i4brtbitt1o0cu1",
   "action":"form",
   "formHtml":"<div id=\"klarna-checkout-container\" style=\"overflow-x: hidden;\">\n    <script type=\"text\/javascript\">\n    \/* <![CDATA[ *\/\n        (function(w,k,i,d,n,c,l,p){\n            w[k]=w[k]||function(){(w[k].q=w[k].q||[]).push(arguments)};\n            w[k].config={\n                container:w.document.getElementById(i),\n                ORDER_URL:'https:\/\/checkout.testdrive.klarna.com\/checkout\/orders\/FZKBVVGD7PIIFMOOOE5N61Y5TKY',\n                AUTH_HEADER:'KlarnaCheckout MsmS7sUBsXVCIzo80FlZ',\n                LAYOUT:'desktop',\n                LOCALE:'sv-se',\n                ORDER_STATUS:'checkout_incomplete',\n                MERCHANT_TAC_URI:'http:\/\/example.com\/terms.html',\n                MERCHANT_TAC_TITLE:'Young Skilled',\n                MERCHANT_NAME:'Young Skilled',\n                MERCHANT_COLOR:'',\n                GUI_OPTIONS:[],\n                ALLOW_SEPARATE_SHIPPING_ADDRESS:\n                false,\n                PURCHASE_COUNTRY:'swe',\n                PURCHASE_CURRENCY:'sek',\n                NATIONAL_IDENTIFICATION_NUMBER_MANDATORY:\n                false,\n                ANALYTICS:'UA-36053137-1',\n                TESTDRIVE:true,\n                PHONE_MANDATORY:true,\n                PACKSTATION_ENABLED:false,\n                BOOTSTRAP_SRC:'https:\/\/checkout.testdrive.klarna.com\/170312-6cde26c\/checkout.bootstrap.js',\n                PREFILLED: false\n            };\n            n=d.createElement('script');\n            c=d.getElementById(i);\n            n.async=!0;\n            n.src=w[k].config.BOOTSTRAP_SRC;\n            c.appendChild(n);\n            try{\n                p = w[k].config.BOOTSTRAP_SRC.split('\/');\n                p = p.slice(0, p.length - 1);\n                l = p.join('\/') +\n                    '\/api\/_t\/v1\/snippet\/load?order_url=' +\n                    w.encodeURIComponent(w[k].config.ORDER_URL) + '&order_status=' +\n                    w.encodeURIComponent(w[k].config.ORDER_STATUS) + '&timestamp=' +\n                    (new Date).getTime();\n                ((w.Image && (new w.Image))||(d.createElement&&d.createElement('img'))||{}).src=l;\n            }catch(e){}\n        })(this,'_klarnaCheckout','klarna-checkout-container',document);\n    \/* ]]> *\/\n    <\/script>\n    <noscript>\n        Please <a href=\"http:\/\/enable-javascript.com\">enable JavaScript<\/a>.\n    <\/noscript>\n<\/div>\n"
   }
```

This response has a different `action` called `form`, and a `formHtml`. You need to display this `formHtml` in the frontend. This thing from klarna should redirect the visitor to the `paymentReturnPage` or `paymentFailedPage` after payment.
Klarna checkout gives us the customers address after the payment is done, so you only need to send the country to the API. We need the country to calculate prices correctly.

### 5: Get the result of the payment
This should be exactly like for payex. You will get different data from klarna, but just pass it on to the API and it will tell you if the payment was successful


## Payment response cases:

`POST https://example.com/api/checkout/payment` can respond with an error, or one of 4 different actions:

- `"action":"redirect"` like payex above, redirect the client to the `url` in the response.
- `"action":"form"` like klarna-checkout above, display this `htmlForm` HTML-snippet. The HTML you get for klarna checkout i unusual, for other payment methods that have this response it is a HTML form that you need to POST in the visitors browser. This requires a server side page on the frontend since you cannot POST a form like this with Javascript (as far as i know).
- `"action":"success"` this means the payment succeeded at once (no need for step 5 from above). It happens with some invoice payments or when the credit card number is integrated in our checkout page. The response contains the order data that you would otherwise get from step 5.
- `"action":"failed"` this means the payment failed at once.

So far, these 4 cases have covered all payment integrations we have. If we implement these, the checkout should work with lots of payment providers. Klarna checkout is the most odd one, that probably needs specific treatment in the frontend.

## Out of stock errors:

The API does a stock check at `POST https://example.com/api/checkout/payment`

If something is unavailable, you get back an error in `errors`, response code 410, and:

- `unavailable` contains a list of the items that were unavailable. These have been removed from the selection.
- the rest of the response looks like `GET selection`

Example, the selection.items has item=4-5, but quantity=5. the unavailable response looks like this:

```http
HTTP/1.1 410 Gone
Content-type: application/json

{
  "token": "atqsqi9m7llsp35hv5689m6tu5",
  "unavailable": [
    {
      "item": "4-5",
      "product": "4",
      "originalQuantity": 11,
      "unavailable": 6,
      "available": 5
    }
  ],
  "selection": {
    "currency": "SEK",
    "paymentMethod": "adyen-256",
    "..."
```

## Location

The response from the api contains a `location`, the visitors country. This is detected from the IP address with Geo-IP. This usually works, but sometimes it does not. For example if you are shopping on a satellite phone. You cannot buy anything until you set a country. Then it will look like this:

```json
"location": {
    "country": null,
    "name": "",
    "state": null,
    "stateName": "",
    "eu": false,
    "shipTo": false
}
```

The store may not ship to all countries. In this case, `shipTo` is `false`. And you cannot buy anything until you set a different country.

```json
"location": {
    "country": "AX",
    "name": "Aland Islands",
    "eu": false,
    "state": null,
    "stateName": "",
    "shipTo": false
}
```

We do not detect state from Geo-IP. But we need it for the countries that have states (in the JSON datas "countries") because some countries that have states use state-specific tax. This sets `country` + `state`:

`PUT https://example.com/api/checkout/countries/us/states/ca`

```json
"location": {
    "country": "US",
    "name": "United States",
    "eu": false,
    "state": "CA",
    "stateName": "California",
    "shipTo": true
}
```

`PUT https://example.com/api/checkout/countries/PL`

This is probably the most common, no states but `shipTo` is `true`:

```json
"location": {
    "country": "PL",
    "name": "Poland",
    "eu": true,
    "state": null,
    "stateName": "",
    "shipTo": true
}
```

If your code are connecting to the API from a server, instead of from the visitors browser, our Geo-IP lookup will always use the IP of your server. You need to have Geo-IP or a similar solution on your end, and tell the API what country the visitor is from.

## Address search for Klarna Invoice payments

`POST https://example.com/api/checkout/address-search`

```json
{
  "identityNumber": "410321-9202",
  "paymentMethod": "klarna-invoice"
}
```

Response

```json
{
"token": "3uqv8uq1ubltkppcmv4862e9j4",
  "address": {
    "firstName": "Testperson-se",
    "lastName": "Approved",
    "address1": "St\u00e5rgatan 1",
    "zipCode": "12345",
    "city": "Ankeborg",
    "country": "SE"
  }
}
```

This is specifically for klarna invoice, in sweden. 410321-9202 is a personal idenitity number for a klarna test customer.

## Localization

The language is set automatically using GEO IP. The API returns data localized to the selected language.

You can change the language with:

```
PUT /languages/de
```

Or with the optional `language` field when you change country:

```
PUT /countries/se
{
    "language": "sv"
}
```

The response JSON contains a `language` object, and also a list of `languages`, and `language` fields on the `location` and `countries`:

```json
  "location": {
    "country": "DE",
    "name": "Germany",
    "eu": true,
    "language": "de",
    "state": null,
    "stateName": "",
    "shipTo": true
  },
  "language": {
    "language": "de",
    "name": "Deutch"
  },
...
  "countries": [
    {
      "country": "AF",
      "name": "Afghanistan",
      "eu": false,
      "language": "en"
    },
    "..."
    {
      "country": "DE",
      "name": "Germany",
      "eu": true,
      "language": "de"
    },
    "..."
   {
      "country": "SE",
      "name": "Sweden",
      "eu": true,
      "language": "sv"
    },
    {
      "country": "CH",
      "name": "Switzerland",
      "eu": false,
      "language": "en"
    },
    "..."
  ],
  "languages": [
    {
      "language": "de",
      "name": "Deutch"
    },
    {
      "language": "en",
      "name": "English"
    },
    {
      "language": "sv",
      "name": "Svenska"
    }
  ]
}
```

The `languages` array is the possible languages, sorted by `name`. Use the `language` as the ID for selecting a language with the `PUT /languages/{language}`. If Centra is not localized, there will be only one language.

`countries` have a new `language` field, the default language for that country. Not sure if you have any use for this.

The `language` object is the selected language. This is what changes with `PUT /languages/{language}`

The `location.language` is just copied from `countries`. It is **not** the selected language.

### Centra setup:

In Centra you add new languages with System -> Languages. The "Language code" in Centra is the `language` id in the API.

The main Centra language (for not localized data) is called `en` and `English` by default, this is set up in the API plugin. For example, on a Swedish webshop the Centra data is probably in Swedish so it could make sense to set it as `sv` `Swedish` there.
