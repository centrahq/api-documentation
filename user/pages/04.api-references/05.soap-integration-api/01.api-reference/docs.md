---
title: SOAP API reference
altTitle: API reference
excerpt: Click here to see the details of all available SOAP API calls, and learn how it's used to manipulate products, customers, invoices, warehouses, orders and more.
taxonomy:
  category: docs
---

The following operations are supported. For more information, please see the [Web Service Definition](https://demo1337.centraqa.com/ams/system/service/module/soap/api?wsdl).

Each operation contains a sample SOAP request and response. The `placeholders` shown need to be replaced with actual values.

## accounts_Update

Update/insert the specified accounts.

> Parameters: `accounts`: Array of `account` objects.

### Request

```xml
POST /ams/system/service/module/soap/api HTTP/1.1
Host: demo1337.centraqa.com
Connection: Keep-Alive
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://www.centra.com/webservices/Accounts_Update"

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:accounts_Update>
      <ns1:login>
        <ns1:username>demo</ns1:username>
        <ns1:password>demo</ns1:password>
      </ns1:login>
      <ns1:accounts>
        <ns1:account>
          <ns1:id>string</ns1:id>
          <ns1:type>string</ns1:type>
          <ns1:status>string</ns1:status>
          <ns1:description>string</ns1:description>
          <ns1:other>string</ns1:other>
          <ns1:discount>string</ns1:discount>
          <ns1:market>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:market>
          <ns1:pricelist>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:pricelist>
          <ns1:internalinformation>string</ns1:internalinformation>
          <ns1:creditlimit>string</ns1:creditlimit>
          <ns1:salesrep>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:salesrep>
          <ns1:paymentterms>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:paymentterms>
          <ns1:shippingterms>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:shippingterms>
          <ns1:accountaddress>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
            <ns1:company>string</ns1:company>
            <ns1:attn>string</ns1:attn>
            <ns1:firstname>string</ns1:firstname>
            <ns1:lastname>string</ns1:lastname>
            <ns1:address1>string</ns1:address1>
            <ns1:address2>string</ns1:address2>
            <ns1:city>string</ns1:city>
            <ns1:state>string</ns1:state>
            <ns1:zipcode>string</ns1:zipcode>
            <ns1:country>string</ns1:country>
            <ns1:email>string</ns1:email>
            <ns1:telephone>string</ns1:telephone>
            <ns1:fax>string</ns1:fax>
            <ns1:vat>string</ns1:vat>
            <ns1:url>string</ns1:url>
            <ns1:companyregistrationid>string</ns1:companyregistrationid>
          </ns1:accountaddress>
          <ns1:shippingaddress>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
            <ns1:company>string</ns1:company>
            <ns1:attn>string</ns1:attn>
            <ns1:firstname>string</ns1:firstname>
            <ns1:lastname>string</ns1:lastname>
            <ns1:address1>string</ns1:address1>
            <ns1:address2>string</ns1:address2>
            <ns1:city>string</ns1:city>
            <ns1:state>string</ns1:state>
            <ns1:zipcode>string</ns1:zipcode>
            <ns1:country>string</ns1:country>
            <ns1:email>string</ns1:email>
            <ns1:telephone>string</ns1:telephone>
            <ns1:fax>string</ns1:fax>
            <ns1:vat>string</ns1:vat>
            <ns1:url>string</ns1:url>
            <ns1:companyregistrationid>string</ns1:companyregistrationid>
          </ns1:shippingaddress>
          <ns1:invoiceaddress>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
            <ns1:company>string</ns1:company>
            <ns1:attn>string</ns1:attn>
            <ns1:firstname>string</ns1:firstname>
            <ns1:lastname>string</ns1:lastname>
            <ns1:address1>string</ns1:address1>
            <ns1:address2>string</ns1:address2>
            <ns1:city>string</ns1:city>
            <ns1:state>string</ns1:state>
            <ns1:zipcode>string</ns1:zipcode>
            <ns1:country>string</ns1:country>
            <ns1:email>string</ns1:email>
            <ns1:telephone>string</ns1:telephone>
            <ns1:fax>string</ns1:fax>
            <ns1:vat>string</ns1:vat>
            <ns1:url>string</ns1:url>
            <ns1:companyregistrationid>string</ns1:companyregistrationid>
          </ns1:invoiceaddress>
          <ns1:carrierinformation>
            <ns1:carrier>string</ns1:carrier>
            <ns1:service>string</ns1:service>
            <ns1:account>string</ns1:account>
            <ns1:taxid>string</ns1:taxid>
            <ns1:tracking>string</ns1:tracking>
            <ns1:packages>int</ns1:packages>
          </ns1:carrierinformation>
          <ns1:buyers>
            <ns1:buyer>
              <ns1:id>string</ns1:id>
              <ns1:store>int</ns1:store>
              <ns1:status>string</ns1:status>
              <ns1:firstname>string</ns1:firstname>
              <ns1:lastname>string</ns1:lastname>
              <ns1:address1>string</ns1:address1>
              <ns1:address2>string</ns1:address2>
              <ns1:city>string</ns1:city>
              <ns1:state>string</ns1:state>
              <ns1:zipcode>string</ns1:zipcode>
              <ns1:country>string</ns1:country>
              <ns1:email>string</ns1:email>
              <ns1:telephone>string</ns1:telephone>
              <ns1:fax>string</ns1:fax>
              <ns1:market>
                <ns1:id>string</ns1:id>
                <ns1:description>string</ns1:description>
              </ns1:market>
              <ns1:pricelist>
                <ns1:id>string</ns1:id>
                <ns1:description>string</ns1:description>
              </ns1:pricelist>
              <ns1:password>string</ns1:password>
            </ns1:buyer>
          </ns1:buyers>
          <ns1:addresses>
            <ns1:address>
              <ns1:id>string</ns1:id>
              <ns1:description>string</ns1:description>
              <ns1:company>string</ns1:company>
              <ns1:attn>string</ns1:attn>
              <ns1:firstname>string</ns1:firstname>
              <ns1:lastname>string</ns1:lastname>
              <ns1:address1>string</ns1:address1>
              <ns1:address2>string</ns1:address2>
              <ns1:city>string</ns1:city>
              <ns1:state>string</ns1:state>
              <ns1:zipcode>string</ns1:zipcode>
              <ns1:country>string</ns1:country>
              <ns1:email>string</ns1:email>
              <ns1:telephone>string</ns1:telephone>
              <ns1:fax>string</ns1:fax>
              <ns1:vat>string</ns1:vat>
              <ns1:url>string</ns1:url>
              <ns1:companyregistrationid>string</ns1:companyregistrationid>
            </ns1:address>
          </ns1:addresses>
          <ns1:additionals>
            <ns1:additional>
              <ns1:key>string</ns1:key>
              <ns1:value>string</ns1:value>
            </ns1:additional>
          </ns1:additionals>
        </ns1:account>
      </ns1:accounts>
    </ns1:accounts_Update>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

### Response

```xml
HTTP/1.1 200 OK
Server: nginx
Date: Mon, 14 Oct 2019 06:59:25 GMT
Content-Type: text/xml; charset=utf-8
Connection: keep-alive
X-Centra-Request-ID: 5f3cf4d8306053b5eb9acef48c3e4fe2
X-Correlation-ID: centra_5f3cf4d8306053b5eb9acef48c3e4fe2
Content-Security-Policy-Report-Only: default-src 'self'; style-src 'self' 'unsafe-inline' https://www.gstatic.com/charts/; img-src 'self' https://demo1337.centracdn.net/ https://www.google-analytics.com/; connect-src 'self' https://www.google-analytics.com/analytics.js; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.googletagmanager.com/gtm.js https://www.google-analytics.com/analytics.js https://www.gstatic.com/charts/; object-src 'none'; report-uri https://centra.report-uri.com/r/d/csp/reportOnly;

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Body>
    <accountsUpdateResponse>OK</accountsUpdateResponse>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## customers_Update

Update/insert the specified customers.

> Parameters: `customers`: Array of `customer` objects.

### Request

```xml
POST /ams/system/service/module/soap/api HTTP/1.1
Host: demo1337.centraqa.com
Connection: Keep-Alive
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://www.centra.com/webservices/Customers_Update"

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:customers_Update>
      <ns1:login>
        <ns1:username>demo</ns1:username>
        <ns1:password>demo</ns1:password>
      </ns1:login>
      <ns1:customers>
        <ns1:customer>
          <ns1:id>string</ns1:id>
          <ns1:store>int</ns1:store>
          <ns1:type>string</ns1:type>
          <ns1:status>string</ns1:status>
          <ns1:firstname>string</ns1:firstname>
          <ns1:lastname>string</ns1:lastname>
          <ns1:address1>string</ns1:address1>
          <ns1:address2>string</ns1:address2>
          <ns1:city>string</ns1:city>
          <ns1:state>string</ns1:state>
          <ns1:zipcode>string</ns1:zipcode>
          <ns1:country>string</ns1:country>
          <ns1:email>string</ns1:email>
          <ns1:telephone>string</ns1:telephone>
        </ns1:customer>
      </ns1:customers>
    </ns1:customers_Update>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

### Response

```xml
HTTP/1.1 200 OK
Server: nginx
Date: Mon, 14 Oct 2019 07:02:38 GMT
Content-Type: text/xml; charset=utf-8
Connection: keep-alive
X-Centra-Request-ID: b475ddc1816f59e6eb6f16bb42a4ebe8
X-Correlation-ID: centra_b475ddc1816f59e6eb6f16bb42a4ebe8
Content-Security-Policy-Report-Only: default-src 'self'; style-src 'self' 'unsafe-inline' https://www.gstatic.com/charts/; img-src 'self' https://demo1337.centracdn.net/ https://www.google-analytics.com/; connect-src 'self' https://www.google-analytics.com/analytics.js; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.googletagmanager.com/gtm.js https://www.google-analytics.com/analytics.js https://www.gstatic.com/charts/; object-src 'none'; report-uri https://centra.report-uri.com/r/d/csp/reportOnly;

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Body>
    <customersUpdateResponse>OK</customersUpdateResponse>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## deliverywindows_Update

Update/insert the specified delivery windows.

> Parameters: `variations`: Array of `variation` objects.

### Request

```xml
POST /ams/system/service/module/soap/api HTTP/1.1
Host: demo1337.centraqa.com
Connection: Keep-Alive
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://www.centra.com/webservices/Deliverywindows_Update"

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:deliverywindows_Update>
      <ns1:login>
        <ns1:username>demo</ns1:username>
        <ns1:password>demo</ns1:password>
      </ns1:login>
      <ns1:deliverywindows>
        <ns1:deliverywindow>
          <ns1:id>string</ns1:id>
          <ns1:status>string</ns1:status>
          <ns1:description>string</ns1:description>
          <ns1:startdate>string</ns1:startdate>
          <ns1:stopdate>string</ns1:stopdate>
          <ns1:atonce>boolean</ns1:atonce>
          <ns1:variations>
            <ns1:variation>
              <ns1:id>string</ns1:id>
              <ns1:type>string</ns1:type>
              <ns1:productlimit>int</ns1:productlimit>
              <ns1:variationlimit>int</ns1:variationlimit>
            </ns1:variation>
          </ns1:variations>
          <ns1:variationsremove>
            <ns1:variation>
              <ns1:id>string</ns1:id>
              <ns1:type>string</ns1:type>
              <ns1:productlimit>int</ns1:productlimit>
              <ns1:variationlimit>int</ns1:variationlimit>
            </ns1:variation>
          </ns1:variationsremove>
        </ns1:deliverywindow>
      </ns1:deliverywindows>
    </ns1:deliverywindows_Update>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

### Response

```xml
HTTP/1.1 200 OK
Server: nginx
Date: Mon, 14 Oct 2019 07:02:39 GMT
Content-Type: text/xml; charset=utf-8
Connection: keep-alive
X-Centra-Request-ID: 0513e225daaa9e4715a1d42eaad44d06
X-Correlation-ID: centra_0513e225daaa9e4715a1d42eaad44d06
Content-Security-Policy-Report-Only: default-src 'self'; style-src 'self' 'unsafe-inline' https://www.gstatic.com/charts/; img-src 'self' https://demo1337.centracdn.net/ https://www.google-analytics.com/; connect-src 'self' https://www.google-analytics.com/analytics.js; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.googletagmanager.com/gtm.js https://www.google-analytics.com/analytics.js https://www.gstatic.com/charts/; object-src 'none'; report-uri https://centra.report-uri.com/r/d/csp/reportOnly;

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Body>
    <deliverywindowsUpdateResponse>OK</deliverywindowsUpdateResponse>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## events_Done

Update the events so they not appear in event list again.

> Parameters: `events`: Array of `event` objects, only containing the event-numbers of the fetched events.

### Request

```xml
POST /ams/system/service/module/soap/api HTTP/1.1
Host: demo1337.centraqa.com
Connection: Keep-Alive
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://www.centra.com/webservices/Events_Done"

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:events_Done>
      <ns1:login>
        <ns1:username>demo</ns1:username>
        <ns1:password>demo</ns1:password>
      </ns1:login>
      <ns1:event>string</ns1:event>
    </ns1:events_Done>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

### Response

```xml
HTTP/1.1 200 OK
Server: nginx
Date: Mon, 14 Oct 2019 07:02:40 GMT
Content-Type: text/xml; charset=utf-8
Connection: keep-alive
X-Centra-Request-ID: 853fd13507077ee282bbdb4316469032
X-Correlation-ID: centra_853fd13507077ee282bbdb4316469032
Content-Security-Policy-Report-Only: default-src 'self'; style-src 'self' 'unsafe-inline' https://www.gstatic.com/charts/; img-src 'self' https://demo1337.centracdn.net/ https://www.google-analytics.com/; connect-src 'self' https://www.google-analytics.com/analytics.js; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.googletagmanager.com/gtm.js https://www.google-analytics.com/analytics.js https://www.gstatic.com/charts/; object-src 'none'; report-uri https://centra.report-uri.com/r/d/csp/reportOnly;

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Body>
    <eventsDoneResponse>OK</eventsDoneResponse>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## events_Get

Get new events by specific section. Will return the events in ascending order, oldest first.

> Parameters: `type`: Allowed types are: `all`, `account`, `customer`, `invoice`, `market`, `order`, `paymentterm`, `pricelist`, `salesrep`, `shippingterm`, `size`, `warehouse`.

### Request

```xml
POST /ams/system/service/module/soap/api HTTP/1.1
Host: demo1337.centraqa.com
Connection: Keep-Alive
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://www.centra.com/webservices/Events_Get"

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:events_GetRequest>
      <ns1:login>
        <ns1:username>demo</ns1:username>
        <ns1:password>demo</ns1:password>
      </ns1:login>
      <ns1:type>string</ns1:type>
    </ns1:events_GetRequest>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

### Response

```xml
HTTP/1.1 200 OK
Server: nginx
Date: Mon, 14 Oct 2019 07:02:49 GMT
Content-Type: text/xml; charset=utf-8
Connection: keep-alive
X-Centra-Request-ID: 45089d50f30e623d465e931a8bf9c5a4
X-Correlation-ID: centra_45089d50f30e623d465e931a8bf9c5a4
Content-Security-Policy-Report-Only: default-src 'self'; style-src 'self' 'unsafe-inline' https://www.gstatic.com/charts/; img-src 'self' https://demo1337.centracdn.net/ https://www.google-analytics.com/; connect-src 'self' https://www.google-analytics.com/analytics.js; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.googletagmanager.com/gtm.js https://www.google-analytics.com/analytics.js https://www.gstatic.com/charts/; object-src 'none'; report-uri https://centra.report-uri.com/r/d/csp/reportOnly;

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:events_Get>
      <ns1:events>
        <ns1:event>
          <ns1:id>string</ns1:id>
          <ns1:type>string</ns1:type>
          <ns1:entry>string</ns1:entry>
          <ns1:mission>update or delete</ns1:mission>
          <ns1:date>2019-10-14T09:02:49+02:00</ns1:date>
          <ns1:data>
            <ns1:account/>
            <ns1:customer/>
            <ns1:invoice/>
            <ns1:market/>
            <ns1:order/>
            <ns1:pricelist/>
            <ns1:salesrep/>
            <ns1:size/>
            <ns1:warehouse/>
            <ns1:stock/>
          </ns1:data>
        </ns1:event>
      </ns1:events>
    </ns1:events_Get>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## events_GetByMarkets

Get new events by specific section. Will return the events in ascending order, oldest first.

> Parameters: `type`: Allowed types are: `all`, `account`, `customer`, `invoice`, `market`, `order`, `paymentterm`, `pricelist`, `salesrep`, `shippingterm`, `size`, `warehouse`.

### Request

```xml
POST /ams/system/service/module/soap/api HTTP/1.1
Host: demo1337.centraqa.com
Connection: Keep-Alive
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://www.centra.com/webservices/Events_GetByMarkets"

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:events_GetByMarkets>
      <ns1:login>
        <ns1:username>demo</ns1:username>
        <ns1:password>demo</ns1:password>
      </ns1:login>
      <ns1:type>string</ns1:type>
      <ns1:markets>
        <ns1:market>
          <ns1:id>string</ns1:id>
          <ns1:description>string</ns1:description>
        </ns1:market>
      </ns1:markets>
    </ns1:events_GetByMarkets>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

### Response

```xml
HTTP/1.1 200 OK
Server: nginx
Date: Mon, 14 Oct 2019 07:02:50 GMT
Content-Type: text/xml; charset=utf-8
Connection: keep-alive
X-Centra-Request-ID: 739277ca4ba203a5451653fe41adb3f5
X-Correlation-ID: centra_739277ca4ba203a5451653fe41adb3f5
Content-Security-Policy-Report-Only: default-src 'self'; style-src 'self' 'unsafe-inline' https://www.gstatic.com/charts/; img-src 'self' https://demo1337.centracdn.net/ https://www.google-analytics.com/; connect-src 'self' https://www.google-analytics.com/analytics.js; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.googletagmanager.com/gtm.js https://www.google-analytics.com/analytics.js https://www.gstatic.com/charts/; object-src 'none'; report-uri https://centra.report-uri.com/r/d/csp/reportOnly;

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:events_Get>
      <ns1:events>
        <ns1:event>
          <ns1:id>string</ns1:id>
          <ns1:type>string</ns1:type>
          <ns1:entry>string</ns1:entry>
          <ns1:mission>update or delete</ns1:mission>
          <ns1:date>2019-10-14T09:02:50+02:00</ns1:date>
          <ns1:data>
            <ns1:account/>
            <ns1:customer/>
            <ns1:invoice/>
            <ns1:market/>
            <ns1:order/>
            <ns1:pricelist/>
            <ns1:salesrep/>
            <ns1:size/>
            <ns1:warehouse/>
            <ns1:stock/>
          </ns1:data>
        </ns1:event>
      </ns1:events>
    </ns1:events_Get>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## invoices_Update

Update/insert the specified invoices.

> Parameters: `invoices`: Array of `invoice` objects.

### Request

```xml
POST /ams/system/service/module/soap/api HTTP/1.1
Host: demo1337.centraqa.com
Connection: Keep-Alive
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://www.centra.com/webservices/Invoices_Update"

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:invoices_Update>
      <ns1:login>
        <ns1:username>demo</ns1:username>
        <ns1:password>demo</ns1:password>
      </ns1:login>
      <ns1:invoices>
        <ns1:invoice>
          <ns1:id>string</ns1:id>
          <ns1:store>string</ns1:store>
          <ns1:status>string</ns1:status>
          <ns1:serialno>string</ns1:serialno>
          <ns1:documenttype>string</ns1:documenttype>
          <ns1:type>string</ns1:type>
          <ns1:currency>string</ns1:currency>
          <ns1:currencyrate>string</ns1:currencyrate>
          <ns1:basecurrency>string</ns1:basecurrency>
          <ns1:total>string</ns1:total>
          <ns1:vat>string</ns1:vat>
          <ns1:totalpaid>string</ns1:totalpaid>
          <ns1:invoicedate>string</ns1:invoicedate>
          <ns1:orderdate>string</ns1:orderdate>
          <ns1:duedate>string</ns1:duedate>
          <ns1:buyer>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:buyer>
          <ns1:account>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:account>
          <ns1:order>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:order>
          <ns1:shipment>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:shipment>
          <ns1:refund>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:refund>
          <ns1:paymentterms>string</ns1:paymentterms>
          <ns1:shippingterms>string</ns1:shippingterms>
          <ns1:internalinformation>string</ns1:internalinformation>
          <ns1:ponumber>string</ns1:ponumber>
          <ns1:billingaddress>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
            <ns1:company>string</ns1:company>
            <ns1:attn>string</ns1:attn>
            <ns1:firstname>string</ns1:firstname>
            <ns1:lastname>string</ns1:lastname>
            <ns1:address1>string</ns1:address1>
            <ns1:address2>string</ns1:address2>
            <ns1:city>string</ns1:city>
            <ns1:state>string</ns1:state>
            <ns1:zipcode>string</ns1:zipcode>
            <ns1:country>string</ns1:country>
            <ns1:email>string</ns1:email>
            <ns1:telephone>string</ns1:telephone>
            <ns1:fax>string</ns1:fax>
            <ns1:vat>string</ns1:vat>
            <ns1:url>string</ns1:url>
            <ns1:companyregistrationid>string</ns1:companyregistrationid>
          </ns1:billingaddress>
          <ns1:shippingaddress>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
            <ns1:company>string</ns1:company>
            <ns1:attn>string</ns1:attn>
            <ns1:firstname>string</ns1:firstname>
            <ns1:lastname>string</ns1:lastname>
            <ns1:address1>string</ns1:address1>
            <ns1:address2>string</ns1:address2>
            <ns1:city>string</ns1:city>
            <ns1:state>string</ns1:state>
            <ns1:zipcode>string</ns1:zipcode>
            <ns1:country>string</ns1:country>
            <ns1:email>string</ns1:email>
            <ns1:telephone>string</ns1:telephone>
            <ns1:fax>string</ns1:fax>
            <ns1:vat>string</ns1:vat>
            <ns1:url>string</ns1:url>
            <ns1:companyregistrationid>string</ns1:companyregistrationid>
          </ns1:shippingaddress>
          <ns1:items>
            <ns1:invoiceitem>
              <ns1:itemid>string</ns1:itemid>
              <ns1:qty>string</ns1:qty>
              <ns1:price>string</ns1:price>
              <ns1:tax>string</ns1:tax>
              <ns1:subtotal>string</ns1:subtotal>
              <ns1:description>string</ns1:description>
              <ns1:product>
                <ns1:id>string</ns1:id>
                <ns1:description>string</ns1:description>
              </ns1:product>
              <ns1:variation>
                <ns1:id>string</ns1:id>
                <ns1:description>string</ns1:description>
              </ns1:variation>
              <ns1:size>
                <ns1:id>string</ns1:id>
                <ns1:description>string</ns1:description>
              </ns1:size>
              <ns1:discount>string</ns1:discount>
              <ns1:sku>string</ns1:sku>
            </ns1:invoiceitem>
            <ns1:additional>
              <ns1:subtotal>string</ns1:subtotal>
              <ns1:description>string</ns1:description>
              <ns1:key>string</ns1:key>
              <ns1:id>string</ns1:id>
            </ns1:additional>
          </ns1:items>
          <ns1:locked>string</ns1:locked>
        </ns1:invoice>
      </ns1:invoices>
    </ns1:invoices_Update>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

### Response

```xml
HTTP/1.1 200 OK
Server: nginx
Date: Mon, 14 Oct 2019 07:02:50 GMT
Content-Type: text/xml; charset=utf-8
Connection: keep-alive
X-Centra-Request-ID: 336be74dc1168f05bdb7648c259183d3
X-Correlation-ID: centra_336be74dc1168f05bdb7648c259183d3
Content-Security-Policy-Report-Only: default-src 'self'; style-src 'self' 'unsafe-inline' https://www.gstatic.com/charts/; img-src 'self' https://demo1337.centracdn.net/ https://www.google-analytics.com/; connect-src 'self' https://www.google-analytics.com/analytics.js; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.googletagmanager.com/gtm.js https://www.google-analytics.com/analytics.js https://www.gstatic.com/charts/; object-src 'none'; report-uri https://centra.report-uri.com/r/d/csp/reportOnly;

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Body>
    <invoicesUpdateResponse>OK</invoicesUpdateResponse>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## markets_Update

Update/insert the specified markets.

> Parameters: `markets`: Array of `market` objects.

### Request

```xml
POST /ams/system/service/module/soap/api HTTP/1.1
Host: demo1337.centraqa.com
Connection: Keep-Alive
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://www.centra.com/webservices/Markets_Update"

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:markets_Update>
      <ns1:login>
        <ns1:username>demo</ns1:username>
        <ns1:password>demo</ns1:password>
      </ns1:login>
      <ns1:markets>
        <ns1:market>
          <ns1:id>string</ns1:id>
          <ns1:store>string</ns1:store>
          <ns1:type>string</ns1:type>
          <ns1:description>string</ns1:description>
        </ns1:market>
      </ns1:markets>
    </ns1:markets_Update>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

### Response

```xml
HTTP/1.1 200 OK
Server: nginx
Date: Mon, 14 Oct 2019 07:02:51 GMT
Content-Type: text/xml; charset=utf-8
Connection: keep-alive
X-Centra-Request-ID: 4ab595f07d18060bbdafce6499cc69eb
X-Correlation-ID: centra_4ab595f07d18060bbdafce6499cc69eb
Content-Security-Policy-Report-Only: default-src 'self'; style-src 'self' 'unsafe-inline' https://www.gstatic.com/charts/; img-src 'self' https://demo1337.centracdn.net/ https://www.google-analytics.com/; connect-src 'self' https://www.google-analytics.com/analytics.js; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.googletagmanager.com/gtm.js https://www.google-analytics.com/analytics.js https://www.gstatic.com/charts/; object-src 'none'; report-uri https://centra.report-uri.com/r/d/csp/reportOnly;

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Body>
    <marketsUpdateResponse>OK</marketsUpdateResponse>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## orders_Update

Update/insert the specified orders.

> Parameters: `orders`: Array of `order` objects.

### Request

```xml
POST /ams/system/service/module/soap/api HTTP/1.1
Host: demo1337.centraqa.com
Connection: Keep-Alive
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://www.centra.com/webservices/Orders_Update"

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:orders_Update>
      <ns1:login>
        <ns1:username>demo</ns1:username>
        <ns1:password>demo</ns1:password>
      </ns1:login>
      <ns1:orders>
        <ns1:order>
          <ns1:id>string</ns1:id>
          <ns1:ordernumber>string</ns1:ordernumber>
          <ns1:type>string</ns1:type>
          <ns1:store>int</ns1:store>
          <ns1:locked>string</ns1:locked>
          <ns1:status>string</ns1:status>
          <ns1:ordertotal>string</ns1:ordertotal>
          <ns1:currency>string</ns1:currency>
          <ns1:currencyrate>string</ns1:currencyrate>
          <ns1:basecurrency>string</ns1:basecurrency>
          <ns1:created>string</ns1:created>
          <ns1:internal>boolean</ns1:internal>
          <ns1:preferred_shipping_date>string</ns1:preferred_shipping_date>
          <ns1:buyer>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
            <ns1:firstname>string</ns1:firstname>
            <ns1:lastname>string</ns1:lastname>
            <ns1:email>string</ns1:email>
          </ns1:buyer>
          <ns1:salesrep>
            <ns1:id>string</ns1:id>
            <ns1:email>string</ns1:email>
            <ns1:name>string</ns1:name>
            <ns1:percent>string</ns1:percent>
            <ns1:mastersalesrep>
              <ns1:salesrep>
                <ns1:id>string</ns1:id>
                <ns1:percent>string</ns1:percent>
              </ns1:salesrep>
            </ns1:mastersalesrep>
          </ns1:salesrep>
          <ns1:mastersalesrep>
            <ns1:salesrep>
              <ns1:id>string</ns1:id>
              <ns1:email>string</ns1:email>
              <ns1:name>string</ns1:name>
              <ns1:percent>string</ns1:percent>
              <ns1:mastersalesrep>
                <ns1:salesrep>
                  <ns1:id>string</ns1:id>
                  <ns1:percent>string</ns1:percent>
                </ns1:salesrep>
              </ns1:mastersalesrep>
            </ns1:salesrep>
          </ns1:mastersalesrep>
          <ns1:account>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:account>
          <ns1:paymentterms>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:paymentterms>
          <ns1:shippingterms>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:shippingterms>
          <ns1:deliverywindow>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
            <ns1:type>string</ns1:type>
            <ns1:atonce>boolean</ns1:atonce>
            <ns1:start>string</ns1:start>
            <ns1:stop>string</ns1:stop>
          </ns1:deliverywindow>
          <ns1:collection>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:collection>
          <ns1:additionals>
            <ns1:additional>
              <ns1:key>string</ns1:key>
              <ns1:value>string</ns1:value>
            </ns1:additional>
          </ns1:additionals>
          <ns1:primary_warehouse>
            <ns1:warehouse>
              <ns1:id>string</ns1:id>
              <ns1:description>string</ns1:description>
            </ns1:warehouse>
          </ns1:primary_warehouse>
          <ns1:shipping>
            <ns1:subtotal>string</ns1:subtotal>
            <ns1:description>string</ns1:description>
            <ns1:key>string</ns1:key>
            <ns1:id>string</ns1:id>
          </ns1:shipping>
          <ns1:handling>
            <ns1:subtotal>string</ns1:subtotal>
            <ns1:description>string</ns1:description>
            <ns1:key>string</ns1:key>
            <ns1:id>string</ns1:id>
          </ns1:handling>
          <ns1:voucher>
            <ns1:subtotal>string</ns1:subtotal>
            <ns1:description>string</ns1:description>
            <ns1:key>string</ns1:key>
            <ns1:id>string</ns1:id>
          </ns1:voucher>
          <ns1:payments>
            <ns1:name>string</ns1:name>
            <ns1:type>string</ns1:type>
            <ns1:total>string</ns1:total>
            <ns1:status>string</ns1:status>
            <ns1:method>string</ns1:method>
            <ns1:payment>
              <ns1:type>string</ns1:type>
              <ns1:paid>string</ns1:paid>
              <ns1:value>string</ns1:value>
              <ns1:created>string</ns1:created>
              <ns1:transaction>string</ns1:transaction>
              <ns1:document>string</ns1:document>
            </ns1:payment>
          </ns1:payments>
          <ns1:products>
            <ns1:product>
              <ns1:id>string</ns1:id>
              <ns1:tax>string</ns1:tax>
              <ns1:sku>string</ns1:sku>
              <ns1:origprice>string</ns1:origprice>
              <ns1:price>string</ns1:price>
              <ns1:discount>string</ns1:discount>
              <ns1:qty>string</ns1:qty>
              <ns1:subtotal>string</ns1:subtotal>
              <ns1:description>string</ns1:description>
              <ns1:variation>
                <ns1:id>string</ns1:id>
                <ns1:description>string</ns1:description>
              </ns1:variation>
              <ns1:brand>
                <ns1:id>string</ns1:id>
                <ns1:description>string</ns1:description>
              </ns1:brand>
              <ns1:sizes>
                <ns1:size>
                  <ns1:id>string</ns1:id>
                  <ns1:sku>string</ns1:sku>
                  <ns1:qty>string</ns1:qty>
                  <ns1:preorder>string</ns1:preorder>
                  <ns1:description>string</ns1:description>
                  <ns1:orderitem>
                    <ns1:id>string</ns1:id>
                    <ns1:description>string</ns1:description>
                  </ns1:orderitem>
                  <ns1:warehouseitems>
                    <ns1:warehouse>
                      <ns1:id>string</ns1:id>
                      <ns1:qty>string</ns1:qty>
                    </ns1:warehouse>
                  </ns1:warehouseitems>
                  <ns1:supplierorderitems>
                    <ns1:supplierorder>
                      <ns1:id>string</ns1:id>
                      <ns1:qty>string</ns1:qty>
                      <ns1:eta>string</ns1:eta>
                    </ns1:supplierorder>
                  </ns1:supplierorderitems>
                </ns1:size>
              </ns1:sizes>
              <ns1:type>string</ns1:type>
              <ns1:comment>string</ns1:comment>
            </ns1:product>
          </ns1:products>
          <ns1:cancelled>
            <ns1:product>
              <ns1:id>string</ns1:id>
              <ns1:tax>string</ns1:tax>
              <ns1:sku>string</ns1:sku>
              <ns1:origprice>string</ns1:origprice>
              <ns1:price>string</ns1:price>
              <ns1:discount>string</ns1:discount>
              <ns1:qty>string</ns1:qty>
              <ns1:subtotal>string</ns1:subtotal>
              <ns1:description>string</ns1:description>
              <ns1:variation>
                <ns1:id>string</ns1:id>
                <ns1:description>string</ns1:description>
              </ns1:variation>
              <ns1:brand>
                <ns1:id>string</ns1:id>
                <ns1:description>string</ns1:description>
              </ns1:brand>
              <ns1:sizes>
                <ns1:size>
                  <ns1:id>string</ns1:id>
                  <ns1:sku>string</ns1:sku>
                  <ns1:qty>string</ns1:qty>
                  <ns1:preorder>string</ns1:preorder>
                  <ns1:description>string</ns1:description>
                  <ns1:orderitem>
                    <ns1:id>string</ns1:id>
                    <ns1:description>string</ns1:description>
                  </ns1:orderitem>
                  <ns1:warehouseitems>
                    <ns1:warehouse>
                      <ns1:id>string</ns1:id>
                      <ns1:qty>string</ns1:qty>
                    </ns1:warehouse>
                  </ns1:warehouseitems>
                  <ns1:supplierorderitems>
                    <ns1:supplierorder>
                      <ns1:id>string</ns1:id>
                      <ns1:qty>string</ns1:qty>
                      <ns1:eta>string</ns1:eta>
                    </ns1:supplierorder>
                  </ns1:supplierorderitems>
                </ns1:size>
              </ns1:sizes>
              <ns1:type>string</ns1:type>
              <ns1:comment>string</ns1:comment>
            </ns1:product>
          </ns1:cancelled>
          <ns1:shipments>
            <ns1:shipment>
              <ns1:id>string</ns1:id>
              <ns1:paid>string</ns1:paid>
              <ns1:shipped>string</ns1:shipped>
              <ns1:goodtogo>string</ns1:goodtogo>
              <ns1:capture>string</ns1:capture>
              <ns1:appendix>string</ns1:appendix>
              <ns1:shipmenttotal>string</ns1:shipmenttotal>
              <ns1:paidtotal>string</ns1:paidtotal>
              <ns1:currency>string</ns1:currency>
              <ns1:currencyrate>string</ns1:currencyrate>
              <ns1:basecurrency>string</ns1:basecurrency>
              <ns1:created>string</ns1:created>
              <ns1:shippingaddress>
                <ns1:id>string</ns1:id>
                <ns1:description>string</ns1:description>
                <ns1:company>string</ns1:company>
                <ns1:attn>string</ns1:attn>
                <ns1:firstname>string</ns1:firstname>
                <ns1:lastname>string</ns1:lastname>
                <ns1:address1>string</ns1:address1>
                <ns1:address2>string</ns1:address2>
                <ns1:city>string</ns1:city>
                <ns1:state>string</ns1:state>
                <ns1:zipcode>string</ns1:zipcode>
                <ns1:country>string</ns1:country>
                <ns1:email>string</ns1:email>
                <ns1:telephone>string</ns1:telephone>
                <ns1:fax>string</ns1:fax>
                <ns1:vat>string</ns1:vat>
                <ns1:url>string</ns1:url>
                <ns1:companyregistrationid>string</ns1:companyregistrationid>
              </ns1:shippingaddress>
              <ns1:carrierinformation>
                <ns1:carrier>string</ns1:carrier>
                <ns1:service>string</ns1:service>
                <ns1:account>string</ns1:account>
                <ns1:taxid>string</ns1:taxid>
                <ns1:tracking>string</ns1:tracking>
                <ns1:packages>int</ns1:packages>
              </ns1:carrierinformation>
              <ns1:products>
                <ns1:product>
                  <ns1:id>string</ns1:id>
                  <ns1:tax>string</ns1:tax>
                  <ns1:sku>string</ns1:sku>
                  <ns1:origprice>string</ns1:origprice>
                  <ns1:price>string</ns1:price>
                  <ns1:discount>string</ns1:discount>
                  <ns1:qty>string</ns1:qty>
                  <ns1:subtotal>string</ns1:subtotal>
                  <ns1:description>string</ns1:description>
                  <ns1:variation>
                    <ns1:id>string</ns1:id>
                    <ns1:description>string</ns1:description>
                  </ns1:variation>
                  <ns1:brand>
                    <ns1:id>string</ns1:id>
                    <ns1:description>string</ns1:description>
                  </ns1:brand>
                  <ns1:sizes>
                    <ns1:size>
                      <ns1:id>string</ns1:id>
                      <ns1:sku>string</ns1:sku>
                      <ns1:qty>string</ns1:qty>
                      <ns1:preorder>string</ns1:preorder>
                      <ns1:description>string</ns1:description>
                      <ns1:orderitem>
                        <ns1:id>string</ns1:id>
                        <ns1:description>string</ns1:description>
                      </ns1:orderitem>
                      <ns1:warehouseitems>
                        <ns1:warehouse>
                          <ns1:id>string</ns1:id>
                          <ns1:qty>string</ns1:qty>
                        </ns1:warehouse>
                      </ns1:warehouseitems>
                      <ns1:supplierorderitems>
                        <ns1:supplierorder>
                          <ns1:id>string</ns1:id>
                          <ns1:qty>string</ns1:qty>
                          <ns1:eta>string</ns1:eta>
                        </ns1:supplierorder>
                      </ns1:supplierorderitems>
                    </ns1:size>
                  </ns1:sizes>
                  <ns1:type>string</ns1:type>
                  <ns1:comment>string</ns1:comment>
                </ns1:product>
              </ns1:products>
              <ns1:refunds>
                <ns1:refund>
                  <ns1:id>string</ns1:id>
                  <ns1:shipping>
                    <ns1:subtotal>string</ns1:subtotal>
                    <ns1:description>string</ns1:description>
                    <ns1:key>string</ns1:key>
                    <ns1:id>string</ns1:id>
                  </ns1:shipping>
                  <ns1:voucher>
                    <ns1:subtotal>string</ns1:subtotal>
                    <ns1:description>string</ns1:description>
                    <ns1:key>string</ns1:key>
                    <ns1:id>string</ns1:id>
                  </ns1:voucher>
                  <ns1:products>
                    <ns1:product>
                      <ns1:id>string</ns1:id>
                      <ns1:tax>string</ns1:tax>
                      <ns1:sku>string</ns1:sku>
                      <ns1:origprice>string</ns1:origprice>
                      <ns1:price>string</ns1:price>
                      <ns1:discount>string</ns1:discount>
                      <ns1:qty>string</ns1:qty>
                      <ns1:subtotal>string</ns1:subtotal>
                      <ns1:description>string</ns1:description>
                      <ns1:variation>
                        <ns1:id>string</ns1:id>
                        <ns1:description>string</ns1:description>
                      </ns1:variation>
                      <ns1:brand>
                        <ns1:id>string</ns1:id>
                        <ns1:description>string</ns1:description>
                      </ns1:brand>
                      <ns1:sizes>
                        <ns1:size>
                          <ns1:id>string</ns1:id>
                          <ns1:sku>string</ns1:sku>
                          <ns1:qty>string</ns1:qty>
                          <ns1:preorder>string</ns1:preorder>
                          <ns1:description>string</ns1:description>
                          <ns1:orderitem>
                            <ns1:id>string</ns1:id>
                            <ns1:description>string</ns1:description>
                          </ns1:orderitem>
                          <ns1:warehouseitems>
                            <ns1:warehouse>
                              <ns1:id>string</ns1:id>
                              <ns1:qty>string</ns1:qty>
                            </ns1:warehouse>
                          </ns1:warehouseitems>
                          <ns1:supplierorderitems>
                            <ns1:supplierorder>
                              <ns1:id>string</ns1:id>
                              <ns1:qty>string</ns1:qty>
                              <ns1:eta>string</ns1:eta>
                            </ns1:supplierorder>
                          </ns1:supplierorderitems>
                        </ns1:size>
                      </ns1:sizes>
                      <ns1:type>string</ns1:type>
                      <ns1:comment>string</ns1:comment>
                    </ns1:product>
                  </ns1:products>
                  <ns1:comment>string</ns1:comment>
                  <ns1:returnfee>
                    <ns1:subtotal>string</ns1:subtotal>
                    <ns1:description>string</ns1:description>
                    <ns1:key>string</ns1:key>
                    <ns1:id>string</ns1:id>
                  </ns1:returnfee>
                  <ns1:handling>
                    <ns1:subtotal>string</ns1:subtotal>
                    <ns1:description>string</ns1:description>
                    <ns1:key>string</ns1:key>
                    <ns1:id>string</ns1:id>
                  </ns1:handling>
                  <ns1:status>string</ns1:status>
                  <ns1:type>string</ns1:type>
                </ns1:refund>
              </ns1:refunds>
              <ns1:shipping>
                <ns1:subtotal>string</ns1:subtotal>
                <ns1:description>string</ns1:description>
                <ns1:key>string</ns1:key>
                <ns1:id>string</ns1:id>
              </ns1:shipping>
              <ns1:handling>
                <ns1:subtotal>string</ns1:subtotal>
                <ns1:description>string</ns1:description>
                <ns1:key>string</ns1:key>
                <ns1:id>string</ns1:id>
              </ns1:handling>
              <ns1:voucher>
                <ns1:subtotal>string</ns1:subtotal>
                <ns1:description>string</ns1:description>
                <ns1:key>string</ns1:key>
                <ns1:id>string</ns1:id>
              </ns1:voucher>
            </ns1:shipment>
          </ns1:shipments>
          <ns1:carrierinformation>
            <ns1:carrier>string</ns1:carrier>
            <ns1:service>string</ns1:service>
            <ns1:account>string</ns1:account>
            <ns1:taxid>string</ns1:taxid>
            <ns1:tracking>string</ns1:tracking>
            <ns1:packages>int</ns1:packages>
          </ns1:carrierinformation>
          <ns1:customer>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:customer>
          <ns1:shippingaddress>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
            <ns1:company>string</ns1:company>
            <ns1:attn>string</ns1:attn>
            <ns1:firstname>string</ns1:firstname>
            <ns1:lastname>string</ns1:lastname>
            <ns1:address1>string</ns1:address1>
            <ns1:address2>string</ns1:address2>
            <ns1:city>string</ns1:city>
            <ns1:state>string</ns1:state>
            <ns1:zipcode>string</ns1:zipcode>
            <ns1:country>string</ns1:country>
            <ns1:email>string</ns1:email>
            <ns1:telephone>string</ns1:telephone>
            <ns1:fax>string</ns1:fax>
            <ns1:vat>string</ns1:vat>
            <ns1:url>string</ns1:url>
            <ns1:companyregistrationid>string</ns1:companyregistrationid>
          </ns1:shippingaddress>
          <ns1:billingaddress>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
            <ns1:company>string</ns1:company>
            <ns1:attn>string</ns1:attn>
            <ns1:firstname>string</ns1:firstname>
            <ns1:lastname>string</ns1:lastname>
            <ns1:address1>string</ns1:address1>
            <ns1:address2>string</ns1:address2>
            <ns1:city>string</ns1:city>
            <ns1:state>string</ns1:state>
            <ns1:zipcode>string</ns1:zipcode>
            <ns1:country>string</ns1:country>
            <ns1:email>string</ns1:email>
            <ns1:telephone>string</ns1:telephone>
            <ns1:fax>string</ns1:fax>
            <ns1:vat>string</ns1:vat>
            <ns1:url>string</ns1:url>
            <ns1:companyregistrationid>string</ns1:companyregistrationid>
          </ns1:billingaddress>
          <ns1:internalinformation>string</ns1:internalinformation>
          <ns1:other>string</ns1:other>
          <ns1:ponumber>string</ns1:ponumber>
          <ns1:market>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:market>
          <ns1:pricelist>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:pricelist>
          <ns1:ecvatno>string</ns1:ecvatno>
        </ns1:order>
      </ns1:orders>
    </ns1:orders_Update>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

### Response

```xml
HTTP/1.1 200 OK
Server: nginx
Date: Mon, 14 Oct 2019 07:02:53 GMT
Content-Type: text/xml; charset=utf-8
Connection: keep-alive
X-Centra-Request-ID: 8317ccda44fd23c03455523ad6e425e9
X-Correlation-ID: centra_8317ccda44fd23c03455523ad6e425e9
Content-Security-Policy-Report-Only: default-src 'self'; style-src 'self' 'unsafe-inline' https://www.gstatic.com/charts/; img-src 'self' https://demo1337.centracdn.net/ https://www.google-analytics.com/; connect-src 'self' https://www.google-analytics.com/analytics.js; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.googletagmanager.com/gtm.js https://www.google-analytics.com/analytics.js https://www.gstatic.com/charts/; object-src 'none'; report-uri https://centra.report-uri.com/r/d/csp/reportOnly;

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Body>
    <ordersUpdateResponse>OK</ordersUpdateResponse>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## paymentterms_Update

Update/insert the specified payment terms.

> Parameters: `paymentterms`: Array of `paymentterms` objects.

### Request

```xml
POST /ams/system/service/module/soap/api HTTP/1.1
Host: demo1337.centraqa.com
Connection: Keep-Alive
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://www.centra.com/webservices/Paymentterms_Update"

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:paymentterms_Update>
      <ns1:login>
        <ns1:username>demo</ns1:username>
        <ns1:password>demo</ns1:password>
      </ns1:login>
      <ns1:paymentterms>
        <ns1:paymentterms>
          <ns1:id>string</ns1:id>
          <ns1:name>string</ns1:name>
          <ns1:description>string</ns1:description>
          <ns1:duedays>string</ns1:duedays>
        </ns1:paymentterms>
      </ns1:paymentterms>
    </ns1:paymentterms_Update>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

### Response

```xml
HTTP/1.1 200 OK
Server: nginx
Date: Mon, 14 Oct 2019 07:02:53 GMT
Content-Type: text/xml; charset=utf-8
Connection: keep-alive
X-Centra-Request-ID: 6873116a6212588d1f005ae3eca62083
X-Correlation-ID: centra_6873116a6212588d1f005ae3eca62083
Content-Security-Policy-Report-Only: default-src 'self'; style-src 'self' 'unsafe-inline' https://www.gstatic.com/charts/; img-src 'self' https://demo1337.centracdn.net/ https://www.google-analytics.com/; connect-src 'self' https://www.google-analytics.com/analytics.js; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.googletagmanager.com/gtm.js https://www.google-analytics.com/analytics.js https://www.gstatic.com/charts/; object-src 'none'; report-uri https://centra.report-uri.com/r/d/csp/reportOnly;

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Body>
    <paymenttermsUpdateResponse>OK</paymenttermsUpdateResponse>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## pricelists_Update

Update/insert the specified pricelists.

> Parameters: `pricelists`: Array of `pricelist` objects.

### Request

```xml
POST /ams/system/service/module/soap/api HTTP/1.1
Host: demo1337.centraqa.com
Connection: Keep-Alive
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://www.centra.com/webservices/Pricelists_Update"

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:pricelists_Update>
      <ns1:login>
        <ns1:username>demo</ns1:username>
        <ns1:password>demo</ns1:password>
      </ns1:login>
      <ns1:pricelists>
        <ns1:pricelist>
          <ns1:id>string</ns1:id>
          <ns1:store>string</ns1:store>
          <ns1:type>string</ns1:type>
          <ns1:currency>string</ns1:currency>
          <ns1:description>string</ns1:description>
          <ns1:items>
            <ns1:product>
              <ns1:id>string</ns1:id>
              <ns1:price>string</ns1:price>
              <ns1:priceb>string</ns1:priceb>
              <ns1:variation>
                <ns1:id>string</ns1:id>
                <ns1:price>string</ns1:price>
                <ns1:priceb>string</ns1:priceb>
              </ns1:variation>
            </ns1:product>
          </ns1:items>
        </ns1:pricelist>
      </ns1:pricelists>
    </ns1:pricelists_Update>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

### Response

```xml
HTTP/1.1 200 OK
Server: nginx
Date: Mon, 14 Oct 2019 07:02:56 GMT
Content-Type: text/xml; charset=utf-8
Connection: keep-alive
X-Centra-Request-ID: 23e7849cf1306ca376af5508aa42a35a
X-Correlation-ID: centra_23e7849cf1306ca376af5508aa42a35a
Content-Security-Policy-Report-Only: default-src 'self'; style-src 'self' 'unsafe-inline' https://www.gstatic.com/charts/; img-src 'self' https://demo1337.centracdn.net/ https://www.google-analytics.com/; connect-src 'self' https://www.google-analytics.com/analytics.js; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.googletagmanager.com/gtm.js https://www.google-analytics.com/analytics.js https://www.gstatic.com/charts/; object-src 'none'; report-uri https://centra.report-uri.com/r/d/csp/reportOnly;

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Body>
    <pricelistsUpdateResponse>OK</pricelistsUpdateResponse>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## products_Update

Update/insert the specified products.

> Parameters: `products`: Array of `product` objects.

### Request

```xml
POST /ams/system/service/module/soap/api HTTP/1.1
Host: demo1337.centraqa.com
Connection: Keep-Alive
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://www.centra.com/webservices/Products_Update"

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:products_Update>
      <ns1:login>
        <ns1:username>demo</ns1:username>
        <ns1:password>demo</ns1:password>
      </ns1:login>
      <ns1:products>
        <ns1:product>
          <ns1:id>string</ns1:id>
          <ns1:status>string</ns1:status>
          <ns1:sku>string</ns1:sku>
          <ns1:description>string</ns1:description>
          <ns1:folder>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:folder>
          <ns1:brand>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:brand>
          <ns1:collection>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:collection>
          <ns1:harmcode>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
          </ns1:harmcode>
          <ns1:countryoforigin>string</ns1:countryoforigin>
          <ns1:weight>
            <ns1:value>string</ns1:value>
            <ns1:unit>string</ns1:unit>
          </ns1:weight>
          <ns1:variations>
            <ns1:variation>
              <ns1:id>string</ns1:id>
              <ns1:stockid>string</ns1:stockid>
              <ns1:description>string</ns1:description>
              <ns1:sku>string</ns1:sku>
              <ns1:status>string</ns1:status>
              <ns1:sizetable>
                <ns1:id>string</ns1:id>
                <ns1:description>string</ns1:description>
              </ns1:sizetable>
              <ns1:sizes>
                <ns1:size>
                  <ns1:id>string</ns1:id>
                  <ns1:qty>string</ns1:qty>
                  <ns1:preorder>string</ns1:preorder>
                  <ns1:description>string</ns1:description>
                  <ns1:comment>string</ns1:comment>
                  <ns1:sku>string</ns1:sku>
                  <ns1:ean>string</ns1:ean>
                  <ns1:warehouseitems>
                    <ns1:warehouse>
                      <ns1:id>string</ns1:id>
                      <ns1:qty>string</ns1:qty>
                      <ns1:cog>string</ns1:cog>
                    </ns1:warehouse>
                  </ns1:warehouseitems>
                </ns1:size>
              </ns1:sizes>
              <ns1:displays>
                <ns1:display>
                  <ns1:store>string</ns1:store>
                  <ns1:categories>
                    <ns1:category>
                      <ns1:id>string</ns1:id>
                      <ns1:description>string</ns1:description>
                    </ns1:category>
                  </ns1:categories>
                  <ns1:categoriesremove>
                    <ns1:category>
                      <ns1:id>string</ns1:id>
                      <ns1:description>string</ns1:description>
                    </ns1:category>
                  </ns1:categoriesremove>
                  <ns1:markets>
                    <ns1:market>
                      <ns1:id>string</ns1:id>
                      <ns1:description>string</ns1:description>
                    </ns1:market>
                  </ns1:markets>
                  <ns1:marketsremove>
                    <ns1:market>
                      <ns1:id>string</ns1:id>
                      <ns1:description>string</ns1:description>
                    </ns1:market>
                  </ns1:marketsremove>
                  <ns1:minimumorderamount>string</ns1:minimumorderamount>
                  <ns1:orderdenominator>string</ns1:orderdenominator>
                </ns1:display>
              </ns1:displays>
              <ns1:cog>string</ns1:cog>
            </ns1:variation>
          </ns1:variations>
          <ns1:media>
            <ns1:image>
              <ns1:id>string</ns1:id>
              <ns1:image>string</ns1:image>
              <ns1:variation>
                <ns1:id>string</ns1:id>
                <ns1:description>string</ns1:description>
              </ns1:variation>
            </ns1:image>
          </ns1:media>
          <ns1:metadata>
            <ns1:storemeta>
              <ns1:shortdescription>string</ns1:shortdescription>
              <ns1:description>string</ns1:description>
              <ns1:metatitle>string</ns1:metatitle>
              <ns1:metakeywords>string</ns1:metakeywords>
              <ns1:metadescription>string</ns1:metadescription>
              <ns1:taxgroup>string</ns1:taxgroup>
              <ns1:store>string</ns1:store>
            </ns1:storemeta>
          </ns1:metadata>
          <ns1:comment>string</ns1:comment>
        </ns1:product>
      </ns1:products>
    </ns1:products_Update>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

### Response

```xml
HTTP/1.1 200 OK
Server: nginx
Date: Mon, 14 Oct 2019 07:02:58 GMT
Content-Type: text/xml; charset=utf-8
Connection: keep-alive
X-Centra-Request-ID: 749226d7b678b127c294f5a85ec8d8cd
X-Correlation-ID: centra_749226d7b678b127c294f5a85ec8d8cd
Content-Security-Policy-Report-Only: default-src 'self'; style-src 'self' 'unsafe-inline' https://www.gstatic.com/charts/; img-src 'self' https://demo1337.centracdn.net/ https://www.google-analytics.com/; connect-src 'self' https://www.google-analytics.com/analytics.js; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.googletagmanager.com/gtm.js https://www.google-analytics.com/analytics.js https://www.gstatic.com/charts/; object-src 'none'; report-uri https://centra.report-uri.com/r/d/csp/reportOnly;

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Body>
    <productsUpdateResponse>OK</productsUpdateResponse>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## salesreps_Update

Update/insert the specified sales reps.

> Parameters: `salesreps`: Array of `salesrep` objects.

### Request

```xml
POST /ams/system/service/module/soap/api HTTP/1.1
Host: demo1337.centraqa.com
Connection: Keep-Alive
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://www.centra.com/webservices/Salesreps_Update"

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:salesreps_Update>
      <ns1:login>
        <ns1:username>demo</ns1:username>
        <ns1:password>demo</ns1:password>
      </ns1:login>
      <ns1:salesreps>
        <ns1:salesrep>
          <ns1:id>string</ns1:id>
          <ns1:email>string</ns1:email>
          <ns1:name>string</ns1:name>
          <ns1:percent>string</ns1:percent>
          <ns1:mastersalesrep>
            <ns1:salesrep>
              <ns1:id>string</ns1:id>
              <ns1:percent>string</ns1:percent>
            </ns1:salesrep>
          </ns1:mastersalesrep>
        </ns1:salesrep>
      </ns1:salesreps>
    </ns1:salesreps_Update>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

### Response

```xml
HTTP/1.1 200 OK
Server: nginx
Date: Mon, 14 Oct 2019 07:02:59 GMT
Content-Type: text/xml; charset=utf-8
Connection: keep-alive
X-Centra-Request-ID: 014157d97b144df8cafeaedb3541e163
X-Correlation-ID: centra_014157d97b144df8cafeaedb3541e163
Content-Security-Policy-Report-Only: default-src 'self'; style-src 'self' 'unsafe-inline' https://www.gstatic.com/charts/; img-src 'self' https://demo1337.centracdn.net/ https://www.google-analytics.com/; connect-src 'self' https://www.google-analytics.com/analytics.js; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.googletagmanager.com/gtm.js https://www.google-analytics.com/analytics.js https://www.gstatic.com/charts/; object-src 'none'; report-uri https://centra.report-uri.com/r/d/csp/reportOnly;

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Body>
    <salesrepsUpdateResponse>OK</salesrepsUpdateResponse>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## shippingterms_Update

Update/insert the specified shipping terms.

> Parameters: `shippingterms`: Array of `shippingterms` objects.

### Request

```xml
POST /ams/system/service/module/soap/api HTTP/1.1
Host: demo1337.centraqa.com
Connection: Keep-Alive
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://www.centra.com/webservices/Shippingterms_Update"

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:shippingterms_Update>
      <ns1:login>
        <ns1:username>demo</ns1:username>
        <ns1:password>demo</ns1:password>
      </ns1:login>
      <ns1:shippingterms>
        <ns1:shippingterms>
          <ns1:id>string</ns1:id>
          <ns1:name>string</ns1:name>
          <ns1:description>string</ns1:description>
          <ns1:duedays>string</ns1:duedays>
        </ns1:shippingterms>
      </ns1:shippingterms>
    </ns1:shippingterms_Update>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

### Response

```xml
HTTP/1.1 200 OK
Server: nginx
Date: Mon, 14 Oct 2019 07:03:00 GMT
Content-Type: text/xml; charset=utf-8
Connection: keep-alive
X-Centra-Request-ID: 2b447470e96d63964ad92a26c4f3888d
X-Correlation-ID: centra_2b447470e96d63964ad92a26c4f3888d
Content-Security-Policy-Report-Only: default-src 'self'; style-src 'self' 'unsafe-inline' https://www.gstatic.com/charts/; img-src 'self' https://demo1337.centracdn.net/ https://www.google-analytics.com/; connect-src 'self' https://www.google-analytics.com/analytics.js; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.googletagmanager.com/gtm.js https://www.google-analytics.com/analytics.js https://www.gstatic.com/charts/; object-src 'none'; report-uri https://centra.report-uri.com/r/d/csp/reportOnly;

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Body>
    <shippingtermsUpdateResponse>OK</shippingtermsUpdateResponse>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## sizes_Update

Update/insert the specified sizes.

> Parameters: `sizes`: Array of `size` objects.

### Request

```xml
POST /ams/system/service/module/soap/api HTTP/1.1
Host: demo1337.centraqa.com
Connection: Keep-Alive
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://www.centra.com/webservices/Sizes_Update"

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:sizes_Update>
      <ns1:login>
        <ns1:username>demo</ns1:username>
        <ns1:password>demo</ns1:password>
      </ns1:login>
      <ns1:sizes>
        <ns1:size>
          <ns1:id>string</ns1:id>
          <ns1:description>string</ns1:description>
          <ns1:sku>string</ns1:sku>
          <ns1:ean>string</ns1:ean>
          <ns1:comment>string</ns1:comment>
          <ns1:sizetable>
            <ns1:id>string</ns1:id>
            <ns1:description>string</ns1:description>
            <ns1:stockdivisor>string</ns1:stockdivisor>
            <ns1:stockunit>string</ns1:stockunit>
          </ns1:sizetable>
        </ns1:size>
      </ns1:sizes>
    </ns1:sizes_Update>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

### Response

```xml
HTTP/1.1 200 OK
Server: nginx
Date: Mon, 14 Oct 2019 07:03:01 GMT
Content-Type: text/xml; charset=utf-8
Connection: keep-alive
X-Centra-Request-ID: bcae6be04762e82b4935f84e774b7938
X-Correlation-ID: centra_bcae6be04762e82b4935f84e774b7938
Content-Security-Policy-Report-Only: default-src 'self'; style-src 'self' 'unsafe-inline' https://www.gstatic.com/charts/; img-src 'self' https://demo1337.centracdn.net/ https://www.google-analytics.com/; connect-src 'self' https://www.google-analytics.com/analytics.js; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.googletagmanager.com/gtm.js https://www.google-analytics.com/analytics.js https://www.gstatic.com/charts/; object-src 'none'; report-uri https://centra.report-uri.com/r/d/csp/reportOnly;

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Body>
    <sizesUpdateResponse>OK</sizesUpdateResponse>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## warehouses_Update

Update/insert the specified warehouses.

> Parameters: `warehouses`: Array of `warehouse` objects.

### Request

```xml
POST /ams/system/service/module/soap/api HTTP/1.1
Host: demo1337.centraqa.com
Connection: Keep-Alive
Content-Type: text/xml; charset=utf-8
SOAPAction: "http://www.centra.com/webservices/Warehouses_Update"

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:warehouses_Update>
      <ns1:login>
        <ns1:username>demo</ns1:username>
        <ns1:password>demo</ns1:password>
      </ns1:login>
      <ns1:warehouses>
        <ns1:warehouse>
          <ns1:id>string</ns1:id>
          <ns1:description>string</ns1:description>
        </ns1:warehouse>
      </ns1:warehouses>
    </ns1:warehouses_Update>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

### Response

```xml
HTTP/1.1 200 OK
Server: nginx
Date: Mon, 14 Oct 2019 07:03:02 GMT
Content-Type: text/xml; charset=utf-8
Connection: keep-alive
X-Centra-Request-ID: 0b69ba7ef5533fc28301b11246393678
X-Correlation-ID: centra_0b69ba7ef5533fc28301b11246393678
Content-Security-Policy-Report-Only: default-src 'self'; style-src 'self' 'unsafe-inline' https://www.gstatic.com/charts/; img-src 'self' https://demo1337.centracdn.net/ https://www.google-analytics.com/; connect-src 'self' https://www.google-analytics.com/analytics.js; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.googletagmanager.com/gtm.js https://www.google-analytics.com/analytics.js https://www.gstatic.com/charts/; object-src 'none'; report-uri https://centra.report-uri.com/r/d/csp/reportOnly;

<?xml version="1.0"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
  <SOAP-ENV:Body>
    <warehousesUpdateResponse>OK</warehousesUpdateResponse>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```
