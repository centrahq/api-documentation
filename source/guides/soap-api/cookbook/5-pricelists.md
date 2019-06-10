# Pricelists

[https://docs.centra.com/soap/index.php?op=pricelists_Update](https://docs.centra.com/soap/index.php?op=pricelists_Update)

Update or create pricelists. A pricelist contains prices for products in a specific currency.

This example creates two pricelists. One for the retail store and one for the wholesale store. You can have multiple pricelists in each store, and even multiple pricelists in the same store with the same currency.

Prices in Centra can be set at the product or variant level, but not on the size level.

## Information you need

- IDs of the stores (1 and 2 in the example below). Contact Centra directly to get provided with the correct IDs. 
- Currencies in Centra matching the `<currency>` you send in the XML. Currencies are configured manually in Centra.

## Preconditions

- Products must exist in Centra. See the product examples.

## Fields

On the `<pricelist>` level:

- `<id>` is the unique ID of the pricelist
- `<description>` is the name visible in the Centra admin
- `<store>` and `<type>` connects the pricelist to a store
- `<currency>` is the name of the currency in Centra.

On the `<item>` level

- `<id>` is the product ID (See the product examples)

On the `<variation>` level

- `<id>` is the variation ID (See the product examples)

Notice that the wholesale prices have a `<priceb>` field. This is the recommended retail price. It is optional, and only used for wholesale.

Also note that the T001 product has prices on the variant level (the blue one is more expensive than the red one). The PWC product has prices on the product level, so if it had multiple variants they would have the same price.


## Request

```
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
