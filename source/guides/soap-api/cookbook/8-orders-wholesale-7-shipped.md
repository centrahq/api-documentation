# Orders - Wholesale 7 - Shipped

[https://docs.centra.com/soap/index.php?op=orders_Update](https://docs.centra.com/soap/index.php?op=orders_Update)

Marks both shipments as shipped.

Notice that the order is not seen as completed in Centra at this stage. It is seen as completed when it has been shipped and also paid for.

## Request

```
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
