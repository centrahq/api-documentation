---
title: Subscription API
altTitle: Subscription API
excerpt: The Subscription API is used for recurring sales where the orders are created automatically using a specified subscription period. Using the API you are able to create new subscriptions that will authorize the payment provider and enable orders to be created.
taxonomy:
  category: docs
---

# API Reference

The Subscription API is used for recurring sales where the orders are created automatically using a specified subscription period. Using the API you are able to create new subscriptions that will authorize the payment provider and enable orders to be created.

## Authentication

The `<base>` mentioned in the API-reference is the location of the plugin URL when installing the subscription plugin. The `secret` set up inside the plugin should be appended to every API-url using `?secret=xyz`.

```http
GET <base>/subscriptions HTTP/1.1
API-Authorization: xyz123
```