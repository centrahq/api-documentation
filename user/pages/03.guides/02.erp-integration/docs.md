---
title: Integrating Centra with external ERP systems
altTitle: ERP integration
excerpt: Learn how to integrate your Centra with your Enterprise Resource Planning system
taxonomy:
  category: docs
---

The SOAP API is built to integrate with ERP systems and communicates via XML.

## SOAP API introduction

This link contains all operations and XML structures of the API, made from the WSDL definition: (https://docs.centra.com/soap/index.php)

### ID Conversion Table

IDs and the ID conversion table is a fundamental part of this API.

The ids are always in the `<id>` tag on the XML, and are used to uniquely identify orders, products, customers and other data objects.

The ID conversion table translates back and forth between Centra’s internal database IDs and the IDs you chose on your side.

When data originates from Centra; for example from orders, you will always get Centra’s internal numeric ID. For orders this is the order number.

When data originates from your side, for example products, you can pick any unique `<id>` you prefer when you send the data to Centra. This is when the ID conversion table comes into effect; Centra will create a mapping from your ID to Centra’s internal numeric ID in the conversion table, and all data you see in the API will always use the ID you picked.

For example; you create a product with `<id>yourProductId</id>`. Once a product is created, you can update the product using that ID, and when you get an order from Centra containing that product, the XML data uses yourProductId for the product.

You can view and edit the conversion table in the Centra admin.

### Communication

Data transmission is always initiated by you. You request events to receive data from Centra, and you send updates to Centra when you want to modify data.

You will need to send a username and password with each request.

### Events and the Event Queue

When certain things change in Centra, an event is created in the SOAP API.

You need to fetch events from Centra regularly, and for each event you fetch you need to tell Centra to remove it from the queue.

This is the only way data is sent from Centra to your side.

Events are fetched using:

* events_Get (https://docs.centra.com/soap/index.php?op=events_Get)  
* events_GetByMarkets (https://docs.centra.com/soap/index.php?op=events_GetByMarkets) (you can fetch events only for one or more markets)

Events are removed from the queue with events_Done https://docs.centra.com/soap/index.php?op=events_Done

You need to use events_Done on all events, even if they are of an unknown type that you don’t handle. The API returns the oldest events, up to a 100 in each events_Get. If you do not use events_Done on all events, all 100 events will eventually be old and you won’t see any new events.

For example, if there are 234 events in the queue, events_Get will return the oldest 100. When you mark 10 of those as done with events_Done, they are removed from the queue. After that the queue will contain 224 events, events_Get will give you the 100 oldest again. This time 90 of those will be the same as the last time, 10 will be new.

The data for each event depends on the type of the event. Events of type “order” contain an order. The structure is the same as for the corresponding “update” operation for that type of data. An order event contains the data structure from orders_Update https://docs.centra.com/soap/index.php?op=orders_Update .

Each event contains the complete data for the thing that has changed. It does not contain any information about what has changed, you would need to compare it yourself to the data on your side to know that. This is a problem. Usually, this is solved by making rules for when the data is owned by one sytem or the other. For example, an order is owned by Centra until its imported into your system. From that point on, only your system can make changes to the order.

### Updates

The different update operations in the API will update or create new data objects in Centra. There are many different fields in the update operations, for example the products_Update https://docs.centra.com/soap/index.php?op=products_Update. You do not need to send all fields, only the ones that are required to identify what object you want to update (the different `<id>` fields) and the fields with data that you want to change.

The fields that you do not include in the update are not changed.

If the data object you send does not exist in Centra, it will be created.

For example the customers_Update lets you update or create retail customers. https://docs.centra.com/soap/index.php?op=customers_Update

You need to send the `<id>` to identify what customer to update. If no customer with that ID exists, a new customer is created.

If you send the `<firstname>` but not the `<lastname>` for an existing customer, the `<firstname>` will be changed and the `<lastname>` will not be changed (it will not be set to blank).

### Updates responses

All updates return the same type of response. `<success>` can be true or false. If success is false, the `<errors>` might contain useful information why it failed. The `<notices>` sometimes contain information, but that is normal and does not mean something went wrong.

```xml
<success>true</success>
<errors>
<notices>
  <message>Example 1</message>
  <message>Example 2</message>
</notices>
```

```xml
<success>false</success>
<errors>
  <message>Example 1</message>
</errors>
<notices/>
```

### API versions

We only have one API version. We never change any existing fields in the specification, but we sometimes add new fields. Please make sure the implementation you build does not break if new fields are added to the XML.

But we do have 3 different endpoints.

If you are building a new integration, use the “SOAP API” endpoint. It looks something like this: https://example.centra.com/ams/system/service/module/soap/api?wsdl

All examples in this documentation uses the “SOAP API” endpoint.

If you are working on an older integration, it might use one of the two “navision” endpoints. They look like this: https://example.centra.com/ams/system/service/module/navision/api?wsdl or https://example.centra.com/ams/system/service/module/navision/soap?wsdl

The older “navision” endpoints use a different XML namespace name, and one of them has a different way to send the login username and password. Other than that they are identical. These links contains all operations and XML structures of the older endpoints, made from the WSDL definition:

* https://docs.centra.com/silksoap/index.php
* https://docs.centra.com/silkxml/index.php
