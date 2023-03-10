---
title: Introduction to Centra APIs
altTitle: API introduction
excerpt: General information common to all existing Centra APIs.
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

`curl -H "API-Authorization foo" <base>/orders`

### Rate limiting

Rate limiting is a mechanism which protects our APIs and underlaying servers from being overloaded. We try to detect both sudden bursts of requests, which can overflow our receive queues, as well as prolonged increased series of API requests, threatening to overload our internal server resources over longer period of time. Monitoring of those rate limits can also give Centra a good idea of how much resources your integration needs, and how scalable it will be in the future.

[notice-box=info]
For now, rate limits are only introduced to our GraphQL API. In the future, we will introduce them in future versions of other APIs as well.
[/notice-box]

Types of rate limits introduced:  
* **Total number of requests** - to avoid too many requests to the server, we limit their number
* **Sum of query complexities of those requests** - more complex query generally requires more time and resources to be processed
* **Total number of mutations among those requests** - another layer of complexity that can’t be calculated, so we limit their number

Each of those will be calculated within two timeframes:  
* 10 seconds - ensures that there is no sudden short-term burst that can overwhelm the server
* 1 hour - ensures that there is no prolonged pressure on the server

[notice-box=alert]
Using rate-limited API versions will be required in the future. Once we deploy API version with rate-limits introduced, we will keep the old ones working for 6 months to make the transition possible.
[/notice-box]
