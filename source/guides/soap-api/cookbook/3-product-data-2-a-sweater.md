# Product Data 2 - A Sweater

[https://docs.centra.com/soap/index.php?op=products_Update](https://docs.centra.com/soap/index.php?op=products_Update)

This example creates or updates a product, a turtleneck sweater. It demonstrates Centra's product structure of product, variants and sizes. The product red and blue variants, and each variant is available in sizes S, M and L.

On the `<product>` level:

- `<id>` must be unique across all products
- `<status>` is the products status. It can be `inactive`, `active` or `cancelled`. Only `active` products are shown in a Centra store.
- `<sku>` see below
- `<description>` is the product's name that people see in the Centra admin.
- `<folder>` is a way to organize products in the Centra admin (do not use an `<id>` for the folder). This is optional.
- `<brand>` is the product's brand. The `<id>` is used only in the API, the `<description>` is the brand name displayed in the Admin and in the Centra stores.
- `<collection>` is the collection that this product is a part of. For example "Spring 2019". This is optional.

On the `<variation>` level:

- `<id>` __must be unique across *all* variants__, not just the variants connected to this product
- `<stockid>` use the same value as `<id>`
- `<sizetable>` this is the sizetable that the variant has, and this determines what sizes it can have.
- The other fields have the same functions as those on the product level


On the `<size>` level:

- `<id>` here is for a size id, connected to the sizetable.
- `<ean>` is the EAN code (or GTIN, UPC, barcode). Centra does not require this field itself, but if Centra connects to other systems it might be required.

The `<sku>` field is not required by Centra itself, but if Centra connects to other systems it might be required. The `<product>`, `<variation>` and `<size>` each contain a `<sku>` field. To form the SKU of a size, you concatenate the `<sku>` from the product, variation and size. In the example, the full SKU for the red sweater in size S is TURTLE001RED01.


## Preconditions

- Sizetables must have been created in Centra

## Request

```
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

## Response

```
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
