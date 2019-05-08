# Product Stock 1 - Warehouses

[https://docs.centra.com/soap/index.php?op=warehouses_Update](https://docs.centra.com/soap/index.php?op=warehouses_Update)

Creates or updates warehouses in Centra.

If Centra already has warehouses setup, you should probably not create new ones. Contact us so we can setup the existing ones in the ID conversion table instead.

This is operation is optional. If you simply send stock numbers to a warehouse `<id>` in the next example without creating warehouses first, the warehouses will be created automatically.

## Request

```
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <warehouses_Update xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <warehouses>
        <warehouse>
          <id>MainWarehouse</id>
          <description>Main Warehouse</description>
        </warehouse>
        <warehouse>
          <id>OtherWarehouse</id>
          <description>Other Warehouse</description>
        </warehouse>
      </warehouses>
    </warehouses_Update>
  </soap:Body>
</soap:Envelope>
```