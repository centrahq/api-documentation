---
title: Klaviyo CRM plugin (Beta)
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

### Cart link
Cart link: should be set to the URL your webshop uses for cart abandonment, e.g. https://example.com/abandoned-cart/{selection}

### Historical data export
Our integration allow you to export your data to Klaviyo. This action base on customer account, and customer account is main entrance to data. What does it mean? By choosing date in Transfer historical date starting from, you are choosing the date in history when the customer account was created. For example, from the image above, customer accounts newer than (or exactly this date) 05-10-2022 00:00:00 will be transferred to Klaviyo.

In the Synchronization status line, you will see current transfer status.

When synchronization is pending, you will not be able to set it up again. Synchronization settings are in read mode only:

![historical_data_pending.png](historical_data_pending.png)

During data export, the following event types will be sent:
- Placed Order
- Ordered Product
- Confirmed Order
- Cancelled Order
- Refunded Order

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
When creating a flow for a certain metric in Klaviyo, tags need to be matching the tags listed above.
[/notice-box]

List of all the synchronised events is visible in your account's activity feed:

![activity_feed.png](activity_feed.png)

When at least one event with a certain metric is sent to Klaviyo, you can choose it from the dropdown in create flow view:

![create_flow.png](create_flow.png)


### Configuring email templates

In order to send transactional email content in the language of the customer you will need one email template per supported language. To make it work, proper conditions based on profile's language need to be added. 

Example flow for `Placed Order` event could look like this:

![conditional_flow.png](conditional_flow.png)

In the synchronised events data, Centra is sending prices both in base currency selected in Centra store plugin and in customer currency.
In the email template following variables should to be used in order to use prices in customer currency in the email communication:

Item level variables:

- `{{ item.GrossPaidPricePerUnitInCustomerCurrency }}` - item price per piece in customer currency
- `{{ item.GrossPaidPriceInCustomerCurrency }}` - price for item line in customer currency
- `{{ item.TaxAmountInCustomerCurrency }}` - tax amount per item in customer currency
- `{{ item.DiscountValueInCustomerCurrency }}` - discounted value in customer currency
- `{{ item.OriginalPriceInCustomerCurrency }}` - original price for item line in customer currency

Event level variables:

- `{{ event.GrossPaidPricePerUnitInCustomerCurrency }}` - order total in customer currency
- `{{ event.DiscountValueInCustomerCurrency }}`- discount total in customer currency

You can browse all the item and event level variables on the details of certain event in activity feed.

## Available data for events

#### Placed Order, Confirmed Order, Refunded Order
```json
{
    "$event_id": 102,
    "$value": 215,
    "CustomerCurrency": "EUR",
    "GrossPaidPriceInCustomerCurrency": "215.00",
    "TaxAmount": "43.00",
    "TaxAmountInCustomerCurrency": "43.00",
    "Categories": [
        "shop"
    ],
    "ItemNames": [
        "Test Product"
    ],
    "Brands": [
        "Brand"
    ],
    "DiscountValue": -0,
    "Items": [
        {
            "ProductID": "1-1",
            "SKU": "123456789",
            "ProductName": "Test Product",
            "Quantity": 2,
            "VariantName": "Blue jeans",
            "GrossPaidPrice": "200.00",
            "GrossPaidPriceInCustomerCurrency": "200.00",
            "OriginalPrice": "200.00",
            "OriginalPriceInCustomerCurrency": "200.00",
            "GrossPaidPricePerUnit": "100.00",
            "GrossPaidPricePerUnitInCustomerCurrency": "100.00",
            "ProductURL": "",
            "ImageURL": "http://localhost/client/dynamic/images/1_9adfeff6f2-red.jpg",
            "Categories": {
                "1": "shop"
            },
            "Brand": "Brand",
            "TaxAmount": "40.00",
            "TaxAmountInCustomerCurrency": "40.00",
            "TaxPercent": 25,
            "Discounted": false,
            "DiscountValue": "0.00",
            "DiscountValueInCustomerCurrency": "0.00"
        }
    ],
    "BillingAddress": {
        "FirstName": "Jane",
        "LastName": "Doe",
        "Company": "Centra",
        "Address1": "Sveavägen 9",
        "Address2": "Address Two",
        "City": "Stockholm",
        "Region": "",
        "Region_code": "",
        "Country": "Sweden",
        "CountryCode": "SE",
        "Zip": "111 57",
        "Phone": "123456789",
        "Email": "test@centra.com"
    },
    "ShippingAddress": {
        "FirstName": "Jane",
        "LastName": "Doe",
        "Company": "Centra",
        "Address1": "Sveavägen 9",
        "Address2": "Address Two",
        "City": "Stockholm",
        "Region": "",
        "Region_code": "",
        "Country": "Sweden",
        "CountryCode": "SE",
        "Zip": "111 57",
        "Phone": "123456789",
        "Email": "test@centra.com"
    },
    "Shipping": {
        "Method": "pnl-bua (Ingrid)",
        "Cost": "10.00",
        "CostInCustomerCurrency": "10.00",
        "TaxAmount": "2.00",
        "TaxAmountInCustomerCurrency": "2.00"
    },
    "MethodForPayment": "dummy"
} 
```

