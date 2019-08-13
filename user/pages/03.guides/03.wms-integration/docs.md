---
title: Integrating Centra with external WMS systems using Order API
altTitle: WMS integration
excerpt: Learn how to integrate your Centra with your Warehouse Management System
taxonomy:
  category: docs
---

Connecting a WMS system with Centra, to handle pick and pack with an internal or external logistic center, is easy using Centra’s Order API. The API offers convenient endpoints optimized for this use case.

## Prerequisites

To implement a WMS integration using the Order API, you need access to Centra with a configured Order API endpoint. Always use a non-live environment when developing your integration.

[notice-box=alert]
Warning: Never use the integration you build towards a production Centra environment before it is thoroughly tested and verified to be working as intended!
[/notice-box]

## Overview

When an order is placed in Centra, it will need to be expedited to generate what in Centra is called “Shipment” (outbound delivery). The shipment is what the WMS reads from Centra. The process of fetching these shipments and sending back information when they’re actually physically shipped by your warehouse, is described in a few steps below.

## Fetching good-to-go shipments

In order to fetch shipments that should be picked and packed by your logistics center, you will use the shipments endpoint of the Order API.

More information: <https://docs.centra.com/reference/stable/order-api/get-shipments>

Please note that you would need to auth with the secret key configured in the Centra Order API settings.

Using this endpoint, you’ll get all the available shipments that are ready to be shipped (the default behavior of the endpoint is to only return shipments with status good-to-go in Centra). Note that this endpoint is not an event queue, meaning all shipments available to be shipped always show up, even if you have fetched them before. Store the shipment id to make sure that you skip shipments that you have already fetched. Once shipments are marked as completed, they are by default ignored by Order API and will hence not show up.

## Capturing payments

You need to make sure that you capture shipments associated payments. This will make sure that the payment is activated with the payment service provider.

More information: <https://docs.centra.com/reference/stable/order-api/capture-shipment>

[notice-box=alert]
Warning: If you get an error response when trying to capture the shipment’s payment you should not proceed with sending the shipment. This is an indicator of potential fraud.
[/notice-box]

## Understanding shipment data

Each shipment node will contain all the data you need, delivery address, products and shipping information. shippingList will contain the data you would need to understand with which carrier and service the shipment should be sent. There is no standard here, so this needs to be aligned and well tested.

The node will also contain URLs to proforma invoices (if needed) and delivery notes that can be printed, if the WMS doesn’t already have its own that will be used.

```json
"proforma": "http://.../proforma?shipment=83651-1",
"deliveryNote": "http://../delnote?shipment=83651-1"
```

More importantly, it will contain the products that was ordered. A shipment may, of course, contain several products and they will appear after each other.

This is how the product object will look like, it will vary, of course, depending on the number of items ordered.

```json
"products": [
	{
		"lineId": "43243",
		"sku": "S123K456U1",
		"variantSku": "",
		"sizeSku": "",
		"name": "Product #1",
		"variant": "White",
		"size": "XS",
		"ean": "1234567890123",
		"qty": 1,
		"originalPrice": 500.5,
		"price": 450.5,
		"weight": 2,
		"weightUnit": "kg",
		"countryOfOrigin": "DE",
		"harmCode": "12345",
		"comment": ""
	},
	{
		"lineId": "43244",
		"sku": "S123K456U2",
		"variantSku": "",
		"sizeSku": "",
		"name": "Product #2",
		"variant": "Blue",
		"size": "XS",
		"ean": "1234567890124",
		"qty": 2,
		"originalPrice": 200.5,
		"price": 180.5,
		"weight": 1.5,
		"weightUnit": "kg",
		"countryOfOrigin": "CI",
		"harmCode": "12345",
		"comment": ""
	}
]
```

LineId is to identify the unique item row (hence the name). You’ll also get three different SKU nodes. Sku, variantSku and sizeSku, if more than just sku is populated with data, you need to concatenate these, to match them with the full product sku in the WMS, or match with EAN if applicable.

## Editing shipments

You can also update shipments, if the quantity shipped was lower than on the order. This will allow subsequent creation of additional shipments with the remaining items that could not be shipped or cancelling and refunding of items that could not be shipped.

More information: <https://docs.centra.com/reference/stable/order-api/update-shipment>

## Marking shipments as complete

The last step of finalizing an order is to complete the shipment. This is the step where you can send carrier info and tracking number to Centra.

More information: <https://docs.centra.com/reference/stable/order-api/complete-shipment>

## Warehouse and stock figures

In Centra, the user will configure for which warehouse stock values should be stored. As an integrator, you will simply send the value to Centra of each product. You should always send the physical value available, not any calculation of what’s available for sales. Centra calculates what is available for sale.

Keep in mind that you don’t need to send updates for every single stock movement since Centra has the order data and knows how many items belong to each order. Simply update the full stock on inbound deliveries, if the stock is manually changed in for example a stock-take or if a different system is picking stock from the same warehouse (not recommended).

[notice-box=alert]
Warning: Don’t do full stock synchronization at times when the stock is changing rapidly, as that could add back units that were sold a fraction of a second earlier into Centra’s stock.
[/notice-box]

However, it’s always good practice to schedule a regular stock sync e.g., once a day. This will ensure the systems re-sync automatically if they would ever go out of sync for any reason.

More information: <https://docs.centra.com/reference/stable/order-api/update-stock>

## Fetching products

In order to minimize work for the shared client, it is possible to fetch the products created in Centra, so that the client or you, won’t have to create them in the WMS system manually.

You’ll be able to fetch all products, and you can also with the API call, filter out products that are recently updated.

More information: <https://docs.centra.com/reference/stable/order-api/get-products>

The most important thing to think about here, is the sku fields. In Centra, a product can have multiple variants connected to the same main sku. Where as in most WMS’s this is not the case. While fetching a product, please make sure to create the products in the WMS, based on sku, variantSku and sizeSKU.

These three concatenated would be the physical SKU on the shelf in the warehouse.

In the example here, you can see that there are no variantSku nor sizeSku, and in this case the full sku is only M411-740, but it could’ve been a different scenario.

```json
"sku": "M411-740",
"variantSku": "",
"sizeSku": "",
```
