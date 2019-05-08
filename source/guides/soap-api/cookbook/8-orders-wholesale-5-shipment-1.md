# Orders - Wholesale 5 - Shipment 1

[https://docs.centra.com/soap/index.php?op=orders_Update](https://docs.centra.com/soap/index.php?op=orders_Update)

Creates a shipment for some of the items in the order.

The `<shipping>` contains the shipping price, copied from the order event.

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
              <shipped>no</shipped>
              <goodtogo>yes</goodtogo>
              <appendix>1</appendix>
              <products>
                <product>
                  <id>T001</id>
                  <variation>
                    <id>T001_BLUE</id>
                  </variation>
                  <sizes>
                    <size>
                      <id>S</id>
                      <qty>1</qty>
                      <orderitem>
                        <id>68</id>
                      </orderitem>
                    </size>
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
                  <id>PWC</id>
                  <variation>
                    <id>PWC</id>
                  </variation>
                  <sizes>
                    <size>
                      <id>OS</id>
                      <qty>2</qty>
                      <orderitem>
                        <id>67</id>
                      </orderitem>
                    </size>
                  </sizes>
                </product>
              </products>
              <shipping>
                <subtotal>123</subtotal>
              </shipping>
            </shipment>
          </shipments>
        </order>
      </orders>
    </orders_Update>
  </soap:Body>
</soap:Envelope>
```