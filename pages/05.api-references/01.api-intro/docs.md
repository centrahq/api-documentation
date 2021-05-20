---
title: Introduction to Centra APIs
altTitle: API introduction
excerpt: General information common to all existing Centra APIs. How to pick the right API for your use case?
taxonomy:
  category: docs
---

Centra has a few different APIs used for different purposes. This documentation explains all the different APIs used to connect to Centra.

**From one developer to another, we’re here to help you!**

Building an experience on Centra’s APIs? [E-mail partner support](mailto:support@centra.com) to get setup with real-time Slack support, or sign up for Centra Certified Developer Training.

What are you waiting for? [Get in touch](https://www.centra.com/contact.html) to get going with Centra.

### Installation

Each API has its own plugin. Some of the APIs need activation from Centra, such as the subscription API, but the other ones can be easily enabled by adding a new plugin to your store.

To enable a plugin in Centra, go to `SYSTEM`, then select `STORES`. Select what store you want your API to connect to and select the API in the list of plugins. You will need administration rights to have access to `SYSTEM`.

### Endpoints

Every API installed in Centra gets its own API-endpoint. This endpoint will then be the prefix of every API-call. In the documentation, this value is called `<base>`.

### Authentication

For authentication we use the API key, which is a shared secret generated in the Plugin settings of the API. You can use the `API-authorization: foo` header with the token. The overview section of each API Reference might also define other rules of how to authenticate.

Example request:

```text
curl -H "API-Authorization foo" <base>/orders
```

## Choosing the right API for your integration

Here are some examples which you can consider when planning your integration with Centra. If none of those covers your use case, let us know and we will advise!

### [REST] Webshop APIs (Checkout / Shop [deprecated])

If you are building a front end for your brand or store, either as a website or a mobile app, you should probably look into using the Checkout API. It's our hybrid webshop API, able to operate both in Client and Server mode. In Client mode, you operate in the context of your end-user session, your selection belongs to a specific Country (and therefore a specific Market and Pricelist), it has a specific language selected, etc. In this mode, no API authentication is required, all endpoints that are needed for building a shop are available without API password. You can fetch Products and Categories, add Items to your selection, apply Vouchers, change Shipping or Payment methods, and finalise the payment completing the order, all without using the API secret. However, if you'd also like to build some middle-ware, like a cache server, or an external CMS, you can use the authenticated Server mode in order to fetch Products from *all* Markets and Pricelists (useful when building a cache), get information about Pricelists and Markets other than the ones assigned to your customer's selection, or fetch information about Warehouses (which is not relevant from the perspective of the end-user, and shouldn't be exposed to them). To read more about building a front end using Checkout API, visit [Creating Front End for Centra store](/fe-development) section.

Shop API is an older, slowly deprecated webshop API, which only works in authenticated Server mode. It operates directly on selections (instead of sessions), is not aware of the end-user context, and is less capable performance-wise, since it doesn't use ES cache internally, like Checkout API does.

[notice-box=info]
Checkout API is highly recommended for any new implementations. Shop API will be deprecated in the near future.
[/notice-box]

### [SOAP] ERP system integrations

Many customers use the ERP systems, like Navision, to store the master of the data for Products, Customers, Pricelists and so on. If you need to integrate to those systems, you may be interested in our [SOAP API](/api-references/soap-integration-api). Since in this case Centra works in a slave mode, this is currently the only API that allows you to modify Centra Products, Pricelists, Invoices, Orders, etc. We very rarely add new features to this API, but we also have comprehensive docs covering most of use cases required when working with an ERP. They are all described in our [ERP integration guide](/guides/erp-integration).

### [REST] Integration API (Order API)

If your integration takes care of orders *after* they are created in Centra, you can look into using Order API. It covers lots of functions, like [WMS integrations](/guides/wms-integration), Return Management Systems, Stock management, etc. For those orders you may want to update existing Orders, create and modify Shipments, read or manipulate Stock, or read/create/update Returns. You also have access to Customer data and the [Supplier Module](https://support.centra.com/centra-sections/modules/supplier-module). With the right API plugin config, you will also be able to insert Orders directly into Centra (e.g. when migrating from another platform), or manipulate Vouchers (e.g. for cloning vouchers to give to your influencers).

Order API was originally built as a pick-and-pack service integration API, with a lot of functionality added over the years. It is, however, very far from being feature-complete. For this reason we are developing GraphQL API

### [GQL] GraphQL Integration API

This is designed to be the last integration API we will ever need. It gives you granular access to almost all parts of Centra, including the parts previously available only from the backend UI. The only limit is your imagination.

Currently, GraphQL works mostly in write-only mode, but we are adding new functionalities (including write) with every Centra version. Once it's done, it will deprecate Order API for sure, and possibly SOAP API as well.
