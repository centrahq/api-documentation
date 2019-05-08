# Connection Test

To test the connection, use the events_Get operation. This is a read only operation, nothing bad can happen.

[https://docs.centra.com/soap/index.php?op=events_Get](https://docs.centra.com/soap/index.php?op=events_Get)

## Information you need

- The API endpoint (and WSDL if you use the WSDL definition to build a client on your side)
- Username
- Password

The API endpoint typically looks something like this:
http://example.centra.com/ams/system/service/module/soap/api

The WSDL definition is the API endpoint with ?wsdl at the end:
http://example.centra.com/ams/system/service/module/soap/api?wsdl

## Request

```
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

## Response

```
<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:events_Get>
      <ns1:events/>
    </ns1:events_Get>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```

## Notes

The response you get when you try this can contain a lot of data in the `<ns1:events>` if there are events in the event queue.