#### Started Checkout

Started Checkout event data structure is the same as for Placed Order event but with extra field “AbandonedCartURL”

```json
{
    [...],
    "AbandonedCartURL": "https://example.com/abandoned-cart/{selection}"
}
```

#### Cancelled Order

Cancelled Order event data structure is the same as for Placed Order event but with extra field “Reason”

```json
{
    [...],
    "Reason": "Size too small"
}
```

#### Shipping Update

```json
{
    "$event_id": "Shipped-113-1",
    "OrderId": 113,
    "ShipmentId": "Shipped-113-1",
    "UpdateType": "Shipped",
    "Items": [
        {
            "ProductID": 1,
            "SKU": "123456789",
            "ProductName": "Test Product",
            "Quantity": 1,
            "GTIN": "ABCDEFGHIJKL",
            "Size": "",
            "VariantName": "Red",
            "GrossPaidPrice": "100.00",
            "GrossPaidPriceInCustomerCurrency": "100.00",
            "OriginalPrice": "100.00",
            "OriginalPriceInCustomerCurrency": "100.00",
            "GrossPaidPricePerUnit": "100.00",
            "GrossPaidPricePerUnitInCustomerCurrency": "100.00",
            "ProductURL": "",
            "ImageURL": "http://localhost/client/dynamic/images/1_9adfeff6f2-red.jpg",
            "Categories": {
                "1": "shop"
            },
            "Brand": "Brand",
            "TaxAmount": "20.00",
            "TaxAmountInCustomerCurrency": "20.00",
            "TaxPercent": 25,
            "Discounted": false,
            "DiscountValue": "0.00",
            "DiscountValueInCustomerCurrency": "0.00"
        }
    ],
    "ShippingAddress": {
        "FirstName": "Jane",
        "LastName": "Doe",
        "Company": "Centra",
        "Address1": "Sveavägen 9",
        "Address2": "Address Two",
        "City": "Stockholm",
        "Region": "",
        "Region_code": "",
        "Country": "Sweden",
        "CountryCode": "SE",
        "Zip": "111 57",
        "Phone": "123456789",
        "Email": "test@centra.com"
    },
    "ShippingMethod": "EUR",
    "TrackingNumber": "ABC123",
    "TrackingUrl": "https://test-tracking-delivery.com/ABC123",
    "PackagesAmount": 1,
    "ShippingDate": "2022-09-28 15:12:57",
    "MethodForPayment": "Third Party Payment"
} 
```

#### Gift Certificate

```json
{
    "$eventId": "123",
    "Name": "Some name",
    "Code": "Some_code",
    "Link": "https://test.com/",
    "Message": "Hello there!",
    "Date": "2022-01-01 00:00:00",
    "DueDate": "2022-01-01 00:00:00",
    "Description": "Your gift card!",
    "Friend": "Jane Doe",
    "$value": "100.00",
    "ValueInCustomerCurrency": "100.00",
    "CustomerCurrency": "EUR"    
}
```

#### Reset Password

```json
{
    "$event_id": "123",
    "PasswordResetLink": "https://localhost/password-reset?[...]"
}
```
