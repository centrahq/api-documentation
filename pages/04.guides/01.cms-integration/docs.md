---
title: Integrating Centra with an external CMS
altTitle: CMS integration
excerpt: Centra can be configured to integrate with your Enterprise Resource Planning system using SOAP API. Click here to see how to perform most common operations on Products, Markets, Warehouses, Stock, Orders, Shipments and Returns in both B2B and B2C sales.
taxonomy:
  category: docs
---

## Overview

Centra is a headless e-commerce software, meaning there are no CMS, front end templates or themes in Centra. Rather, Centra exposes data by means of APIs and a frontend implementation interacts with Centra using the APIs to fetch products data, manipulate a selection, proceed with a checkout, and so on.

Centra supports Direct-to-Consumer and Wholesale type webshops. This guide focuses on Direct-to-Consumer.

Most modern CMS systems today are modular in the sense that they allow the user to define “pages” which are made up of  “modules”. Centra allows a high degree of flexibility when it comes to segmenting customers for offering different audiences different products, prices, promotions, taxes, inventory levels, etc. A key to building a great website on Centra is therefore to map Centra’s tools for customer segmentation with the segmentation tools in the CMS - so that the right user sees both the right content from the CMS, and the right products, prices and promotions from Centra.

In this article we cover:  
* The customer segmentation tools in Centra
* How Centra handles translations and localization
* Fetching product data from Centra

Before you begin to work on your integration, make sure to read about Centra's [Store logic and other basic concepts](/overview/centra-overview).

## Multiple stores in Centra

Centra takes a segmented single-store approach, meaning there is no need to set up multiple Stores to serve different audiences with different offers. 

Centra does however offer the ability to set up multiple Stores. This can be used by a company operating two entirely different brands, or a company operating an outlet store at a different domain.

Most often the Stores would look entirely different, meaning using two entirely different CMS setups. It is also possible to let Store act as a filter within one CMS setup, however that tends to be more complex to manage for end-users. 

## Customer segmentation in Centra

