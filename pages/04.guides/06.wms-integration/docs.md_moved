---
title: Integrating Centra with external WMS systems using Order API
altTitle: WMS integration
excerpt: Centra can be integrated with your Warehouse Management System in order to handle pick-and-pack services, manage stock or take care of product returns. Click here to learn about the basic functionality of our Order API.
taxonomy:
  category: docs
---

Connecting a Warehouse Management System with Centra, to handle pick and pack with an internal or external logistic center, is easy when you're using Centra’s Order API. The API offers convenient endpoints optimized for this use case.

### Prerequisites

To implement a WMS integration using the Order API, you need access to Centra with a configured Order API endpoint. Always use the test environment when developing your integration.

[notice-box=alert]
Warning: Never use the integration you build towards a production Centra environment before it is thoroughly tested and verified to be working as intended!
[/notice-box]

### Overview

When an order is placed in Centra, it will need to be expedited to generate what in Centra is called “Shipment” (outbound delivery). The shipment is what the WMS reads from Centra. The process of fetching these shipments and sending back information when they’re actually physically shipped by your warehouse, is described in the steps below.

### Fetching good-to-go shipments

In order to fetch shipments that should be picked and packed by your logistics center, you should use the shipments endpoint of the Order API.

More information: [Order API - Get shipments](https://docs.centra.com/reference/stable/order-api/get-shipments)

Please note that you would need to auth with the secret key configured in the Centra Order API settings.

Using this endpoint, you’ll get all the available shipments that are ready to be shipped (the default behavior of the endpoint is to only return shipments with status good-to-go in Centra). Note that this endpoint is not an event queue, meaning all shipments available to be shipped always show up, even if you have fetched them before. Store the shipment id to make sure that you skip shipments that you have already fetched. Once shipments are marked as completed, they are by default ignored by Order API and will therefore not show up in the `get-shipments` call results.

### Capturing payments

You need to make sure that you capture payments associated with shipments. This will make sure that the payment is activated with the payment service provider.

More information: [Order API - Capture shipments](https://docs.centra.com/reference/stable/order-api/capture-shipment)

[notice-box=alert]
If you get an error response when trying to capture the shipment’s payment you should not proceed with sending the shipment. This is an indicator of potential fraud.
[/notice-box]

### Understanding shipment data

Each shipment node will contain all the data you need, delivery address, products and shipping information. `shippingList` will contain the data you would need to understand with which carrier and service the shipment should be sent. There is no standard here, so this needs to be aligned and well tested.

The node will also contain URLs to proforma invoices (if needed) and delivery notes that can be printed, if the WMS doesn’t already have its own that will be used.

```json
"proforma": "http://.../proforma?shipment=83651-1",
"deliveryNote": "http://../delnote?shipment=83651-1"
```

More importantly, it will contain the product that was ordered. A shipment may, of course, contain several products, in which case they will appear after each other.

This is how the product object will look like, it will vary depending on the number of items ordered.

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

`LineId` identifies the unique item row (hence the name). You’ll also get three different SKU nodes: `sku`, `variantSku` and `sizeSku`. To match them with the full product sku in the WMS you either need to concatenate these three fields or match with EAN, if applicable.

#### In case you use Ingrid

If you're using [Ingrid](/fe-development/ingrid-implementation) to show advanced shipping options in your checkout, after the Order is finalized you will see the Ingrid data on the Order:

```json
"shipwallet_courier_instructions": "",
"shipwallet_doorcode": "1234",
"shipwallet_id": "abcdef1234567890abcdef1234567890",
"shipwallet_method": "pnl-mpc",
"shipwallet_pickup": "12345",
"shipwallet_deliverytime": "YYYY-MM-DD"
```

The fields are:  
* `shipwallet_method`: The chosen shipping method  
* `shipwallet_pickup`: If the user has chosen to have the order delivered to a Service point, this is the carrier identifer of that service point. This might be empty, but if it is not, this is crucial to get right so the customer gets the goods to the right Service Point  
* `shipwallet_deliverytime`: When it should be delivered  
* `shipwallet_doorcode`: Door code, if applicable  
* `shipwallet_courier_instructions`: Generic instructions for the courier  
* `shipwallet_id`: Ingrid's unique identifier. Generally doesn't hold any value for the 3PL, but it might be useful for back tracing  

### Editing shipments

You can also update shipments, if the quantity shipped was lower than on the order. This will allow subsequent creation of additional shipments with the remaining items, or creating refunds for items that could not be shipped.

More information: [Order API - Update shipment](https://docs.centra.com/reference/stable/order-api/update-shipment)

### Marking shipments as complete

The last step of finalizing an order is to complete the shipment. This is the step where you can send carrier info and tracking number to Centra.

More information: [Order API - Complete shipment](https://docs.centra.com/reference/stable/order-api/complete-shipment)

### Warehouse and stock figures

In Centra, the user will configure for which warehouse stock values should be stored. As an integrator, you will simply send the value to Centra of each product. You should always send the physical value available, not any calculation of what’s available for sales. That calculation is done by Centra.

Keep in mind that you don’t need to send updates for every single stock movement since Centra has the order data and knows how many items belong to each order. Simply update the full stock on inbound deliveries, if the stock is manually changed in for example a stock-take or if a different system is picking stock from the same warehouse (which is not recommended).

[notice-box=alert]
Warning: Don’t do full stock synchronization at times when the stock is changing rapidly, as that could add back units that were sold a fraction of a second earlier into Centra’s stock.
[/notice-box]

However, it’s always good practice to schedule a regular stock sync, e.g. once a day. This will ensure the systems re-sync automatically if they should go out of sync for any reason.

More information: [Order API - Update stock](https://docs.centra.com/reference/stable/order-api/update-stock)

### Fetching products

In order to minimise work for the shared client, it is possible to fetch the products created in Centra, so that the client or you won’t have to create them in the WMS manually.

You'll be able to fetch all products, and you can also filter out products that are recently updated with the API call.

More information: [Order API - Get products](https://docs.centra.com/reference/stable/order-api/get-products)

The most important thing to think about here are the SKU fields. In Centra, a product can have multiple variants connected to the same main SKU, where as in most WMS systems this is not the case. While fetching a product, please make sure to create the products in the WMS, based on `sku`, `variantSku` and `sizeSKU`. These three concatenated would be the physical SKU on the shelf in the warehouse.

In the example below, you can see that neither `variantSku` nor `sizeSku` are configured, and in this case the full sku is only M411-740, which will not identify a specific item in the warehouse. If not all SKU values are available, you can use the EAN number instead.

```json
"sku": "M411-740",
"variantSku": "",
"sizeSku": "",
"ean": "57724280430011",
```

### Creating returns

If not all items in an order can be shipped, or if an order item has been returned by the customer, a proper Return with a refund should be created. When creating a Return, you will be able to specify (among other options) if a refund should be issued, whether or not the returned items should be put back into stock, or if any handling cost should be added.

It's important to note that the list of returned `products` is not made up of the product IDs, but rather of the `lineIds` taken from the shipment, as described in the [Understanding shipment data](#understanding-shipment-data) section.

```json
{
  "shipment": "120276-1",
  "returnStock": 1,
  "products": {
    "43243": "1",
    "43244": "1"
  }
}
```

More information: [Order API - Create return](https://docs.centra.com/reference/stable/order-api/create-return)

### Fetching returns

To get detailed information on existing returns, you can fetch returns for specific orders or shipments, or all of them.

More information: [Order API - Get returns](https://docs.centra.com/reference/stable/order-api/get-returns)
