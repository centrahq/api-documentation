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
3. Both `Merchant integrity policy-URL` and `Terms & Conditions-URL` are required and need to be valid URLs
4. Merchant GUID for your Qliro store - if you want to see links to Qliro Merchant panel.

### Create the plugin in Centra

Add `Qliro One` to your store you want to use it for. Insert the data gathered above and place it in the following fields:

![qliro-keys.png](qliro-keys.png)

#### Testing

To use plugin in Test mode and test against Qliro API sandbox set the following setting to "Yes":

![qliro-testmode.png](qliro-testmode.png)

[notice-box=alert]
You will need to disable test-mode for the plugin in Centra when you run it in production.
[/notice-box]

### Setup options

#### Notifications

Notification endpoints for all kinds of incoming notifications: customer checkout status, order management status and order validation are defined dynamically and provided for Qliro by the integration plugin.
There is no need to explicitly define them in plugin settings.

#### Require success validation

Optional order validation step fired when customer submits the order in the payment widget.  
It validates following data: 

- Customer identity (if option `Verify identity with BankID (SE only)` is used)
- Juridical type - whether the selected type is allowed by configuration
- Items availability

The result can be handled on frontend side, implementing callback `onPaymentDeclined()` which accepts decline reason as an argument. For more details please refer to Qliro documentation. 

#### Allow organizations to place orders

By enabling "Company" you can allow businesses to also place orders using Qliro One: 

![qliro-juridical-types.png](qliro-juridical-types.png)

#### Ask for newsletter signup

By enabling "newsletter signup" checkbox, it will be visible inside Qliro One widget. You can choose if it should be pre-checked or no.

![qliro-newsletter.png](qliro-newsletter.png)

#### Age restiction  

Age restriction setting allows to decide whether you want to provide `minimalCustomerAge` parameter on payment session initialization. Setting the value "Yes" enables an additional attribute on product level of type "Age limit" - visible in Catalog/Attributes setup.
If there is a product with age limit restriction in the basket, the `minimumCustomerAge` value will be sent to Qliro.

![img.png](qliro-age-restrict.png)

#### Verify identity with BankID - Sweden Only

Set to "Yes" if you want BankID to be required for customer to be able to complete purchase.

#### Customer information 

The payment widget can be prefilled with customer data coming from the selected source:

- basket shipping address
- basket billing address
- customer address

You can select if you want the address filled by customer in the payment widget to be used as the one visible on the order.

Setting `Use customer addresses from QliroOne` to "No" will ignore the address coming from the payment widget, so it should be used only when customer address information is collected in a separate form before proceeding to payment.

Configuration allows for preventing customers from changing the data that the payment widget is filled with on checkout initialization using "lock" settings.
Customer information can be locked partially or fully. 

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


#### Required configuration

To make sure that your Qliro One plugin will work, please make sure that the following configuration fields are filled:
- Qliro One API key
- Qliro One API secret
