# Orders - Retail 3 - Lock Order

[https://docs.centra.com/soap/index.php?op=orders_Update](https://docs.centra.com/soap/index.php?op=orders_Update)

Locking an order prevents most changes to the order in the Centra admin. This is a good idea if your side takes ownership of the order data after you have imported the order.

This orders_Update will only change the `<locked>` status. Nothing else on the order is changed.

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
          <locked>yes</locked>
        </order>
      </orders>
    </orders_Update>
  </soap:Body>
</soap:Envelope>
```