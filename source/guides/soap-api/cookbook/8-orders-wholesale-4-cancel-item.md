# Orders - Wholesale 4 - Cancel Item

[https://docs.centra.com/soap/index.php?op=orders_Update](https://docs.centra.com/soap/index.php?op=orders_Update)

Modifies the order by cancelling a single size of a product from the order. I will cancel 1 of the 4 red sweaters in size L.

Notice the `<orderitem>` on the `<size>`. This is a unique ID for that row on the order, and you should always use it to modify the order. It is possible to have the same size twice or more in the same order, for example if one had a discounted price. The `<orderitem>` is always unique within the order, the `<product>` or `<variation>` or `<size>` is not.

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
          <cancelled>
            <product>
              <id>T001</id>
              <variation>
                <id>T001_RED</id>
              </variation>
              <sizes>
                <size>
                  <id>L</id>
                  <qty>1</qty>
                  <orderitem>
                    <id>71</id>
                  </orderitem>
                  <supplierorderitems/>
                </size>
              </sizes>
            </product>
          </cancelled>
        </order>
      </orders>
    </orders_Update>
  </soap:Body>
</soap:Envelope>
```
