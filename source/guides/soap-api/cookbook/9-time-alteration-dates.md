## Time Alteration Dates

[https://docs.centra.com/soap/index.php?op=timealterationdates_Update](https://docs.centra.com/soap/index.php?op=timealterationdates_Update)

Create or update Time Alteration Dates. To use Time Altered Prices you need to have an active Time Alteration Date first. You can read more about Time Altered Prices [here](https://support.centra.com/centra-sections/wholesale-b2b/setup/time-controlled-prices).

Notice that this functionality works only on Wholesale stores.

### Request

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <pricealterationdates_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>????</password>
      </login>
      <pricealterationdates>
        <pricealterationdate>
            <id>H20</id>
            <status>active</status>
            <name>Halloween 2020</name>
            <store>1</store>
            <startdate>2020-11-30</startdate>
        </pricealterationdate>
      </pricealterationdates>
    </pricealterationdates_Update>
  </soap:Body>
</soap:Envelope>
```
