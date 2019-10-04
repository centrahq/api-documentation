---
title: Integrating Centra with external ERP systems
altTitle: ERP integration
excerpt: Learn how to integrate your Centra with your Enterprise Resource Planning system
taxonomy:
  category: docs
---



***



# Introduction

The SOAP API is built to integrate with ERP systems and communicates via XML.

## SOAP API introduction

This link contains all operations and XML structures of the API, made from the WSDL definition: [https://docs.centra.com/soap/index.php](https://docs.centra.com/soap/index.php)

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

* events_Get [https://docs.centra.com/soap/index.php?op=events_Get](https://docs.centra.com/soap/index.php?op=events_Get)  
* events_GetByMarkets [https://docs.centra.com/soap/index.php?op=events_GetByMarkets](https://docs.centra.com/soap/index.php?op=events_GetByMarkets) (you can fetch events only for one or more markets)

Events are removed from the queue with events_Done [https://docs.centra.com/soap/index.php?op=events_Done](https://docs.centra.com/soap/index.php?op=events_Done)

You need to use events_Done on all events, even if they are of an unknown type that you don’t handle. The API returns the oldest events, up to a 100 in each events_Get. If you do not use events_Done on all events, all 100 events will eventually be old and you won’t see any new events.

For example, if there are 234 events in the queue, events_Get will return the oldest 100. When you mark 10 of those as done with events_Done, they are removed from the queue. After that the queue will contain 224 events, events_Get will give you the 100 oldest again. This time 90 of those will be the same as the last time, 10 will be new.

The data for each event depends on the type of the event. Events of type “order” contain an order. The structure is the same as for the corresponding “update” operation for that type of data. An order event contains the data structure from orders_Update [https://docs.centra.com/soap/index.php?op=orders_Update](https://docs.centra.com/soap/index.php?op=orders_Update).

Each event contains the complete data for the thing that has changed. It does not contain any information about what has changed, you would need to compare it yourself to the data on your side to know that. This is a problem. Usually, this is solved by making rules for when the data is owned by one sytem or the other. For example, an order is owned by Centra until its imported into your system. From that point on, only your system can make changes to the order.

### Updates

The different update operations in the API will update or create new data objects in Centra. There are many different fields in the update operations, for example the products_Update [https://docs.centra.com/soap/index.php?op=products_Update](https://docs.centra.com/soap/index.php?op=products_Update). You do not need to send all fields, only the ones that are required to identify what object you want to update (the different `<id>` fields) and the fields with data that you want to change.

The fields that you do not include in the update are not changed.

If the data object you send does not exist in Centra, it will be created.

For example the customers_Update lets you update or create retail customers. [https://docs.centra.com/soap/index.php?op=customers_Update](https://docs.centra.com/soap/index.php?op=customers_Update)

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

If you are building a new integration, use the “SOAP API” endpoint. It looks something like this: [https://example.centra.com/ams/system/service/module/soap/api?wsdl](https://example.centra.com/ams/system/service/module/soap/api?wsdl)

All examples in this documentation uses the “SOAP API” endpoint.

If you are working on an older integration, it might use one of the two “navision” endpoints. They look like this: [https://example.centra.com/ams/system/service/module/navision/api?wsdl](https://example.centra.com/ams/system/service/module/navision/api?wsdl) or [https://example.centra.com/ams/system/service/module/navision/soap?wsdl](https://example.centra.com/ams/system/service/module/navision/soap?wsdl)

The older “navision” endpoints use a different XML namespace name, and one of them has a different way to send the login username and password. Other than that they are identical. These links contains all operations and XML structures of the older endpoints, made from the WSDL definition:

* [https://docs.centra.com/silksoap/index.php](https://docs.centra.com/silksoap/index.php)
* [https://docs.centra.com/silkxml/index.php](https://docs.centra.com/silkxml/index.php)



***



# Cookbook

## Connection test

To test the connection, use the events_Get operation. This is a read only operation, nothing bad can happen.

[https://docs.centra.com/soap/index.php?op=events_Get](https://docs.centra.com/soap/index.php?op=events_Get)

### Information you need

* The API endpoint (and WSDL if you use the WSDL definition to build a client on your side)
* Username
* Password

The API endpoint typically looks something like this: [http://example.centra.com/ams/system/service/module/soap/api](http://example.centra.com/ams/system/service/module/soap/api)

The WSDL definition is the API endpoint with ?wsdl at the end: [http://example.centra.com/ams/system/service/module/soap/api?wsdl](http://example.centra.com/ams/system/service/module/soap/api?wsdl)

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <events_GetRequest xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <type>all</type>
    </events_GetRequest>
  </soap:Body>
</soap:Envelope>
```

### Response

```xml
<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:events_Get>
      <ns1:events/>
    </ns1:events_Get>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

### Notes

The response you get when you try this can contain a lot of data in the `<ns1:events>` if there are events in the event queue.

## Markets

[https://docs.centra.com/soap/index.php?op=markets_Update](https://docs.centra.com/soap/index.php?op=markets_Update)

Creates new, or updates existing markets in Centra.

If Centra already has markets setup, you shouldn’t create new ones. Contact us directly so we can setup the existing markets in the ID conversion table instead.

As long as you are not working against a Centra instance that is used in production, this operation is simple and might be a good one to start with.

The `<id>` you send to Centra will be used to refer to that market in the future. For example; an order placed in the market Retail-Global will have that market `<id>` on it when you fetch the order data from Centra. It is only used for the integration between the systems, so it does not need to be readable. The ID `<id>` is added to the ID conversion table.

The `<description>` is the name of the market in Centra’s admin interface. So this should be something people understand.

### Information you need

* IDs of the stores (1 and 2 in the example below) for the `<store>`, and if they are retail or wholesale stores for the `<type>`. Ask us to provide this information for you.

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <markets_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <markets>
        <market>
          <id>Retail-Global</id>
          <store>1</store>
          <type>retail</type>
          <description>Global</description>
        </market>
        <market>
          <id>Retail-Sweden</id>
          <store>1</store>
          <type>retail</type>
          <description>Sweden</description>
        </market>
        <market>
          <id>Wholesale-Market</id>
          <store>2</store>
          <type>wholesale</type>
          <description>Global</description>
        </market>
      </markets>
    </markets_Update>
  </soap:Body>
</soap:Envelope>
```

### Response

```xml
<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:result>
      <ns1:success>true</ns1:success>
      <ns1:errors/>
      <ns1:notices/>
    </ns1:result>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## Product Data 1 - Sizetables

[https://docs.centra.com/soap/index.php?op=sizes_Update](https://docs.centra.com/soap/index.php?op=sizes_Update)

Before you can send product data to Centra you need to have sizetables in place.

This example creates two sizetables:

* One with sizes Small, Medium and Large. This will be used for a sweater in the next example.
* One with a single unnamed size. This will be used for a chair later, a product that does not have different sizes.

Notice that a sizetable contains one or more sizes (the SML size table contains the sizes S, M, and L) but in the XML request this is the other way around: `<sizetable>` is inside the `<size>`.

On the `<size>` level, the `<id>` must be unique within that sizetable.

On the `<sizetable>` level, the `<id>` must be unique for all sizetables.

Notice that the size with `<id>` OS has a blank `<description/>`. This is useful for products that do not have different sizes. The size is never mentioned in the webshop or wholesale showroom.

### Important

You cannot change a sizetable once it’s been created. This is because products are linked to the sizes in the sizetable, and this in turn connects to stock levels for the proucts and orders placed for these products.

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <sizes_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <sizes>
        <size>
          <id>S</id>
          <description>Small</description>
          <sizetable>
            <id>SML</id>
            <description>Small Medium Large</description>
          </sizetable>
        </size>
        <size>
          <id>M</id>
          <description>Medium</description>
          <sizetable>
            <id>SML</id>
            <description>Small Medium Large</description>
          </sizetable>
        </size>
        <size>
          <id>L</id>
          <description>Large</description>
          <sizetable>
            <id>SML</id>
            <description>Small Medium Large</description>
          </sizetable>
        </size>
        <size>
          <id>OS</id>
          <description/>
          <sizetable>
            <id>OneSize</id>
            <description>One Size</description>
          </sizetable>
        </size>
      </sizes>
    </sizes_Update>
  </soap:Body>
</soap:Envelope>
```

### Responses

The first time you send these sizetables, you will get some notices that new sizes are added.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:result>
      <ns1:success>true</ns1:success>
      <ns1:errors/>
      <ns1:notices>
        <ns1:message>Added new size: S: Small to: Small Medium Large!</ns1:message>
        <ns1:message>Added new size: M: Medium to: Small Medium Large!</ns1:message>
        <ns1:message>Added new size: L: Large to: Small Medium Large!</ns1:message>
        <ns1:message>Added new size: OS:  to: One Size!</ns1:message>
      </ns1:notices>
    </ns1:result>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

When you send the same sizes_Update again, nothing changes in Centra and you will not get any notices in the response.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:result>
      <ns1:success>true</ns1:success>
      <ns1:errors/>
      <ns1:notices/>
    </ns1:result>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## Product Data 2 - A Sweater

[https://docs.centra.com/soap/index.php?op=products_Update](https://docs.centra.com/soap/index.php?op=products_Update)

This example creates or updates a product – in this case a turtleneck sweater. It demonstrates Centra’s product structure of product, variants and sizes. The product comes in red and blue variants, and each variant is available in sizes S, M and L.

On the`<product>` level:

* `<id>` must be unique across all products
* `<status>` is the products status. It can be inactive, active or cancelled. Only active products are shown in a Centra store.
* `<sku>` see below
* `<description>` is the product’s name that people see in the Centra admin.
* `<folder>` is a way to organize products in the Centra admin (do not use an `<id>` for the folder). This is optional.
* `<brand>` is the product’s brand. The `<id>` is used only in the API, the `<description>` is the brand name displayed in the Admin and in the Centra stores.
* `<collection>` is the collection that this product is a part of. For example “Spring 2019”. This is optional.

On the `<variation>` level:

* `<id>` must be unique across all variants, not just the variants connected to this product
* `<stockid>` use the same value as `<id>`
* `<sizetable>` this is the sizetable that the variant has, and this determines what sizes it can have.
* The other fields have the same functions as those on the product level

On the `<size>` level:

* `<id>` here is for a size id, connected to the sizetable.
* `<ean>` is the EAN code (or GTIN, UPC, barcode). Centra does not require this field itself, but if Centra connects to other systems it might be required.

The `<sku>` field is not required by Centra itself, but if Centra connects to other systems it might be required. The `<product>`, `<variation>` and `<size>` each contain a `<sku>` field. To form the SKU of a size, you concatenate the `<sku>` from the product, variation and size. In the example, the full SKU for the red sweater in size S is TURTLE001RED01.

### Preconditions

* Sizetables must have been created in Centra

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <products_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <products>
        <product>
          <id>T001</id>
          <status>active</status>
          <sku>TURTLE001</sku>
          <description>Turtleneck sweater</description>
          <folder>
            <description>Sweaters / Turtleneck</description>
          </folder>
          <brand>
            <id>Example</id>
            <description>Example Brand</description>
          </brand>
          <collection>
            <id>XMAS</id>
            <description>X-Mas</description>
          </collection>
          <variations>
            <variation>
              <id>T001_RED</id>
              <stockid>T001_RED</stockid>
              <description>Red</description>
              <sku>RED</sku>
              <status>active</status>
              <sizetable>
                <id>SML</id>
              </sizetable>
              <sizes>
                <size>
                  <id>S</id>
                  <sku>01</sku>
                  <ean>1234567890123</ean>
                </size>
                <size>
                  <id>M</id>
                  <sku>02</sku>
                  <ean>1234567890124</ean>
                </size>
                <size>
                  <id>L</id>
                  <sku>03</sku>
                  <ean>1234567890125</ean>
                </size>
              </sizes>
            </variation>
            <variation>
              <id>T001_BLUE</id>
              <stockid>T001_BLUE</stockid>
              <description>Blue</description>
              <sku>BLUE</sku>
              <status>inactive</status>
              <sizetable>
                <id>SML</id>
              </sizetable>
              <sizes>
                <size>
                  <id>S</id>
                  <sku>01</sku>
                  <ean>2234567890123</ean>
                </size>
                <size>
                  <id>M</id>
                  <sku>02</sku>
                  <ean>2234567890124</ean>
                </size>
                <size>
                  <id>L</id>
                  <sku>03</sku>
                  <ean>2234567890125</ean>
                </size>
              </sizes>
            </variation>
          </variations>
        </product>
      </products>
    </products_Update>
  </soap:Body>
</soap:Envelope>
```

### Response

```xml
<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:result>
      <ns1:success>true</ns1:success>
      <ns1:errors/>
      <ns1:notices/>
    </ns1:result>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## Product Data 3 - A Chair

[https://docs.centra.com/soap/index.php?op=products_Update](https://docs.centra.com/soap/index.php?op=products_Update)

This example creates or updates a product. We will be using a chair for this example. The product does not have different variants or sizes. To fit Centra’s product structure, it is created with a single variant and a single size.

Notice that this example does not send a `<sku>` or `<ean>` as Centra does not require it. If your system has SKU and EAN codes, please send them anyway. This is just an example to illustrate that they are not required for the integration to work.

### Information you need

* Sizetables must have been created in Centra

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <products_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <products>
        <product>
          <id>PWC</id>
          <status>active</status>
          <description>Plain wood chair</description>
          <folder>
            <description>Furniture / Chairs</description>
          </folder>
          <brand>
            <id>Example</id>
            <description>Example Brand</description>
          </brand>
          <collection>
            <id>XMAS</id>
            <description>X-Mas</description>
          </collection>
          <variations>
            <variation>
              <id>PWC</id>
              <stockid>PWC</stockid>
              <description>Plain</description>
              <status>active</status>
              <sizetable>
                <id>OneSize</id>
              </sizetable>
              <sizes>
                <size>
                  <id>OS</id>
                </size>
              </sizes>
            </variation>
          </variations>
        </product>
      </products>
    </products_Update>
  </soap:Body>
</soap:Envelope>
```

## Product Stock 1 - Warehouses

[https://docs.centra.com/soap/index.php?op=warehouses_Update](https://docs.centra.com/soap/index.php?op=warehouses_Update)

Creates or updates warehouses in Centra.

In most cases your shouldn’t create new warehouses if Centra already has warehouses setup. Contact us directly so we can setup the existing ones in the ID conversion table instead.

This operation is optional. If you simply send stock numbers to a warehouse `<id>` in the next example without creating warehouses first, the warehouses will be created automatically.

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <warehouses_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <warehouses>
        <warehouse>
          <id>MainWarehouse</id>
          <description>Main Warehouse</description>
        </warehouse>
        <warehouse>
          <id>OtherWarehouse</id>
          <description>Other Warehouse</description>
        </warehouse>
      </warehouses>
    </warehouses_Update>
  </soap:Body>
</soap:Envelope>
```

## Product Stock 2 - Stock Update

[https://docs.centra.com/soap/index.php?op=products_Update](https://docs.centra.com/soap/index.php?op=products_Update)

Set product stock quantities in a warehouse.

This uses the same products_Update operation as the “Product Data”, but with fewer and different fields. It changes the stock quantities of the Chair from “Product Data 3 - A Chair”.

On the `<product>`, `<variation>` and `<size>` the different IDs remain from the “Product Data 3 - A Chair” example. These are required to identify what sizes to change.

The `<warehouseitems>` is new in this example, this sets the stock quantities of that size in two different warehouses
Important¶

The stock `<qty>` is the number of items that are available for sale and has not been reserved for existing orders. It is not the number of items on the shelf in the warehouse.

In Centra this is called FTA – free to allocate.

When an order is placed in Centra it will allocate (reserve) stock, reducing the FTA. The number on the shelf stays the same. After an order has shipped, the number on the shelf is reduced.

You need to send the number of items on the shelf in the warehouse minus what is reserved for unshipped orders in Centra or elsewhere.

This also means you should fetch orders from Centra before sending stock updates to be able to calculate the correct stock values. (See the order examples)

### Preconditions

* The products must exist in Centra

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <products_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <products>
        <product>
          <id>PWC</id>
          <variations>
            <variation>
              <id>PWC</id>
              <stockid>PWC</stockid>
              <sizes>
                <size>
                  <id>OS</id>
                  <warehouseitems>
                    <warehouse>
                      <id>MainWarehouse</id>
                      <qty>1</qty>
                    </warehouse>
                    <warehouse>
                      <id>OtherWarehouse</id>
                      <qty>2</qty>
                    </warehouse>
                  </warehouseitems>
                </size>
              </sizes>
            </variation>
          </variations>
        </product>
      </products>
    </products_Update>
  </soap:Body>
</soap:Envelope>
```

## Pricelists

[https://docs.centra.com/soap/index.php?op=pricelists_Update](https://docs.centra.com/soap/index.php?op=pricelists_Update)

Update or create pricelists. A pricelist contains prices for products in a specific currency.

This example creates two pricelists. One for the retail store and one for the wholesale store. You can have multiple pricelists in each store, and even multiple pricelists in the same store with the same currency.

Prices in Centra can be set at the product or variant level, but not on the size level.

### Information you need

* IDs of the stores (1 and 2 in the example below). Contact Centra directly to get provided with the correct IDs.
* Currencies in Centra matching the `<currency>` you send in the XML. Currencies are configured manually in Centra.

### Preconditions

* Products must exist in Centra. See the product examples.

### Fields

On the `<pricelist>` level:

* `<id>` is the unique ID of the pricelist
* `<description>` is the name visible in the Centra admin
* `<store>` and `<type>` connects the pricelist to a store
* `<currency>` is the name of the currency in Centra.

On the `<item>` level

* `<id>` is the product ID (See the product examples)

On the `<variation>` level

* `<id>` is the variation ID (See the product examples)

Notice that the wholesale prices have a `<priceb>` field. This is the recommended retail price. It is optional, and only used for wholesale.

Also note that the T001 product has prices on the variant level (the blue one is more expensive than the red one). The PWC product has prices on the product level, so if it had multiple variants they would have the same price.

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <pricelists_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <pricelists>
        <pricelist>
          <id>EUR-Retail</id>
          <store>1</store>
          <type>retail</type>
          <currency>EUR</currency>
          <description>Euro</description>
          <items>
            <product>
              <id>T001</id>
              <variation>
                <id>T001_RED</id>
                <price>123</price>
              </variation>
              <variation>
                <id>T001_BLUE</id>
                <price>234</price>
              </variation>
            </product>
            <product>
              <id>PWC</id>
              <price>1000</price>
            </product>
          </items>
        </pricelist>
        <pricelist>
          <id>USD-Wholesale</id>
          <store>2</store>
          <type>wholesale</type>
          <currency>USD</currency>
          <description>US Dollar</description>
          <items>
            <product>
              <id>T001</id>
              <variation>
                <id>T001_RED</id>
                <price>45</price>
                <priceb>123</priceb>
              </variation>
              <variation>
                <id>T001_BLUE</id>
                <price>67</price>
                <priceb>234</priceb>
              </variation>
            </product>
            <product>
              <id>PWC</id>
              <price>700</price>
              <priceb>1000</priceb>
            </product>
          </items>
        </pricelist>
      </pricelists>
    </pricelists_Update>
  </soap:Body>
</soap:Envelope>
```

## Wholesale Accounts 1 - Payment Terms

[https://docs.centra.com/soap/index.php?op=paymentterms_Update](https://docs.centra.com/soap/index.php?op=paymentterms_Update)

Create or update payment terms. The payment terms are set on an account, so they should be created before the account data is sent to Centra.

Notice that `<name>` is the name or title of the payent term in the Centra admin, the `<description>` is a longer optional descriptive text. This is different form other data in the API where `<description>` is the name or title of something.

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <paymentterms_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <paymentterms>
        <paymentterms>
          <id>30NET</id>
          <name>30 Days</name>
          <description>Optional text describing this paymentterm</description>
          <duedays>30</duedays>
        </paymentterms>
      </paymentterms>
    </paymentterms_Update>
  </soap:Body>
</soap:Envelope>
```

## Wholesale Accounts 2 - Shipping Terms

[https://docs.centra.com/soap/index.php?op=shippingterms_Update](https://docs.centra.com/soap/index.php?op=shippingterms_Update)

Create or update shipping terms. The shipping terms are set on an account, so they should be created before the account data is sent to Centra.

Notice that `<name>` is the name or title of the shipping term in the Centra admin. The `<description>` is a longer optional descriptive text. This is different form other data in the API where `<description>` is the name or title of something.

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <shippingterms_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <shippingterms>
        <shippingterms>
          <id>DDU</id>
          <name>Delivered Duty Unpaid</name>
          <description>Optional text describing this shippingterm</description>
        </shippingterms>
      </shippingterms>
    </shippingterms_Update>
  </soap:Body>
</soap:Envelope>
```

## Wholesale Accounts 3 - Account Data

[https://docs.centra.com/soap/index.php?op=accounts_Update](https://docs.centra.com/soap/index.php?op=accounts_Update)

Creates or updates an account. The account is the data for a wholesale customer, a company that can make purchases in Centra’s wholesale showroom.

### Information you need

* Store IDs of the wholesale store or stores. Contact us and we will provide them to you.

### Preconditions

* Pricelists should exist
* Markets should exist
* Payment and shipping terms should exist if you send the optional `<paymentterms>` or `<shippingterms>`

### Fields

* `<status>` can be active, inactive or cancelled. Only active accounts can make purchases
* `<accountaddress>` is the visiting address
* `<buyers>` is a list of one or more buyers. They are users that can log into the wholesale showroom and make purchases for the account.

Notice that you must send a `<buyer>` for the account to show in the Centra admin. Send one with blank name and email if you do not have this data in your system.

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <accounts_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <accounts>
        <account>
          <id>12345</id>
          <type>wholesale</type>
          <status>active</status>
          <description>Company Name</description>
          <market>
            <id>Wholesale-Market</id>
          </market>
          <pricelist>
            <id>USD-Wholesale</id>
          </pricelist>
          <paymentterms>
            <id>30NET</id>
          </paymentterms>
          <shippingterms>
            <id>DDU</id>
          </shippingterms>
          <accountaddress>
            <company>Example</company>
            <attn>Person name</attn>
            <address1>Street 1</address1>
            <address2>Suite 123</address2>
            <city>City</city>
            <state>State</state>
            <zipcode>12345</zipcode>
            <country>US</country>
            <email>info@example.com</email>
            <telephone>123 456 789</telephone>
            <url>www.example.com</url>
          </accountaddress>
          <shippingaddress>
            <company>Example Warehouse</company>
            <attn>Person name</attn>
            <address1>Street 1</address1>
            <address2>Suite 123</address2>
            <city>City</city>
            <state>State</state>
            <zipcode>12345</zipcode>
            <country>FR</country>
            <email>info@example.com</email>
            <telephone>123 456 789</telephone>
          </shippingaddress>
          <invoiceaddress>
            <company>Example Billing</company>
            <attn>Person name</attn>
            <address1>Street 1</address1>
            <address2>Suite 123</address2>
            <city>City</city>
            <state></state>
            <zipcode>12345</zipcode>
            <country>SE</country>
            <email>info@example.com</email>
            <telephone>123 456 789</telephone>
            <vat>SE12345678901</vat>
          </invoiceaddress>
          <buyers>
            <buyer>
              <id>12345_buyer1</id>
              <store>2</store>
              <status>active</status>
              <firstname>Frist</firstname>
              <lastname>Last</lastname>
              <email>first.last@example.com</email>
            </buyer>
          </buyers>
        </account>
      </accounts>
    </accounts_Update>
  </soap:Body>
</soap:Envelope>
```

## Orders - Retail 1 - Event

[https://docs.centra.com/soap/index.php?op=events_Get](https://docs.centra.com/soap/index.php?op=events_Get)

This example uses the events_Get operation to get order events. The response contains an order from the retail store, and examples after this one will update the order.

Notice that order has a `<shipment>` on it. Sometimes Centra is configured to automatically create shipments for retail orders. It can also be configured to not do that. In that case you would need to create the shipment. (This is illustrated in the wholesale order examples.)

### Request

* `<type>` limits the type of events you get. Using all will return all types.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <events_GetRequest xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <type>order</type>
    </events_GetRequest>
  </soap:Body>
</soap:Envelope>
```

### Response

On the `<event>` level

* `<id>` is the ID of the event itself. This is needed for the events_Done operation, the next example.
* `<type>` is the event type, the type of data inside `<data>`

On the `<order>` level

* This data is the same as the data you can send to the [https://docs.centra.com/soap/index.php?op=orders_Update](https://docs.centra.com/soap/index.php?op=orders_Update)
* `<id>` is the Centra order number, or the converted ID that was used when inserting or updating the order
* `<ordernumber>` is always the Centra order number

```xml
<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:events_Get>
      <ns1:events>
        <ns1:event>
          <ns1:id>115</ns1:id>
          <ns1:type>order</ns1:type>
          <ns1:entry>30</ns1:entry>
          <ns1:mission>update</ns1:mission>
          <ns1:date>2019-03-27 12:52:20</ns1:date>
          <ns1:data>
            <ns1:order>
              <ns1:id>30</ns1:id>
              <ns1:ordernumber>30</ns1:id>
              <ns1:type>retail</ns1:type>
              <ns1:store>1</ns1:store>
              <ns1:status>processing</ns1:status>
              <ns1:ordertotal>1135.00</ns1:ordertotal>
              <ns1:currency>EUR</ns1:currency>
              <ns1:currencyrate>10.43100</ns1:currencyrate>
              <ns1:basecurrency>SEK</ns1:basecurrency>
              <ns1:created>2019-03-27T12:52:20+01:00</ns1:created>
              <ns1:internal>false</ns1:internal>
              <ns1:preferred_shipping_date/>
              <ns1:collection>
                <ns1:id>XMAS</ns1:id>
                <ns1:description>X-Mas</ns1:description>
              </ns1:collection>
              <ns1:primary_warehouse>
                <ns1:warehouse>
                  <ns1:id>CW</ns1:id>
                </ns1:warehouse>
              </ns1:primary_warehouse>
              <ns1:shipping>
                <ns1:subtotal>12</ns1:subtotal>
                <ns1:description>Sweden</ns1:description>
                <ns1:key>eur</ns1:key>
              </ns1:shipping>
              <ns1:payments>
                <ns1:name>dibs-window</ns1:name>
                <ns1:type>cc</ns1:type>
                <ns1:total>0</ns1:total>
                <ns1:status>incomplete</ns1:status>
                <ns1:method>test</ns1:method>
                <ns1:payment>
                  <ns1:type>auth</ns1:type>
                  <ns1:value>1135</ns1:value>
                  <ns1:created>2019-03-27T12:52:20+01:00</ns1:created>
                  <ns1:transaction>2404544843</ns1:transaction>
                </ns1:payment>
              </ns1:payments>
              <ns1:products>
                <ns1:product>
                  <ns1:id>PWC</ns1:id>
                  <ns1:tax>25.000</ns1:tax>
                  <ns1:sku/>
                  <ns1:origprice>1000.00</ns1:origprice>
                  <ns1:price>1000.00</ns1:price>
                  <ns1:discount>0</ns1:discount>
                  <ns1:qty>1</ns1:qty>
                  <ns1:subtotal>1000</ns1:subtotal>
                  <ns1:description>Plain wood chair</ns1:description>
                  <ns1:variation>
                    <ns1:id>PWC</ns1:id>
                    <ns1:description>Plain</ns1:description>
                  </ns1:variation>
                  <ns1:brand>
                    <ns1:id>Example</ns1:id>
                    <ns1:description>Example Brand</ns1:description>
                  </ns1:brand>
                  <ns1:sizes>
                    <ns1:size>
                      <ns1:id>OS</ns1:id>
                      <ns1:sku/>
                      <ns1:qty>1</ns1:qty>
                      <ns1:preorder>no</ns1:preorder>
                      <ns1:description/>
                      <ns1:orderitem>
                        <ns1:id>80</ns1:id>
                      </ns1:orderitem>
                      <ns1:warehouseitems>
                        <ns1:warehouse>
                          <ns1:id>OtherWarehouse</ns1:id>
                          <ns1:qty>1</ns1:qty>
                        </ns1:warehouse>
                      </ns1:warehouseitems>
                      <ns1:supplierorderitems/>
                    </ns1:size>
                  </ns1:sizes>
                  <ns1:comment/>
                </ns1:product>
                <ns1:product>
                  <ns1:id>T001</ns1:id>
                  <ns1:tax>25.000</ns1:tax>
                  <ns1:sku>TURTLE001</ns1:sku>
                  <ns1:origprice>123.00</ns1:origprice>
                  <ns1:price>123.00</ns1:price>
                  <ns1:discount>0</ns1:discount>
                  <ns1:qty>1</ns1:qty>
                  <ns1:subtotal>123</ns1:subtotal>
                  <ns1:description>Turtleneck sweater</ns1:description>
                  <ns1:variation>
                    <ns1:id>T001_RED</ns1:id>
                    <ns1:description>Red</ns1:description>
                  </ns1:variation>
                  <ns1:brand>
                    <ns1:id>Example</ns1:id>
                    <ns1:description>Example Brand</ns1:description>
                  </ns1:brand>
                  <ns1:sizes>
                    <ns1:size>
                      <ns1:id>S</ns1:id>
                      <ns1:sku>01</ns1:sku>
                      <ns1:qty>1</ns1:qty>
                      <ns1:preorder>no</ns1:preorder>
                      <ns1:description>Small</ns1:description>
                      <ns1:orderitem>
                        <ns1:id>81</ns1:id>
                      </ns1:orderitem>
                      <ns1:warehouseitems>
                        <ns1:warehouse>
                          <ns1:id>MainWarehouse</ns1:id>
                          <ns1:qty>1</ns1:qty>
                        </ns1:warehouse>
                      </ns1:warehouseitems>
                      <ns1:supplierorderitems/>
                    </ns1:size>
                  </ns1:sizes>
                  <ns1:comment/>
                </ns1:product>
              </ns1:products>
              <ns1:cancelled/>
              <ns1:shipments>
                <ns1:shipment>
                  <ns1:id>8</ns1:id>
                  <ns1:paid>no</ns1:paid>
                  <ns1:shipped>no</ns1:shipped>
                  <ns1:goodtogo>yes</ns1:goodtogo>
                  <ns1:appendix>1</ns1:appendix>
                  <ns1:shipmenttotal>1135.00</ns1:shipmenttotal>
                  <ns1:paidtotal>0.00</ns1:paidtotal>
                  <ns1:currency>EUR</ns1:currency>
                  <ns1:currencyrate>10.43100</ns1:currencyrate>
                  <ns1:basecurrency>SEK</ns1:basecurrency>
                  <ns1:created>2019-03-27T12:52:20+01:00</ns1:created>
                  <ns1:shippingaddress>
                    <ns1:firstname>Example</ns1:firstname>
                    <ns1:lastname>Person</ns1:lastname>
                    <ns1:address1>Teststreet 123</ns1:address1>
                    <ns1:address2/>
                    <ns1:city>Testcity</ns1:city>
                    <ns1:state/>
                    <ns1:zipcode>12345</ns1:zipcode>
                    <ns1:country>SE</ns1:country>
                    <ns1:email>someone@example.com</ns1:email>
                    <ns1:telephone>123456789</ns1:telephone>
                  </ns1:shippingaddress>
                  <ns1:carrierinformation>
                    <ns1:carrier/>
                    <ns1:service/>
                    <ns1:tracking/>
                    <ns1:packages>0</ns1:packages>
                  </ns1:carrierinformation>
                  <ns1:products>
                    <ns1:product>
                      <ns1:id>PWC</ns1:id>
                      <ns1:tax>25.000</ns1:tax>
                      <ns1:sku/>
                      <ns1:origprice>1000.00</ns1:origprice>
                      <ns1:price>1000.00</ns1:price>
                      <ns1:discount>0</ns1:discount>
                      <ns1:qty>1</ns1:qty>
                      <ns1:subtotal>1000</ns1:subtotal>
                      <ns1:description>Plain wood chair</ns1:description>
                      <ns1:variation>
                        <ns1:id>PWC</ns1:id>
                        <ns1:description>Plain</ns1:description>
                      </ns1:variation>
                      <ns1:brand>
                        <ns1:id>Example</ns1:id>
                        <ns1:description>Example Brand</ns1:description>
                      </ns1:brand>
                      <ns1:sizes>
                        <ns1:size>
                          <ns1:id>OS</ns1:id>
                          <ns1:sku/>
                          <ns1:qty>1</ns1:qty>
                          <ns1:preorder>no</ns1:preorder>
                          <ns1:description/>
                          <ns1:orderitem>
                            <ns1:id>80</ns1:id>
                          </ns1:orderitem>
                        </ns1:size>
                      </ns1:sizes>
                      <ns1:comment/>
                    </ns1:product>
                    <ns1:product>
                      <ns1:id>T001</ns1:id>
                      <ns1:tax>25.000</ns1:tax>
                      <ns1:sku>TURTLE001</ns1:sku>
                      <ns1:origprice>123.00</ns1:origprice>
                      <ns1:price>123.00</ns1:price>
                      <ns1:discount>0</ns1:discount>
                      <ns1:qty>1</ns1:qty>
                      <ns1:subtotal>123</ns1:subtotal>
                      <ns1:description>Turtleneck sweater</ns1:description>
                      <ns1:variation>
                        <ns1:id>T001_RED</ns1:id>
                        <ns1:description>Red</ns1:description>
                      </ns1:variation>
                      <ns1:brand>
                        <ns1:id>Example</ns1:id>
                        <ns1:description>Example Brand</ns1:description>
                      </ns1:brand>
                      <ns1:sizes>
                        <ns1:size>
                          <ns1:id>S</ns1:id>
                          <ns1:sku>01</ns1:sku>
                          <ns1:qty>1</ns1:qty>
                          <ns1:preorder>no</ns1:preorder>
                          <ns1:description>Small</ns1:description>
                          <ns1:orderitem>
                            <ns1:id>81</ns1:id>
                          </ns1:orderitem>
                        </ns1:size>
                      </ns1:sizes>
                      <ns1:comment/>
                    </ns1:product>
                  </ns1:products>
                  <ns1:refunds/>
                  <ns1:shipping>
                    <ns1:subtotal>12</ns1:subtotal>
                  </ns1:shipping>
                  <ns1:handling>
                    <ns1:subtotal>0.00</ns1:subtotal>
                  </ns1:handling>
                  <ns1:voucher>
                    <ns1:subtotal>0</ns1:subtotal>
                  </ns1:voucher>
                </ns1:shipment>
              </ns1:shipments>
              <ns1:carrierinformation>
                <ns1:carrier/>
                <ns1:service/>
                <ns1:account/>
                <ns1:taxid/>
              </ns1:carrierinformation>
              <ns1:customer>
                <ns1:id>20</ns1:id>
              </ns1:customer>
              <ns1:shippingaddress>
                <ns1:firstname>Example</ns1:firstname>
                <ns1:lastname>Person</ns1:lastname>
                <ns1:address1>Teststreet 123</ns1:address1>
                <ns1:address2/>
                <ns1:city>Testcity</ns1:city>
                <ns1:state/>
                <ns1:zipcode>12345</ns1:zipcode>
                <ns1:country>SE</ns1:country>
                <ns1:email>someone@example.com</ns1:email>
                <ns1:telephone>123456789</ns1:telephone>
              </ns1:shippingaddress>
              <ns1:billingaddress>
                <ns1:firstname>Example</ns1:firstname>
                <ns1:lastname>Person</ns1:lastname>
                <ns1:address1>Teststreet 123</ns1:address1>
                <ns1:address2/>
                <ns1:city>Testcity</ns1:city>
                <ns1:state/>
                <ns1:zipcode>12345</ns1:zipcode>
                <ns1:country>SE</ns1:country>
                <ns1:email>someone@example.com</ns1:email>
                <ns1:telephone>123456789</ns1:telephone>
              </ns1:billingaddress>
              <ns1:internalinformation/>
              <ns1:other/>
              <ns1:market>
                <ns1:id>Retail-Sweden</ns1:id>
                <ns1:description>Sweden</ns1:description>
              </ns1:market>
              <ns1:pricelist>
                <ns1:id>EUR-Retail</ns1:id>
                <ns1:description>Euro</ns1:description>
              </ns1:pricelist>
            </ns1:order>
          </ns1:data>
        </ns1:event>
      </ns1:events>
    </ns1:events_Get>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## Orders - Retail 2 - Event Done

[https://docs.centra.com/soap/index.php?op=events_Done](https://docs.centra.com/soap/index.php?op=events_Done)

This marks the event from the previous example as done. That event had ID 115. To illustrate how to mark multiple events as done at the same time, this example also sends event IDs 116 and 117.

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <events_Done xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <event>115</event>
      <event>116</event>
      <event>117</event>
    </events_Done>
  </soap:Body>
</soap:Envelope>
```

## Orders - Retail 3 - Lock Order

[https://docs.centra.com/soap/index.php?op=orders_Update](https://docs.centra.com/soap/index.php?op=orders_Update)

Locking an order prevents most changes to the order in the Centra admin. This is a good idea if your side takes ownership of the order data after you have imported the order.

This orders_Update will only change the `<locked>` status. Nothing else on the order is changed.

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <orders_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <orders>
        <order>
          <id>30</id>
          <type>retail</type>
          <store>1</store>
          <locked>yes</locked>
        </order>
      </orders>
    </orders_Update>
  </soap:Body>
</soap:Envelope>
```

## Orders - Retail 4 - Order Shipped

[https://docs.centra.com/soap/index.php?op=orders_Update](https://docs.centra.com/soap/index.php?op=orders_Update)

This marks the shipment of the order as shipped, and sets the tracking number for the shipment.

### Important: Capture

The `<capture>yes</capture>` will instruct Centra to capture the payment for the shipment with the payment provider, to actually withdraw the money from the customer’s account.

In most cases retail orders will only reserve the payment until the order is shipped. When the order is shipped the payment must be “captured”.

The `<capture>yes</capture>` will capture if it’s possible to perform a capture on this order. If its not possible or the order has already been captured it has no effect. This makes it possible for you to always send `<capture>yes</capture>` when a shipment has been shipped without having to figure out if this order has already been captured.

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <orders_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <orders>
        <order>
          <id>30</id>
          <type>retail</type>
          <store>1</store>
          <status>completed</status>
          <shipments>
            <shipment>
              <id>8</id>
              <shipped>yes</shipped>
              <capture>yes</capture>
              <carrierinformation>
                <carrier>UPS</carrier>
                <service>STANDARD</service>
                <tracking>1Z123123123123</tracking>
              </carrierinformation>
            </shipment>
          </shipments>
        </order>
      </orders>
    </orders_Update>
  </soap:Body>
</soap:Envelope>
```

## Orders - Wholesale 1 - Event By Markets

[https://docs.centra.com/soap/index.php?op=events_GetByMarkets](https://docs.centra.com/soap/index.php?op=events_GetByMarkets)

This example uses the events_GetByMarkets operation to get order events from a specific market. The response contains an order from the wholesale store, and examples after this one will update the order.

Compared to the retail order event example, this uses events_GetByMarkets only to show an example of how it’s used. You could use events_Get instead, and get order events from all markets.

Also compared to the retail order, this order does not have any shipment on it.

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <events_GetByMarkets xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <type>order</type>
      <markets>
        <market>
          <id>Wholesale-Market</id>
        </market>
      </markets>
    </events_GetByMarkets>
  </soap:Body>
</soap:Envelope>
```

### Response

```xml
<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:events_Get>
      <ns1:events>
        <ns1:event>
          <ns1:id>121</ns1:id>
          <ns1:type>order</ns1:type>
          <ns1:entry>25</ns1:entry>
          <ns1:mission>update</ns1:mission>
          <ns1:date>2019-03-27 13:45:44</ns1:date>
          <ns1:data>
            <ns1:order>
              <ns1:id>25</ns1:id>
              <ns1:type>wholesale</ns1:type>
              <ns1:store>2</ns1:store>
              <ns1:status>pending</ns1:status>
              <ns1:currency>USD</ns1:currency>
              <ns1:currencyrate>9.18707</ns1:currencyrate>
              <ns1:basecurrency>SEK</ns1:basecurrency>
              <ns1:created>2019-03-26T18:32:35+01:00</ns1:created>
              <ns1:internal>false</ns1:internal>
              <ns1:preferred_shipping_date/>
              <ns1:buyer>
                <ns1:id>12345_buyer1</ns1:id>
                <ns1:firstname>Frist</ns1:firstname>
                <ns1:lastname>Last</ns1:lastname>
                <ns1:email>first.last@example.com</ns1:email>
              </ns1:buyer>
              <ns1:salesrep/>
              <ns1:account>
                <ns1:id>12345</ns1:id>
              </ns1:account>
              <ns1:paymentterms>
                <ns1:id>30NET</ns1:id>
                <ns1:description>30 Days</ns1:description>
              </ns1:paymentterms>
              <ns1:shippingterms>
                <ns1:id>DDU</ns1:id>
                <ns1:description>Delivered Duty Unpaid</ns1:description>
              </ns1:shippingterms>
              <ns1:collection>
                <ns1:id>XMAS</ns1:id>
                <ns1:description>X-Mas</ns1:description>
              </ns1:collection>
              <ns1:primary_warehouse>
                <ns1:warehouse>
                  <ns1:id>CW</ns1:id>
                </ns1:warehouse>
              </ns1:primary_warehouse>
              <ns1:shipping>
                <ns1:subtotal>123</ns1:subtotal>
                <ns1:description>France</ns1:description>
                <ns1:key/>
              </ns1:shipping>
              <ns1:payments>
                <ns1:type>inv</ns1:type>
                <ns1:total>0</ns1:total>
                <ns1:status>incomplete</ns1:status>
                <ns1:method/>
              </ns1:payments>
              <ns1:products>
                <ns1:product>
                  <ns1:id>PWC</ns1:id>
                  <ns1:tax>0.000</ns1:tax>
                  <ns1:sku/>
                  <ns1:origprice>700.00</ns1:origprice>
                  <ns1:price>700.00</ns1:price>
                  <ns1:discount>0</ns1:discount>
                  <ns1:qty>2</ns1:qty>
                  <ns1:subtotal>1400</ns1:subtotal>
                  <ns1:description>Plain wood chair</ns1:description>
                  <ns1:variation>
                    <ns1:id>PWC</ns1:id>
                    <ns1:description>Plain</ns1:description>
                  </ns1:variation>
                  <ns1:brand>
                    <ns1:id>Example</ns1:id>
                    <ns1:description>Example Brand</ns1:description>
                  </ns1:brand>
                  <ns1:sizes>
                    <ns1:size>
                      <ns1:id>OS</ns1:id>
                      <ns1:sku/>
                      <ns1:qty>2</ns1:qty>
                      <ns1:preorder>no</ns1:preorder>
                      <ns1:description/>
                      <ns1:orderitem>
                        <ns1:id>67</ns1:id>
                      </ns1:orderitem>
                      <ns1:warehouseitems>
                        <ns1:warehouse>
                          <ns1:id>OtherWarehouse</ns1:id>
                          <ns1:qty>2</ns1:qty>
                        </ns1:warehouse>
                      </ns1:warehouseitems>
                      <ns1:supplierorderitems/>
                    </ns1:size>
                  </ns1:sizes>
                  <ns1:comment/>
                </ns1:product>
                <ns1:product>
                  <ns1:id>T001</ns1:id>
                  <ns1:tax>0.000</ns1:tax>
                  <ns1:sku>TURTLE001</ns1:sku>
                  <ns1:origprice>67.00</ns1:origprice>
                  <ns1:price>67.00</ns1:price>
                  <ns1:discount>0</ns1:discount>
                  <ns1:qty>3</ns1:qty>
                  <ns1:subtotal>201</ns1:subtotal>
                  <ns1:description>Turtleneck sweater</ns1:description>
                  <ns1:variation>
                    <ns1:id>T001_BLUE</ns1:id>
                    <ns1:description>Blue</ns1:description>
                  </ns1:variation>
                  <ns1:brand>
                    <ns1:id>Example</ns1:id>
                    <ns1:description>Example Brand</ns1:description>
                  </ns1:brand>
                  <ns1:sizes>
                    <ns1:size>
                      <ns1:id>S</ns1:id>
                      <ns1:sku>01</ns1:sku>
                      <ns1:qty>1</ns1:qty>
                      <ns1:preorder>no</ns1:preorder>
                      <ns1:description>Small</ns1:description>
                      <ns1:orderitem>
                        <ns1:id>68</ns1:id>
                      </ns1:orderitem>
                      <ns1:warehouseitems>
                        <ns1:warehouse>
                          <ns1:id>MainWarehouse</ns1:id>
                          <ns1:qty>1</ns1:qty>
                        </ns1:warehouse>
                      </ns1:warehouseitems>
                      <ns1:supplierorderitems/>
                    </ns1:size>
                    <ns1:size>
                      <ns1:id>M</ns1:id>
                      <ns1:sku>02</ns1:sku>
                      <ns1:qty>2</ns1:qty>
                      <ns1:preorder>no</ns1:preorder>
                      <ns1:description>Medium</ns1:description>
                      <ns1:orderitem>
                        <ns1:id>69</ns1:id>
                      </ns1:orderitem>
                      <ns1:warehouseitems>
                        <ns1:warehouse>
                          <ns1:id>MainWarehouse</ns1:id>
                          <ns1:qty>2</ns1:qty>
                        </ns1:warehouse>
                      </ns1:warehouseitems>
                      <ns1:supplierorderitems/>
                    </ns1:size>
                  </ns1:sizes>
                  <ns1:comment/>
                </ns1:product>
                <ns1:product>
                  <ns1:id>T001</ns1:id>
                  <ns1:tax>0.000</ns1:tax>
                  <ns1:sku>TURTLE001</ns1:sku>
                  <ns1:origprice>45.00</ns1:origprice>
                  <ns1:price>45.00</ns1:price>
                  <ns1:discount>0</ns1:discount>
                  <ns1:qty>7</ns1:qty>
                  <ns1:subtotal>315</ns1:subtotal>
                  <ns1:description>Turtleneck sweater</ns1:description>
                  <ns1:variation>
                    <ns1:id>T001_RED</ns1:id>
                    <ns1:description>Red</ns1:description>
                  </ns1:variation>
                  <ns1:brand>
                    <ns1:id>Example</ns1:id>
                    <ns1:description>Example Brand</ns1:description>
                  </ns1:brand>
                  <ns1:sizes>
                    <ns1:size>
                      <ns1:id>M</ns1:id>
                      <ns1:sku>02</ns1:sku>
                      <ns1:qty>3</ns1:qty>
                      <ns1:preorder>no</ns1:preorder>
                      <ns1:description>Medium</ns1:description>
                      <ns1:orderitem>
                        <ns1:id>70</ns1:id>
                      </ns1:orderitem>
                      <ns1:warehouseitems>
                        <ns1:warehouse>
                          <ns1:id>MainWarehouse</ns1:id>
                          <ns1:qty>3</ns1:qty>
                        </ns1:warehouse>
                      </ns1:warehouseitems>
                      <ns1:supplierorderitems/>
                    </ns1:size>
                    <ns1:size>
                      <ns1:id>L</ns1:id>
                      <ns1:sku>03</ns1:sku>
                      <ns1:qty>4</ns1:qty>
                      <ns1:preorder>no</ns1:preorder>
                      <ns1:description>Large</ns1:description>
                      <ns1:orderitem>
                        <ns1:id>71</ns1:id>
                      </ns1:orderitem>
                      <ns1:warehouseitems>
                        <ns1:warehouse>
                          <ns1:id>MainWarehouse</ns1:id>
                          <ns1:qty>4</ns1:qty>
                        </ns1:warehouse>
                      </ns1:warehouseitems>
                      <ns1:supplierorderitems/>
                    </ns1:size>
                  </ns1:sizes>
                  <ns1:comment/>
                </ns1:product>
              </ns1:products>
              <ns1:cancelled/>
              <ns1:shipments/>
              <ns1:carrierinformation>
                <ns1:carrier/>
                <ns1:service/>
                <ns1:account/>
                <ns1:taxid/>
              </ns1:carrierinformation>
              <ns1:shippingaddress>
                <ns1:company>Example Warehouse</ns1:company>
                <ns1:attn>Person name</ns1:attn>
                <ns1:address1>Street 1</ns1:address1>
                <ns1:address2>Suite 123</ns1:address2>
                <ns1:city>City</ns1:city>
                <ns1:state>State</ns1:state>
                <ns1:zipcode>12345</ns1:zipcode>
                <ns1:country>FR</ns1:country>
                <ns1:email>info@example.com</ns1:email>
                <ns1:telephone>123 456 789</ns1:telephone>
                <ns1:fax/>
              </ns1:shippingaddress>
              <ns1:billingaddress>
                <ns1:company>Example Billing</ns1:company>
                <ns1:attn>Person name</ns1:attn>
                <ns1:address1>Street 1</ns1:address1>
                <ns1:address2>Suite 123</ns1:address2>
                <ns1:city>City</ns1:city>
                <ns1:state/>
                <ns1:zipcode>12345</ns1:zipcode>
                <ns1:country>SE</ns1:country>
                <ns1:email>info@example.com</ns1:email>
                <ns1:telephone>123 456 789</ns1:telephone>
                <ns1:fax/>
              </ns1:billingaddress>
              <ns1:internalinformation/>
              <ns1:other>The buyer can leave a message or special instructions here.</ns1:other>
              <ns1:ponumber>Example1</ns1:ponumber>
              <ns1:market>
                <ns1:id>Wholesale-Market</ns1:id>
                <ns1:description>Global</ns1:description>
              </ns1:market>
              <ns1:pricelist>
                <ns1:id>USD-Wholesale</ns1:id>
                <ns1:description>US Dollar</ns1:description>
              </ns1:pricelist>
            </ns1:order>
          </ns1:data>
        </ns1:event>
      </ns1:events>
    </ns1:events_Get>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## Orders - Wholesale 2 - Event Done

[https://docs.centra.com/soap/index.php?op=events_Done](https://docs.centra.com/soap/index.php?op=events_Done)

This is exactly like the previous example for the retail order.

### Requests

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <events_Done xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <event>121</event>
    </events_Done>
  </soap:Body>
</soap:Envelope>
```

## Orders - Wholesale 3 - Confirm And Lock Order

[https://docs.centra.com/soap/index.php?op=orders_Update](https://docs.centra.com/soap/index.php?op=orders_Update)

Changes the order status from “pending” to “confirmed”, and locks the order so it cannot be modified in the Centra admin.

For wholesale orders it is common that the order has status “pending” when it is placed and then has to be confirmed (accepted) by someone working in Centra or on your side. If orders are confirmed in Centra, you should not import the order when it has status “pending”. Just mark that event as done. You will get a new event when it has status “confirmed”. In this example someone has confirmed the order on your side and this update marks it as confirmed in Centra.

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <orders_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <orders>
        <order>
          <id>25</id>
          <type>wholesale</type>
          <store>2</store>
          <status>confirmed</status>
          <locked>yes</locked>
        </order>
      </orders>
    </orders_Update>
  </soap:Body>
</soap:Envelope>
```

## Orders - Wholesale 4 - Cancel Item

[https://docs.centra.com/soap/index.php?op=orders_Update](https://docs.centra.com/soap/index.php?op=orders_Update)

Modifies the order by cancelling a single size of a product from the order. I will cancel 1 of the 4 red sweaters in size L.

Notice the `<orderitem>` on the `<size>`. This is an unique ID for that row on the order, and you should always use it to modify the order. It is possible to have the same size twice or more in the same order, for example if one had a discounted price. The `<orderitem>` is always unique within the order, the `<product>` or `<variation>` or `<size>` is not.

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <orders_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <orders>
        <order>
          <id>25</id>
          <type>wholesale</type>
          <store>2</store>
          <cancelled>
            <product>
              <id>T001</id>
              <variation>
                <id>T001_RED</id>
              </variation>
              <sizes>
                <size>
                  <id>L</id>
                  <qty>1</qty>
                  <orderitem>
                    <id>71</id>
                  </orderitem>
                  <supplierorderitems/>
                </size>
              </sizes>
            </product>
          </cancelled>
        </order>
      </orders>
    </orders_Update>
  </soap:Body>
</soap:Envelope>
```

## Orders - Wholesale 5 - Shipment 1

[https://docs.centra.com/soap/index.php?op=orders_Update](https://docs.centra.com/soap/index.php?op=orders_Update)

Creates a shipment for some of the items in the order.

The `<shipping>` contains the shipping price, copied from the order event.

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <orders_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <orders>
        <order>
          <id>25</id>
          <type>wholesale</type>
          <store>2</store>
          <shipments>
            <shipment>
              <id>shipment-25-1</id>
              <shipped>no</shipped>
              <goodtogo>yes</goodtogo>
              <appendix>1</appendix>
              <products>
                <product>
                  <id>T001</id>
                  <variation>
                    <id>T001_BLUE</id>
                  </variation>
                  <sizes>
                    <size>
                      <id>S</id>
                      <qty>1</qty>
                      <orderitem>
                        <id>68</id>
                      </orderitem>
                    </size>
                    <size>
                      <id>M</id>
                      <qty>1</qty>
                      <orderitem>
                        <id>69</id>
                      </orderitem>
                    </size>
                  </sizes>
                </product>
                <product>
                  <id>PWC</id>
                  <variation>
                    <id>PWC</id>
                  </variation>
                  <sizes>
                    <size>
                      <id>OS</id>
                      <qty>2</qty>
                      <orderitem>
                        <id>67</id>
                      </orderitem>
                    </size>
                  </sizes>
                </product>
              </products>
              <shipping>
                <subtotal>123</subtotal>
              </shipping>
            </shipment>
          </shipments>
        </order>
      </orders>
    </orders_Update>
  </soap:Body>
</soap:Envelope>
```

## Orders - Wholesale 6 - Shipment 2

[https://docs.centra.com/soap/index.php?op=orders_Update](https://docs.centra.com/soap/index.php?op=orders_Update)

Creates a shipment for the remaining items on the order.

Compared to the previous example, this one does not specify `<shipping>` so it will have 0 shipping cost.

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <orders_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <orders>
        <order>
          <id>25</id>
          <type>wholesale</type>
          <store>2</store>
          <shipments>
            <shipment>
              <id>shipment-25-2</id>
              <shipped>no</shipped>
              <goodtogo>yes</goodtogo>
              <appendix>2</appendix>
              <products>
                <product>
                  <id>T001</id>
                  <variation>
                    <id>T001_BLUE</id>
                  </variation>
                  <sizes>
                    <size>
                      <id>M</id>
                      <qty>1</qty>
                      <orderitem>
                        <id>69</id>
                      </orderitem>
                    </size>
                  </sizes>
                </product>
                <product>
                  <id>T001</id>
                  <variation>
                    <id>T001_RED</id>
                  </variation>
                  <sizes>
                    <size>
                      <id>M</id>
                      <qty>3</qty>
                      <orderitem>
                        <id>70</id>
                      </orderitem>
                    </size>
                    <size>
                      <id>L</id>
                      <qty>3</qty>
                      <orderitem>
                        <id>71</id>
                      </orderitem>
                    </size>
                  </sizes>
                </product>
              </products>
              <shipping>
                <subtotal>0</subtotal>
              </shipping>
            </shipment>
          </shipments>
        </order>
      </orders>
    </orders_Update>
  </soap:Body>
</soap:Envelope>
```

## Orders - Wholesale 7 - Shipped

[https://docs.centra.com/soap/index.php?op=orders_Update](https://docs.centra.com/soap/index.php?op=orders_Update)

Marks both shipments as shipped.

Notice that the order is not seen as completed in Centra at this stage. It is seen as completed when it has been shipped and paid for.

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <orders_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <orders>
        <order>
          <id>25</id>
          <type>wholesale</type>
          <store>2</store>
          <shipments>
            <shipment>
              <id>shipment-25-1</id>
              <shipped>yes</shipped>
              <carrierinformation>
                <carrier>DHL</carrier>
                <service>EXPRESS</service>
                <tracking>876543210</tracking>
              </carrierinformation>
            </shipment>
            <shipment>
              <id>shipment-25-2</id>
              <shipped>yes</shipped>
              <carrierinformation>
                <carrier>DHL</carrier>
                <service>EXPRESS</service>
                <tracking>987654321</tracking>
              </carrierinformation>
            </shipment>
          </shipments>
        </order>
      </orders>
    </orders_Update>
  </soap:Body>
</soap:Envelope>
```
