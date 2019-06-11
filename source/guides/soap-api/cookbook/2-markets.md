# Markets

[https://docs.centra.com/soap/index.php?op=markets_Update](https://docs.centra.com/soap/index.php?op=markets_Update)

Creates new, or updates existing markets in Centra. 

If Centra already has markets setup, you shouldn't create new ones. Contact us directly so we can setup the existing markets in the ID conversion table instead.

As long as you are not working against a Centra instance that is used in production, this operation is simple and might be a good one to start with.

The `<id>` you send to Centra will be used to refer to that market in the future. For example; an order placed in the market `Retail-Global` will have that market `<id>` on it when you fetch the order data from Centra. It is only used for the integration between the systems, so it does not need to be readable. The ID `<id>` is added to the ID conversion table.

The `<description>` is the name of the market in Centra's admin interface. So this should be something people understand.

## Information you need

- IDs of the stores (1 and 2 in the example below) for the `<store>`, and if they are retail or wholesale stores for the `<type>`. Ask us to provide this information for you.

## Request

```
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
