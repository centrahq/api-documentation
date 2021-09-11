---
title: Qliro One
altTitle: Qliro One
excerpt: Learn how to use Qliro One payment plugin.
taxonomy:
    category: docs
---

Qliro One is a popular payment provider which allows payments with credit and debit cards, as well as "Buy now, pay after receiving goods" type of purchase. Here's all the information that you'll need to start using this plugin.

### Gather information from Qliro One

You need the following data:

1. The API key for your Qliro store.
2. The Secret for your Qliro store.
3. Merchant GUID for your Qliro store - if you want to see links to Qliro Merchant panel.

### Create the plugin in Centra

Add `Qliro One` to your store you want to use it for. Insert the data gathered above and place it in the following fields:

![qliro-keys.png](qliro-keys.png)

You can start testing the plugin using Test-Mode. If you want to use the Test-Mode remember to set:

![qliro-testmode.png](qliro-testmode.png)

### Setup options

There are a lot of options in the Qliro One plugin.

#### Allow organizations to place orders

By enabling "Company" you can allow businesses to also place orders using Qliro One: 

![qliro-juridical-types.png](qliro-juridical-types.png)

#### Ask for newsletter signup

By enabling "newsletter signup" checkbox, it will be visible inside Qliro One widget. You can choose if it should be pre-checked or no.

![qliro-newsletter.png](qliro-newsletter.png)

#### Age restiction  

- Todo or remove

#### Verify identity with BankID - Sweden Only

- Todo or remove

#### Customer information 

- Todo or remove

#### Geo-restrictions

As with all payment plugins if you want to pricelist/market/country restrict the plugin you have the ability to select this in the bottom of the setup.

#### Customization of Qliro One widget

You are able to customize colors in Qliro One widget - you are able to set colors of
* Background color
* Primary color
* Call To Action button
* Call To Action hovered button

You are able to set
* Subheader for shipping header
* Merchant constraint name

You are able to configure corner radius of
* General corner radius
* Button corner radius

![qliro-styling.png](qliro-styling.png)

#### Testing

To test the flow, you first need to make sure the `Test-Mode` is enabled and that the `Test mode` is set to `Yes`.

[notice-box=alert]
You will need to disable test-mode for the plugin in Centra when you run it in production.
[/notice-box]


#### Required configuration

To make sure that your Qliro One plugin will work, please make sure that the following configuration fields are filled:
- Qliro One API key
- Qliro One API secret
