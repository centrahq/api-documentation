---
title: Back in stock feature using Rulemailer
altTitle: Back in stock with Rule
taxonomy:
    category: docs
excerpt: It is possible to set up the Back in stock feature to e-mail your customers reminders when an item is back in stock. Here's how you can configure it.
---

[notice-box=info]
This "Back in stock notifications" feature is not to be confused with newsletter
subscription with optional product data. The latter is still available through our [`/newsletter-subscription` endpoint](https://docs.centra.com/swagger-ui/#/6.%20customer%20handling/post_newsletter_subscription__email_).
Please take note of the differences between the two before starting your implementation.
[/notice-box]

## Legacy newsletter-with-product subscription
The old newsletter subscription registers user for the newsletter in Rule by creating a subscriber with a special tag.
While doing so it adds product details fields to the subscriber in Rule. When the stock is replenished a merchant is
able to filter subscribers **manually** using the tag and send the notifications that way.
It means there is no automation available when using this endpoint. Stock update **will not** trigger any automatic action.

For new sites we recommend you use the new back-in-stock feature (eg. [`/back-in-stock-subscription`](https://docs.centra.com/swagger-ui/#/6.%20customer%20handling/post_back_in_stock_subscription)
which provides automatic back-in-stock notifications and also takes into account shopper's ship-to location to send notifications only when the
product is indeed available for the end-customer.

## What is required to enable Back in stock?

An E-mail trigger plugin with Back in stock support. Currently 2 plugins support that type of notification:
- CRM / Klaviyo
- Email trigger / Rule

Plugin-specific configuration as well as configuring those products outside of Centra might be required to make the notifications work.

## How does Back in stock feature work?

### Subscribing

Customers can subscribe to products using both [Shop API](https://docs.centra.com/swagger-ui/?api=ShopAPI&urls.primaryName=ShopAPI#/6.%20customer%20handling/post_back_in_stock_subscription) and [Checkout API](https://docs.centra.com/swagger-ui/?api=CheckoutAPI#/6.%20customer%20handling/post_back_in_stock_subscription) store fronts. This information is then forwarded to the provider used. 

Required information
* E-mail: which e-mail to notify. when Checkout API is used, this can be left out if customer has logged in.
* Item: the item to be notified about.
* ShipTo: country (and state if necessary for the country), since  we allow for different warehouses to serve different parts of the world we need to know where the customer is so we only notify when item is available in this region. 

Optional:
* Language: the language to use. When using Checkout API it will be taken from session if not provided.

### Getting notified

When stock is added in Centra we will check if the modified item has any subscribers waiting for notification and if so we tell the provider how much stock is available for specific ship-to locations.
Then it is up to the mailer system to decide if and how many notifications will be sent and to whom.
Keep in mind that Centra does not control when and how many notifications are sent. That mechanics is implemented and depends solely on the notification service provider.

[notice-box=info]
You need to have at least `Minimum stock level` FTA stock available in order to trigger the stock updat proces. This is
to prevent sending the notification when stock level is so low that there is risk of running out of stock again before the notifications reach the recipients.
If you have less stock Centra will not trigger stock update for your product. Minimum stock value is 10 by default.
[/notice-box]

## E-mail providers with support for back in stock

### Rule

#### Configure

* Setup the E-mail trigger plugin for "Rulemailer v4"
* Provide an API key 
* Set "Enable back in stock notifications" to "yes"
![](rule-enable-back-in-stock.png)

#### How to use

When a subscriber requests to be notified of an item the tag `Rule - Waiting For Product Alert` will be applied, and then when stock is updated and the subscriber should be notified the tag is replaced with `Rule - Product Alert Triggered`, theese tags can be used to setup automation for notifying your subscribers. Refer to Rule documentation for details. Centra syncronises stock with rule every 15 minutes and only if stock level of the product is above declared minimum.

Email templates used in the automation can use custom fields set for the notification. Fields are accessible in the template as `CustomField:Rule-ProductAlert.<field_name>`. Refer to the [list](#available-fields) below to see what data is available for back in stock email templates.

The fields that are available as localised will be separate fields named as the normal field followed by an `_` and the language ISO 639-1 code. If the product has not yet been translated to this language this field will contain the unlocalised product name, making it always safe to use the localised field so long as the language remains active in Centra.

Example: 
> If you have German localisation configured and set in centra the field `DisplayName_de` will be available and will contain the german localised version of the display name. If you also have Spanish as language but have not yet added localisation for this the field `DisplayName_es` will be available and contain the same text as the `DisplayName` field.


#### Available Fields

| Field name | Contains                                                                   | Localized? |
|---|----------------------------------------------------------------------------|---|
| DisplayName | Display name                                                               | yes |
| DisplayUri | Display URI                                                                | yes |
| Brand | Brand name                                                                 | no |
| DisplayImage | Full URL for the first image for display in selected size  | no |
| Variant | Variant name                                                               | yes |
| Excerpt | Short description                                                          | yes |
| Description | Description                                                                | yes |
| SKU | Product number + Variant number                                            | no |
| SizeSKU | Size SKU                                                                   | no |
| EAN | GTIN (EAN/UPC)                                                             | no |
| Size | Size name                                                                  | no |
| PriceInRegion | Item price in subscribers region + currency, formated as defined in centra | no |
| PriceInRegionAmount | Item price for subscribers region as a number                              | no |
| CurrencyInRegion | Currency ISO code for subscribers region                                   |


#### Sending Notifications

Since it is Rule that contains the notification sending logic we encourage to familiarize oneself with [Rule Product Alerts](https://integrationdocs.rule.io/productalert/#header-triggering-alerts) documentation. Centra does not control when and how many notifications are sent, but updates stock information for subscribed products in Rule.

#### When is the product data sent to Rule?

In a basic scenario Centra contacts Rule twice:
1. When the shopper subscribes to a notification
2. When stock for the product is updated.

On both occasions product details [mentioned above](#available-fields) are sent to Rule to make it possible to
send a confirmation message containing the product details.
