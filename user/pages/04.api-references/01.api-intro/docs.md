---
title: Introduction to Centra APIs
altTitle: API introduction
excerpt: General information common to all existing Centra APIs
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
