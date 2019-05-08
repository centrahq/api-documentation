# Product Data 1 - Sizetables

[https://docs.centra.com/soap/index.php?op=sizes_Update](https://docs.centra.com/soap/index.php?op=sizes_Update)

Before you can send product data to Centra you need to have sizetables in place.

This example creates two sizetables:

- One with sizes Small, Medium and Large. This will be used for a sweater in the next example.
- One with a single unnamed size. This will be used for a chair later, a product that does not have different sizes. 

Notice that a sizetable contains one or more sizes (the SML size table contains the sizes S, M, and L) but in the XML request this is the other way around: `<sizetable>` is inside the `<size>`.

On the `<size>` level, the `<id>` must be unique within that sizetable.

On the `<sizetable>` level, the `<id>` must be unique for all sizetables.

Notice that the size with `<id>` OS has a blank `<description/>`. This is useful for products that do not have different sizes. The size is never mentioned in the webshop or wholesale showroom.

## Important

You cannot change a sizetable once it's been created. This is because products are linked to the sizes in the sizetable, and this in turn connects to stock levels for the proucts and orders placed for these products.

## Request

```
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

## Responses

The first time you send these sizetables, you will get some notices that new sizes are added.

```
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
