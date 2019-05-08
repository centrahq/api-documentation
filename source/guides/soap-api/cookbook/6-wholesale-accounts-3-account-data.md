# Wholesale Accounts 3 - Account Data

[https://docs.centra.com/soap/index.php?op=accounts_Update](https://docs.centra.com/soap/index.php?op=accounts_Update)

Creates or updates an account. The account is the data for a wholesale customer, a company that can make purchases in Centra's wholesale showroom.

## Information you need

- Store IDs of the wholesale store or stores. Contact us and we will provide them to you.

## Preconditions

- Pricelists should exist
- Markets should exist
- Payment and shipping terms should exist if you send the optional `<paymentterms>` or `<shippingterms>`

## Fields

- `<status>` can be `active`, `inactive` or `cancelled`. Only active accounts can make purchases
- `<accountaddress>` is the visiting address
- `<buyers>` is a list of one or more buyers. They are users that can log into the wholesale showroom and make purchases for the account.

Notice that you **must** send a `<buyer>` for the account to show in the Centra admin. Send one with blank name and email if you do not have this data in your system.

## Request

```
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <accounts_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <accounts>
        <account>
          <id>12345</id>
          <type>wholesale</type>
          <status>active</status>
          <description>Company Name</description>
          <market>
            <id>Wholesale-Market</id>
          </market>
          <pricelist>
            <id>USD-Wholesale</id>
          </pricelist>
          <paymentterms>
            <id>30NET</id>
          </paymentterms>
          <shippingterms>
            <id>DDU</id>
          </shippingterms>
          <accountaddress>
            <company>Example</company>
            <attn>Person name</attn>
            <address1>Street 1</address1>
            <address2>Suite 123</address2>
            <city>City</city>
            <state>State</state>
            <zipcode>12345</zipcode>
            <country>US</country>
            <email>info@example.com</email>
            <telephone>123 456 789</telephone>
            <url>www.example.com</url>
          </accountaddress>
          <shippingaddress>
            <company>Example Warehouse</company>
            <attn>Person name</attn>
            <address1>Street 1</address1>
            <address2>Suite 123</address2>
            <city>City</city>
            <state>State</state>
            <zipcode>12345</zipcode>
            <country>FR</country>
            <email>info@example.com</email>
            <telephone>123 456 789</telephone>
          </shippingaddress>
          <invoiceaddress>
            <company>Example Billing</company>
            <attn>Person name</attn>
            <address1>Street 1</address1>
            <address2>Suite 123</address2>
            <city>City</city>
            <state></state>
            <zipcode>12345</zipcode>
            <country>SE</country>
            <email>info@example.com</email>
            <telephone>123 456 789</telephone>
            <vat>SE12345678901</vat>
          </invoiceaddress>
          <buyers>
            <buyer>
              <id>12345_buyer1</id>
              <store>2</store>
              <status>active</status>
              <firstname>Frist</firstname>
              <lastname>Last</lastname>
              <email>first.last@example.com</email>
            </buyer>
          </buyers>
        </account>
      </accounts>
    </accounts_Update>
  </soap:Body>
</soap:Envelope>
```
