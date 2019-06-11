# Product Stock 2 - Stock Update

[https://docs.centra.com/soap/index.php?op=products_Update](https://docs.centra.com/soap/index.php?op=products_Update)

Set product stock quantities in a warehouse.

This uses the same products_Update operation as the "Product Data", but with fewer and different fields. It changes the stock quantities of the Chair from "Product Data 3 - A Chair".

On the `<product>`, `<variation>` and `<size>` the different IDs remain from the "Product Data 3 - A Chair" example. These are required to identify what sizes to change.

The `<warehouseitems>` is new in this example, this sets the stock quantities of that size in two different warehouses

## Important

The stock `<qty>` is the number of items that are available for sale and has not been reserved for existing orders. It is not the number of items on the shelf in the warehouse.

In Centra this is called **FTA** – free to allocate.

When an order is placed in Centra it will allocate (reserve) stock, reducing the FTA. The number on the shelf stays the same. After an order has shipped, the number on the shelf is reduced.

You need to send the number of items on the shelf in the warehouse *minus* what is reserved for unshipped orders in Centra or elsewhere.

This also means you should fetch orders from Centra before sending stock updates to be able to calculate the correct stock values. (See the order examples)

## Preconditions

- The products must exist in Centra

## Request

```
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <products_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <products>
        <product>
          <id>PWC</id>
          <variations>
            <variation>
              <id>PWC</id>
              <stockid>PWC</stockid>
              <sizes>
                <size>
                  <id>OS</id>
                  <warehouseitems>
                    <warehouse>
                      <id>MainWarehouse</id>
                      <qty>1</qty>
                    </warehouse>
                    <warehouse>
                      <id>OtherWarehouse</id>
                      <qty>2</qty>
                    </warehouse>
                  </warehouseitems>
                </size>
              </sizes>
            </variation>
          </variations>
        </product>
      </products>
    </products_Update>
  </soap:Body>
</soap:Envelope>
```
