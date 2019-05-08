# Orders - Retail 4 - Order Shipped

[https://docs.centra.com/soap/index.php?op=orders_Update](https://docs.centra.com/soap/index.php?op=orders_Update)

This marks the shipment of the order as shipped, and sets the tracking number for the shipment.

## Important: Capture

The `<capture>yes</capture>` will instruct Centra to capture the payment for the shipment with the payment provider, to actually withdraw the money from the customer's account.

In most cases retail orders will only reserve the payment until the order is shipped. When the order is shipped the payment must be "captured".

The `<capture>yes</capture>` will capture if it's possible to performa a capture on this order. If its not possible or the order has already been captured it has no effect. This makes it possible for you to always send `<capture>yes</capture>` when a shipment has been shipped without having to figure out if this order has already been captured.

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
          <id>30</id>
          <type>retail</type>
          <store>1</store>
          <status>completed</status>
          <shipments>
            <shipment>
              <id>8</id>
              <shipped>yes</shipped>
              <capture>yes</capture>
              <carrierinformation>
                <carrier>UPS</carrier>
                <service>STANDARD</service>
                <tracking>1Z123123123123</tracking>
              </carrierinformation>
            </shipment>
          </shipments>
        </order>
      </orders>
    </orders_Update>
  </soap:Body>
</soap:Envelope>
```
