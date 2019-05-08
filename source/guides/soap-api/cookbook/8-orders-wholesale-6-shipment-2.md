# Orders - Wholesale 6 - Shipment 2

[https://docs.centra.com/soap/index.php?op=orders_Update](https://docs.centra.com/soap/index.php?op=orders_Update)

Creates a shipment for the remaining items on the order.

Compared to the previous example, this one does not specify `<shipping>` so it will have 0 shipping cost.

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
              <id>shipment-25-2</id>
              <shipped>no</shipped>
              <goodtogo>yes</goodtogo>
              <appendix>2</appendix>
              <products>
                <product>
                  <id>T001</id>
                  <variation>
                    <id>T001_BLUE</id>
                  </variation>
                  <sizes>
                    <size>
                      <id>M</id>
                      <qty>1</qty>
                      <orderitem>
                        <id>69</id>
                      </orderitem>
                    </size>
                  </sizes>
                </product>
                <product>
                  <id>T001</id>
                  <variation>
                    <id>T001_RED</id>
                  </variation>
                  <sizes>
                    <size>
                      <id>M</id>
                      <qty>3</qty>
                      <orderitem>
                        <id>70</id>
                      </orderitem>
                    </size>
                    <size>
                      <id>L</id>
                      <qty>3</qty>
                      <orderitem>
                        <id>71</id>
                      </orderitem>
                    </size>
                  </sizes>
                </product>
              </products>
              <shipping>
                <subtotal>0</subtotal>
              </shipping>
            </shipment>
          </shipments>
        </order>
      </orders>
    </orders_Update>
  </soap:Body>
</soap:Envelope>
```