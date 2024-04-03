---
title: Centra APIs vs functions
altTitle: APIs and functions
excerpt: How to pick the right API for your use case?
taxonomy:
  category: docs
---


Centra has a few different APIs used for different purposes. This documentation explains the functions and use cases that are covered by all the different APIs used to connect to Centra. Below are some examples which you can consider when planning your integration with Centra. If none of those covers your use case, let us know and we will advise!

### [REST] Checkout API

If you are building a front end for your brand or DTC store, either as a website or a mobile app, you should look into using Checkout API. It's our hybrid webshop API, able to operate both in Client and Server mode, giving you access to products catalog, prices, payments, checkout, shipping options, vouchers, anything you need to build a webshop. To read more about building a front end using Checkout API, visit [Creating Front End for Centra store](/fe-development) section.

### [REST] Shop API

Shop API is an older webshop API, which only works in authenticated Server mode. It is stateless, operates directly on selections (instead of sessions), and is not aware of the end-user context the way Checkout API is. It's not recommended to be used to build webshops directly, but due to its nature of always serving all of the data, it becomes very useful when implemented on server middle-ware for cache building and/or static page generation.

### [REST] Integration API (Order API)

If your integration takes care of orders *after* they are created in Centra, you can be interested in using Order API. It covers lots of functions, like [WMS integrations](/guides/wms-integration), Return Management Systems, Stock management, etc. For those orders you may want to update existing Orders, create and modify Shipments, read or manipulate Stock, or read/create/update Returns. You also have access to Customer data and the [Supplier Module](https://support.centra.com/centra-sections/modules/supplier-module). With the right API plugin config, you will also be able to insert Orders directly into Centra (e.g. when migrating from another e-commerce platform), or manipulate Vouchers (e.g. generating cloned vouchers for your influencers). To learn more, see [Order API reference](/api-references/order-api).

Order API was originally built as a pick-and-pack service integration API, with a lot of functionality added over the years. It is, however, very far from being feature-complete. For this reason we are developing GraphQL API.

### [GQL] GraphQL Integration API

This is designed to be the last integration API we will ever need. It gives you granular access to almost all parts of Centra, including the parts previously available only from the backend UI. The only limit is your imagination.

GraphQL is now officially out of Beta, and it has more features than ever. A full [ERP integration guide using GraphQL](/guides/erp-gql-integration) is available for anyone looking to replace their old SOAP or REST integration. More on product setup can be found in the [PIM guide](/guides/pim-gql-integration). Besides that, GQL API references section offers lots of copy-pastable examples, both for [DtC](/api-references/graphql-integration-api/examples/dtc) as well as [Wholesale](/api-references/graphql-integration-api/examples/b2b) use cases. To learn more, see [GraphQL Integration API](/api-references/graphql-integration-api).

Oh by the way, did we mention that GraphQL offers **100%** code coverage? Integral part of the API are the [automatically generated GraphQL API specifications for Centra Integration API](https://docs.centra.com/graphql/). This means that everyone who has the basic grasp of [GQL APIs in general](https://graphql.org), and knows the syntax used, is able to immediately use any and all of the available functions. Is there a use case you can think of how to implement? Now you no longer need documentation pages with instructions, now the available options are at your fingertips, with suggestion, immediate validation and basically self-writing code. You really have to try it to believe it. And once you do, you can use it to do anything with your Centra. Within reason, right?

#### [SOAP] ERP system integrations (deprecated)

Many customers use the ERP systems, like Navision, to store the master of the data for Products, Customers, Pricelists and so on. If you need to integrate to those systems, you may be interested in our [SOAP API](/api-references/soap-integration-api). Since in this case Centra works in a slave mode, this is currently the only API that allows you to modify Centra Products, Pricelists, Shipping, Invoices, etc. We very rarely add new features to this API, but we also have comprehensive docs covering most of use cases required when working with an ERP system. They are all described in our [ERP integration guide](/guides/erp-integration).

[notice-box=info]
SOAP API is not recommended for new integrations. Please look into using GraphQL Integration API, or REST Order API instead.
[/notice-box]

#### [REST] Subscription API (deprecated)

This API was replaced by the [new subscriptions functionality](/fe-development/subscriptions).

## Centra APIs vs functions

![Centra APIs vs functions](APIs.svg)

### Existing Limitations

<a id="LimitOrderWriteStock"></a>
Order API can be used to update stock values, but only for one Warehouse per each plugin instance.

<a id="LimitOrderReadAttributes"></a>
Order API only supports attributes on `product` and `variant` level. They are only returned through the `GET /products` endpoint.

<a id="LimitSoapWriteAttributes"></a>
SOAP API only supports custom attributes built into existing plugins, like Ingrid. It does not support custom attributes defined in the customer config.

<a id="LimitCheckoutB2B"></a>
Checkout API has limited support for Wholesale stores. We can recommend Centra Showroom for your B2B store, if you'd like.

<a id="LimitShopB2B"></a>
Shop API has limited support for Wholesale stores. Again, we have B2B Showroom. It's great.

<a id="LimitOrderWriteVouchers"></a>
Order API can be used to create very basic vouchers, or to clone voucher templates previously defined in the Centra AMS.

<a id="LimitCheckoutReadOrders"></a>
Checkout API can only be used to view the historical orders of currently logged in user. As a webshop API, it doesn't have access to other orders unrelated to the shopper.

<a id="LimitShopReadOrders"></a>
Shop API can only be used to view the historical orders of currently logged in user.

<a id="LimitSoapReadAll"></a>
With SOAP, each event should only be fetched once, synced with the ERP and then marked as done in Centra. After that, you can no longer fetch it from Centra directly, unless there's been changes that need to be synced to the ERP as well.