Within a [Store](/overview/centra-overview#store), Centra uses two key tools for segmenting what offer should be available to what customer: [Market](/overview/centra-overview#market) and [Pricelist](/overview/centra-overview#pricelist). On top of this, the ship-to Country has some implications for segmentation. All three are typically set automatically based on Geo-IP, but can be set using different business logic as well. 

Market in Centra acts as a filter that can control access to viewing Products/Displays, Campaigns, Vouchers, Inventory, Shipping prices, and more. 

Pricelist controls access to prices (including Currency) but also acts as a filter that can control access to buying Products/Displays, Campaigns, Vouchers, Shipping prices, and more. 

For the Customer it is not possible to know what filters were applied, resulting in the access to a certain combination of products and prices. 

[notice-box=info]
Note: Market controls which Products/Displays are visible, Pricelist controls which products are buyable. A product might be visible but not buyable (if there is no price).
[/notice-box]

[notice-box=success]
Best practice: It should be possible to filter both CMS pages and CMS modules on both Market and Pricelist. The filters should be independent and both filter criteria should match for a page or module to be visible. 
[/notice-box]

[notice-box=success]
Best practice: In addition to Market and Pricelist, it is recommended to enable filtering CMS modules on ship-to Country. This enables displaying country-specific legal information in a convenient way. 
[/notice-box]

Prices and taxes are calculated on-the-fly by Centra and take many more parameters into account than Market, Pricelist and Country. 

## Translations and locales

Languages are completely independent of all other tools for segmentation in Centra. All text that will be visible to the end-user is translatable. Choice of language does not affect access to Products, prices, inventory levels or anything else controlled by Centra’s segmentation tools. 

Expected behavior is that a customer can select their language of choice regardless of where they want to ship their products. 

There is a fall-back language configured in Centra. In case a specific text string is not translated to the requested language, the fallback language will be used instead. 

Centra allows for both location-agnostic languages (e.g., `en` for English) and location-specific languages (e.g., `en-US` for American English and `en-GB` for British English). 

Filtering individual CMS modules for language makes no sense. Instead, entire pages should be translated (by combining translated modules) and the language of the pages should be put in the `lang` tag of the page, e.g., `<html lang="es-ES">`. 

[notice-box=success]
Best practice: Map languages 1-to-1 between the CMS and Centra. If possible, fetch the exact language codes from Centra programmatically to avoid user mistakes and misunderstandings.
[/notice-box]

[notice-box=success]
Best practice: Set up a fall-back language in the CMS. Use the same fall-back language in the CMS as is used in Centra. 
[/notice-box]

## Fetching data form Centra

Centra’s APIs offer various ways of fetching the data required for integrating CMS. 

It is recommended to use the [Checkout API (REST/JSON)](/api-references/checkout-api/api-reference) or [Integration API (GraphQL)](/api-references/graphql-integration-api) to get all the available Markets, Pricelists and Products/Displays. It is possible to get all the products for a specific Market, Pricelist and Language for caching. After the products are selected by the user when creating the page in the CMS it is advisable to save the ids of these products in the page data and fetch products by ids when rendering the page for the end-customer. [POST /products](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/5.%20product%20catalog/post_products), [GET /markets](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/1.%20general%20settings/get_markets), [GET /pricelists](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/1.%20general%20settings/get_pricelists) endpoints offer all the functionality required for the implementation. The Checkout API operates for one Store, while the Integration API operates across all Stores. 

### Example Integration API (GraphQL) queries

#### Fetching a list of Stores

Use this query to fetch a list of Stores, to allow the user to select which Store to work on. Filter out only Direct-to-Consumer stores unless you intend to support building Wholesale Stores (out of scope for this guide. 

```graphql
{
  stores(where:{type: DIRECT_TO_CONSUMER}){
    id
    name
  }
}
```

#### Fetching a list of Markets

Use this query to fetch a list of Markets in a specific Store. This can be used to create a filter for page and module visibility. 

```graphql
{
  markets(where:{storeId: 1}){
    id
    name
    assignedToCountries{
      name
      code
    }
  }
}
```

#### Fetching a list of Pricelists

Use this query to fetch a list of Pricelists. This can be used to create a filter for page and module visibility. 

```graphql
{
  pricelists(where:{storeId: 1}){
    id
    name
    currency{code}
    assignedToCountries{
      name
      code
    }
  }
}
```

#### Fetching a list of Countries

Use this query to fetch a list of Countries.

```graphql
{
  countries{
    name
    continent
    isEU
    states{
      name
    }
  }
}
```

#### Fetching the Category tree

Use this query to fetch the Category tree in Centra. We support up to 3 levels of nested categories.

```graphql
{
  categories(where: {isTopCategory: true}){
    id
    name
    uri
    childCategories{
      id
      name
      uri
      childCategories{
        id
        name
        uri
      }
    }
  }
}
```

#### Fetching a list of Displays with basic data

Use this query to fetch a list of Displays, filtering by Market. 

```graphql
{
  displays(where: {marketId: 5}){
    product{name}
    productVariants{name}
    id
    name
    description
    status
    prices{
      pricelist{
        id
        name
      }
      price{
        value
        currency{code}
      }
    }
  }
}
```

#### Fetching Displays with extended data

Use this query to fetch a Display, filtering by id. 

```graphql
{
  displays(where: {id: 1}){
    product{name}
    productVariants{name}
    id
    name
    status
    description
    shortDescription
    metaDescription
    metaKeywords
    updatedAt
    prices{
      pricelist{
        id
        name
      }
      price{
        value
        currency{code}
      }
    }
    canonicalCategory{
      name
      metaDescription
    }
    categories{
      name
      metaDescription
    }
    media{
      source(sizeName: "standard"){
        type
        url
      }
    }
  }
}
```

A detailed API specification can be found here: [https://docs.centra.com/graphql/](https://docs.centra.com/graphql/)

If you are confused by the discrepancy between Centra backend Product IDs and the Display IDs (also named `product` in the Checkout Webshop API), you can [read up on Products, Displays, Sizes and Items relation in Centra](/fe-development/fe-elements#why-do-i-see-different-product-ids-in-the-centra-backend-and-in-checkout-api).

## Routing

Centra’s APIs return a URI for each Display, but other than that, routing is up to the implementation. Most issues related to routing are straightforward and mostly concerns SEO considerations. 

However, inclusion of locales in routes requires some extra consideration. 

The ability to segment on Language and (ship-to) Country in routes tends to be useful for many marketing applications, including for product feeds, marketplace listings, SEO and more. 

The locale routes can be specified in many different ways, but following [BCP47 format](https://tools.ietf.org/search/bcp47) tends to be easy. If following the BCP47 format, the second part of the locale indicates the (ship-to) Country, while either the first part, or the full string, indicates the language. E.g., ‘en-US’ could refer to offerings available for customers in the US, viewed in (generic) English, or, if American English translation is available, to offerings available for customers in the US viewed in American English. 

Another option that tends to be used is language-country combinations. E.g., ‘en-US-US’ for offerings available for customers in the US in American English language or ‘en-US’ for offerings available for customers in the US in generic English. In this case the right-most part is always (ship-to) Country. 

A third option is to use local domain names to represent (ship-to) Country. E.g., mybrand.fr/en could refer to offerings available for customers in France, in generic English language. 

It is also possible to combine different ways of routing to Language/Country combinations - something which might be relevant for optimizing SEO as well as conversion. 

[notice-box=success]
Best practice: Allow routing to a specific Language/Country combination of a page, in one way or another. 
[/notice-box]

## Handling updates

Centra is a dynamic system, so it is possible that the Product/Display, Market or Pricelist data will be changed at any time. A CMS integration is recommended to handle the following situations elegantly:  
* A Product/Display is created/updated/deleted
* A Market is created/updated/deleted
* A Pricelist is created/updated/deleted
* A Locale is created/updated/deleted

It is advisable to inform the Customer about the changes and show the message that the Product/Display is no longer available and won’t be displayed for the end-user, so that the Customer can choose to remove the Product/Display or adjust the setup in Centra. 

It is possible to subscribe to webhook-style events from Centra to get notified about updates. [Click here to learn more about Centra Webhooks](/plugins/centra-webhook).
