# Orders - Retail 2 - Event Done

[https://docs.centra.com/soap/index.php?op=events_Done](https://docs.centra.com/soap/index.php?op=events_Done)

This marks the event from the previous example as done. That event had ID 115. To illustrate how to mark multiple events as done at the same time, this example also sends event IDs 116 and 117.

## Request

```
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
