# Wholesale Accounts 2 - Shipping Terms

[https://docs.centra.com/soap/index.php?op=shippingterms_Update](https://docs.centra.com/soap/index.php?op=shippingterms_Update)

Create or update shipping terms. The shipping terms are set on an account, so they should be created before the account data is sent to Centra.

Notice that `<name>` is the name or title of the shipping term in the Centra admin. The `<description>` is a longer optional descriptive text. This is different form other data in the API where `<description>` is the name or title of something.

## Request

```
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <shippingterms_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <shippingterms>
        <shippingterms>
          <id>DDU</id>
          <name>Delivered Duty Unpaid</name>
          <description>Optional text describing this shippingterm</description>
        </shippingterms>
      </shippingterms>
    </shippingterms_Update>
  </soap:Body>
</soap:Envelope>
```
