# Orders - Wholesale 1 - Event By Markets

[https://docs.centra.com/soap/index.php?op=events_GetByMarkets](https://docs.centra.com/soap/index.php?op=events_GetByMarkets)

This example uses the events_GetByMarkets operation to get order events from a specific market. The response contains an order from the wholesale store, and examples after this one will update the order.

Compared to the retail order event example, this uses events_GetByMarkets only to show an example of how it's used. You could use events_Get instead, and get order events from all markets.

Also compared to the retail order, this order does not have any shipment on it.

```eval_rst
.. warning:: Since a single order can trigger events multiple times (when the order is created, when shipment or refund is added, etc.), it is important to always check if an order with the same ID already exists in your ERP. If it does, you should update existing order with the new data. Otherwise you risk creating unnecessary duplicates.
```

## Request

```
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <events_GetByMarkets xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <type>order</type>
      <markets>
        <market>
          <id>Wholesale-Market</id>
        </market>
      </markets>
    </events_GetByMarkets>
  </soap:Body>
</soap:Envelope>
```

## Response

```
<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:events_Get>
      <ns1:events>
        <ns1:event>
          <ns1:id>121</ns1:id>
          <ns1:type>order</ns1:type>
          <ns1:entry>25</ns1:entry>
          <ns1:mission>update</ns1:mission>
          <ns1:date>2019-03-27 13:45:44</ns1:date>
          <ns1:data>
            <ns1:order>
              <ns1:id>25</ns1:id>
              <ns1:type>wholesale</ns1:type>
              <ns1:store>2</ns1:store>
              <ns1:status>pending</ns1:status>
              <ns1:currency>USD</ns1:currency>
              <ns1:currencyrate>9.18707</ns1:currencyrate>
              <ns1:basecurrency>SEK</ns1:basecurrency>
              <ns1:created>2019-03-26T18:32:35+01:00</ns1:created>
              <ns1:internal>false</ns1:internal>
              <ns1:preferred_shipping_date/>
              <ns1:buyer>
                <ns1:id>12345_buyer1</ns1:id>
                <ns1:firstname>Frist</ns1:firstname>
                <ns1:lastname>Last</ns1:lastname>
                <ns1:email>first.last@example.com</ns1:email>
              </ns1:buyer>
              <ns1:salesrep/>
              <ns1:account>
                <ns1:id>12345</ns1:id>
              </ns1:account>
              <ns1:paymentterms>
                <ns1:id>30NET</ns1:id>
                <ns1:description>30 Days</ns1:description>
              </ns1:paymentterms>
              <ns1:shippingterms>
                <ns1:id>DDU</ns1:id>
                <ns1:description>Delivered Duty Unpaid</ns1:description>
              </ns1:shippingterms>
              <ns1:collection>
                <ns1:id>XMAS</ns1:id>
                <ns1:description>X-Mas</ns1:description>
              </ns1:collection>
              <ns1:primary_warehouse>
                <ns1:warehouse>
                  <ns1:id>CW</ns1:id>
                </ns1:warehouse>
              </ns1:primary_warehouse>
              <ns1:shipping>
                <ns1:subtotal>123</ns1:subtotal>
                <ns1:description>France</ns1:description>
                <ns1:key/>
              </ns1:shipping>
              <ns1:payments>
                <ns1:type>inv</ns1:type>
                <ns1:total>0</ns1:total>
                <ns1:status>incomplete</ns1:status>
                <ns1:method/>
              </ns1:payments>
              <ns1:products>
                <ns1:product>
                  <ns1:id>PWC</ns1:id>
                  <ns1:tax>0.000</ns1:tax>
                  <ns1:sku/>
                  <ns1:origprice>700.00</ns1:origprice>
                  <ns1:price>700.00</ns1:price>
                  <ns1:discount>0</ns1:discount>
                  <ns1:qty>2</ns1:qty>
                  <ns1:subtotal>1400</ns1:subtotal>
                  <ns1:description>Plain wood chair</ns1:description>
                  <ns1:variation>
                    <ns1:id>PWC</ns1:id>
                    <ns1:description>Plain</ns1:description>
                  </ns1:variation>
                  <ns1:brand>
                    <ns1:id>Example</ns1:id>
                    <ns1:description>Example Brand</ns1:description>
                  </ns1:brand>
                  <ns1:sizes>
                    <ns1:size>
                      <ns1:id>OS</ns1:id>
                      <ns1:sku/>
                      <ns1:qty>2</ns1:qty>
                      <ns1:preorder>no</ns1:preorder>
                      <ns1:description/>
                      <ns1:orderitem>
                        <ns1:id>67</ns1:id>
                      </ns1:orderitem>
                      <ns1:warehouseitems>
                        <ns1:warehouse>
                          <ns1:id>OtherWarehouse</ns1:id>
                          <ns1:qty>2</ns1:qty>
                        </ns1:warehouse>
                      </ns1:warehouseitems>
                      <ns1:supplierorderitems/>
                    </ns1:size>
                  </ns1:sizes>
                  <ns1:comment/>
                </ns1:product>
                <ns1:product>
                  <ns1:id>T001</ns1:id>
                  <ns1:tax>0.000</ns1:tax>
                  <ns1:sku>TURTLE001</ns1:sku>
                  <ns1:origprice>67.00</ns1:origprice>
                  <ns1:price>67.00</ns1:price>
                  <ns1:discount>0</ns1:discount>
                  <ns1:qty>3</ns1:qty>
                  <ns1:subtotal>201</ns1:subtotal>
                  <ns1:description>Turtleneck sweater</ns1:description>
                  <ns1:variation>
                    <ns1:id>T001_BLUE</ns1:id>
                    <ns1:description>Blue</ns1:description>
                  </ns1:variation>
                  <ns1:brand>
                    <ns1:id>Example</ns1:id>
                    <ns1:description>Example Brand</ns1:description>
                  </ns1:brand>
                  <ns1:sizes>
                    <ns1:size>
                      <ns1:id>S</ns1:id>
                      <ns1:sku>01</ns1:sku>
                      <ns1:qty>1</ns1:qty>
                      <ns1:preorder>no</ns1:preorder>
                      <ns1:description>Small</ns1:description>
                      <ns1:orderitem>
                        <ns1:id>68</ns1:id>
                      </ns1:orderitem>
                      <ns1:warehouseitems>
                        <ns1:warehouse>
                          <ns1:id>MainWarehouse</ns1:id>
                          <ns1:qty>1</ns1:qty>
                        </ns1:warehouse>
                      </ns1:warehouseitems>
                      <ns1:supplierorderitems/>
                    </ns1:size>
                    <ns1:size>
                      <ns1:id>M</ns1:id>
                      <ns1:sku>02</ns1:sku>
                      <ns1:qty>2</ns1:qty>
                      <ns1:preorder>no</ns1:preorder>
                      <ns1:description>Medium</ns1:description>
                      <ns1:orderitem>
                        <ns1:id>69</ns1:id>
                      </ns1:orderitem>
                      <ns1:warehouseitems>
                        <ns1:warehouse>
                          <ns1:id>MainWarehouse</ns1:id>
                          <ns1:qty>2</ns1:qty>
                        </ns1:warehouse>
                      </ns1:warehouseitems>
                      <ns1:supplierorderitems/>
                    </ns1:size>
                  </ns1:sizes>
                  <ns1:comment/>
                </ns1:product>
                <ns1:product>
                  <ns1:id>T001</ns1:id>
                  <ns1:tax>0.000</ns1:tax>
                  <ns1:sku>TURTLE001</ns1:sku>
                  <ns1:origprice>45.00</ns1:origprice>
                  <ns1:price>45.00</ns1:price>
                  <ns1:discount>0</ns1:discount>
                  <ns1:qty>7</ns1:qty>
                  <ns1:subtotal>315</ns1:subtotal>
                  <ns1:description>Turtleneck sweater</ns1:description>
                  <ns1:variation>
                    <ns1:id>T001_RED</ns1:id>
                    <ns1:description>Red</ns1:description>
                  </ns1:variation>
                  <ns1:brand>
                    <ns1:id>Example</ns1:id>
                    <ns1:description>Example Brand</ns1:description>
                  </ns1:brand>
                  <ns1:sizes>
                    <ns1:size>
                      <ns1:id>M</ns1:id>
                      <ns1:sku>02</ns1:sku>
                      <ns1:qty>3</ns1:qty>
                      <ns1:preorder>no</ns1:preorder>
                      <ns1:description>Medium</ns1:description>
                      <ns1:orderitem>
                        <ns1:id>70</ns1:id>
                      </ns1:orderitem>
                      <ns1:warehouseitems>
                        <ns1:warehouse>
                          <ns1:id>MainWarehouse</ns1:id>
                          <ns1:qty>3</ns1:qty>
                        </ns1:warehouse>
                      </ns1:warehouseitems>
                      <ns1:supplierorderitems/>
                    </ns1:size>
                    <ns1:size>
                      <ns1:id>L</ns1:id>
                      <ns1:sku>03</ns1:sku>
                      <ns1:qty>4</ns1:qty>
                      <ns1:preorder>no</ns1:preorder>
                      <ns1:description>Large</ns1:description>
                      <ns1:orderitem>
                        <ns1:id>71</ns1:id>
                      </ns1:orderitem>
                      <ns1:warehouseitems>
                        <ns1:warehouse>
                          <ns1:id>MainWarehouse</ns1:id>
                          <ns1:qty>4</ns1:qty>
                        </ns1:warehouse>
                      </ns1:warehouseitems>
                      <ns1:supplierorderitems/>
                    </ns1:size>
                  </ns1:sizes>
                  <ns1:comment/>
                </ns1:product>
              </ns1:products>
              <ns1:cancelled/>
              <ns1:shipments/>
              <ns1:carrierinformation>
                <ns1:carrier/>
                <ns1:service/>
                <ns1:account/>
                <ns1:taxid/>
              </ns1:carrierinformation>
              <ns1:shippingaddress>
                <ns1:company>Example Warehouse</ns1:company>
                <ns1:attn>Person name</ns1:attn>
                <ns1:address1>Street 1</ns1:address1>
                <ns1:address2>Suite 123</ns1:address2>
                <ns1:city>City</ns1:city>
                <ns1:state>State</ns1:state>
                <ns1:zipcode>12345</ns1:zipcode>
                <ns1:country>FR</ns1:country>
                <ns1:email>info@example.com</ns1:email>
                <ns1:telephone>123 456 789</ns1:telephone>
                <ns1:fax/>
              </ns1:shippingaddress>
              <ns1:billingaddress>
                <ns1:company>Example Billing</ns1:company>
                <ns1:attn>Person name</ns1:attn>
                <ns1:address1>Street 1</ns1:address1>
                <ns1:address2>Suite 123</ns1:address2>
                <ns1:city>City</ns1:city>
                <ns1:state/>
                <ns1:zipcode>12345</ns1:zipcode>
                <ns1:country>SE</ns1:country>
                <ns1:email>info@example.com</ns1:email>
                <ns1:telephone>123 456 789</ns1:telephone>
                <ns1:fax/>
              </ns1:billingaddress>
              <ns1:internalinformation/>
              <ns1:other>The buyer can leave a message or special instructions here.</ns1:other>
              <ns1:ponumber>Example1</ns1:ponumber>
              <ns1:market>
                <ns1:id>Wholesale-Market</ns1:id>
                <ns1:description>Global</ns1:description>
              </ns1:market>
              <ns1:pricelist>
                <ns1:id>USD-Wholesale</ns1:id>
                <ns1:description>US Dollar</ns1:description>
              </ns1:pricelist>
            </ns1:order>
          </ns1:data>
        </ns1:event>
      </ns1:events>
    </ns1:events_Get>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```
