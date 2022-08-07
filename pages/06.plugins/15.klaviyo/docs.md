---
title: Klaviyo CRM plugin
altTitle: Klaviyo
excerpt: Learn all about the Klaviyo CRM plugin.
taxonomy:
category: docs
---

Klaviyo is a CRM plugin in Centra. The core functionality is sending events to Klaviyo that can be used for transactional emails and email and SMS marketing automation.


## Flow

1. You set up your Klaviyo account's API credentials (API key & API private key) and settings in Klaviyo store plugin. 
2. When store plugin is configured properly, Centra will start sending events to Klaviyo.
3. In Klaviyo account you can setup flows triggered off of the certain event types (metrics).

## Setup in Centra

Store plugin settings view in Centra AMS:

![store_plugin.png](store_plugin.png)

### API key & API private key

Copy the values of the API keys from [https://www.klaviyo.com/account#api-keys-tab](https://www.klaviyo.com/account#api-keys-tab) to store plugin configuration in Centra.

### Base currency

Currency used as a default currency in Klaviyo account. This currency will be used in all reports across the account.

### Language selected from

- Delivery country
- Site language

### Use short product name

Include variant name in product name.

### Product image size

Image size you want to send over to Klaviyo for all the products. Select a proper image size that works for your product catalog.

## Transactional emails


### Transactional flows configuration

In Klaviyo transactional and non-transactional automation is triggered off of the same metrics (events).
In order to setup transactional flows in Klaviyo refer to the [following guide](https://help.klaviyo.com/hc/en-us/articles/360003165732).
When plugin is activated, Centra will synchronize all the supported types of metrics, but you can choose which ones you want to listen to in your flows setup on your Klaviyo account.

Metric types currently supported by Centra:

  - `Reset Password`
  - `Created Account`
  - `Placed Order`
  - `Confirmed Order`
  - `Cancelled Order`
  - `Shipping Update`
  - `Delivered`
  - `Out for delivery`
  - `Shipped`
  - `Refunded Order`
  - `Gift Certificate`
  - `Started Checkout`

[notice-box=info]
When creating a flow for a certain metric in Klaviyo, tags needs to be matching the tags listed above in Centra.
[/notice-box]

List of all the synchronised events is visible in your account's activity feed:

![activity_feed.png](activity_feed.png)

When at least one event with a certain metric is sent to Klaviyo, you can choose it from the dropdown in create flow view:

![create_flow.png](create_flow.png)


### Configuring email templates


