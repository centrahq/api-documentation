# Product Data 3 - A Chair

[https://docs.centra.com/soap/index.php?op=products_Update](https://docs.centra.com/soap/index.php?op=products_Update)

This example creates or updates a product. We will be using a chair for this example. The product does not have different variants or sizes. To fit Centra's product structure, it is created with a single variant and a single size.

Notice that this example does not send a `<sku>` or `<ean>` as Centra does not require it. If your system has SKU and EAN codes, please send them anyway. This is just an example to illustrate that they are not required for the integration to work.

## Information you need

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
