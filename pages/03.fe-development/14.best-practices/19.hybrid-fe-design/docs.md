---
title: Hybrid FE design using Webhooks, Checkout and Shop APIs
altTitle: Hybrid FE design
excerpt: If you're building a larger website, you might want to use both Checkout and Shop APIs to build all your FE functions
taxonomy:
  category: docs
---

## Why does Centra provide two different webshop APIs

Shop API is our original webshop API, which was developed during a time when the Internet was in its earlier stages. Stateless REST APIs were becoming popular, and there wasn't much emphasis on considering the context of the webshop user, it was acceptable to serve the same data to everyone.

As time went on and Centra continued to progress, we recognized the limitations of stateless APIs where conserving bandwidth and minimizing unnecessary data exposure were becoming more important. To address this, we introduced the Checkout API, which was stateful and more byte-conservative to optimise the API responses based on the user's location and language.

In the present day we find that the demands have changed again, static page and smart caching are highly desired, stateful APIs such as Checkout API is not the best solution to feed middle-ware servers with data when that data depends on the context of the individual shopper. A stateless API that consistently serves all available data can prove valuable, particularly when building caches and retrieving all the necessary data.

## The high-level concept of a hybrid FE solution

![](fe-hybrid-design.png)

In short:  
* [Shop API](https://docs.centra.com/swagger-ui/?urls.primaryName=ShopAPI) builds the shop's backend, the backbone of your front end  
* [Checkout API](/fe-development/fe-elements) builds the shop's checkout experience, from entering the website to a successful checkout (or at least a [Cart Abandonment](/plugins/cartabandonment) email)  
* [Centra Webhooks](/plugins/centra-webhook) are used to only trigger updates of relevant data  

[notice-box=info]
In case of a network or application issues, remember to always include a mechanism to completely re-build your middle-ware cache from scratch. Use it as a failsafe after unplanned outages, where individual webhooks might have been lost.
[/notice-box]

## The one big thing in common

Both Shop and Checkout APIs use the same `product` IDs (which are [display item IDs](/fe-development/fe-elements#why-do-i-see-different-product-ids-in-the-centra-backend-and-in-checkout-api), meaning the product variants activated on a store display). These are the same IDs that are returned by the [Centra Webhook plugin](/plugins/centra-webhook) activated in a `Checkout API` mode. Therefore, same webhook events can be used by both APIs, for both back-end (Shop API) and front-end (Checkout API) functions.

Same `product` and `item` IDs are used by [GET/POST /products](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/5.%20product%20catalog/post_products) and [POST /items](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/2.%20selection%20handling%2C%20cart/post_items__item_) endpoints in both Shop and Checkout APIs.

## Characteristics of Checkout API

    + Newer Centra REST webshop API  
    + Stateful  
    + Returns only data relevant for session  
    + Small API response sizes  
    + Includes all most recent webshop functions  

    - Difficult to poll multiple markets / pricelists / warehouses / languages at once  
    - Building a cache / static page generation requires multiple API calls per each product  

## Characteristics of Shop API

    - Older Centra REST webshop API  
    - Stateless  
    - Returns all data, always  
    - Large API response sizes  
    - Not all latest webshop functions available  

    + By design returns products in all markets / pricelists / warehouses / languages at once  
    + Building a cache / static page generation requires much fewer number of API calls  

Basically, in Shop API each [GET /products/{productId}](https://docs.centra.com/swagger-ui/?urls.primaryName=ShopAPI#/default/get_products__product_) API call returns product information in every market / pricelist / warehouse / language  

### Known limitations of Shop API

Current known problems:  
    - Minimal data returned for each `relatedProducts`,  requiring one API call per each product ID  
    - Unable to fetch multiple product IDs at once
