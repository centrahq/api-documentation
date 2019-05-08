# Wholesale Accounts 1 - Payment Terms

[https://docs.centra.com/soap/index.php?op=paymentterms_Update](https://docs.centra.com/soap/index.php?op=paymentterms_Update)

Create or update payment terms. The payment terms are set on an account, so they should be created before the account data is sent to Centra.

Notice that `<name>` is the name or title of the payent term in the Centra admin, the `<description>` is a longer optional descriptive text. This is different form other data in the API where `<description>` is the name or title of something.

## Request

```
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <paymentterms_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <paymentterms>
        <paymentterms>
          <id>30NET</id>
          <name>30 Days</name>
          <description>Optional text describing this paymentterm</description>
          <duedays>30</duedays>
        </paymentterms>
      </paymentterms>
    </paymentterms_Update>
  </soap:Body>
</soap:Envelope>
```
