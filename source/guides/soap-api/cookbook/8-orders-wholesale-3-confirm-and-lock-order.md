# Orders - Wholesale 3 - Confirm And Lock Order

[https://docs.centra.com/soap/index.php?op=orders_Update](https://docs.centra.com/soap/index.php?op=orders_Update)

Changes the order status from "pending" to "confirmed", and locks the order so it cannot be modified in the Centra admin.

For wholesale orders it is common that the order has status "pending" when it is placed and then has to be confirmed (accepted) by someone working in Centra or on your side. If orders are confirmed in Centra, you should not import the order when it has status "pending". Just mark that event as done. You will get a new event when it has status "confirmed". In this example someone has confirmed the order on your side and this update marks it as confirmed in Centra.

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
          <status>confirmed</status>
          <locked>yes</locked>
        </order>
      </orders>
    </orders_Update>
  </soap:Body>
</soap:Envelope>
```