# Orders - Retail 1 - Event

[https://docs.centra.com/soap/index.php?op=events_Get](https://docs.centra.com/soap/index.php?op=events_Get)

This example uses the events_Get operation to get order events. The response contains an order from the retail store, and examples after this one will update the order.

Notice that order has a `<shipment>` on it. Sometimes Centra is configured to automatically create shipments for retail orders. It can also be configured to not do that, then you would need to create the shipment. (This is illustrated in the wholesale order examples).

## Request

- `<type>` limits the type of events you get. Using `all` will return all types.

```
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <events_GetRequest xmlns="http://www.centra.com/webservices/">
      <login>
        <username>example</username>
        <password>???</password>
      </login>
      <type>order</type>
    </events_GetRequest>
  </soap:Body>
</soap:Envelope>
```

## Response

On the `<event>` level

- `<id>` is the ID of the event itself. This is needed for the `events_Done` operation, the next example.
- `<type>` is the event type, the type of data inside `<data>`

On the `<order>` level

- This data is the same as the data you can send to the [https://docs.centra.com/soap/index.php?op=orders_Update](https://docs.centra.com/soap/index.php?op=orders_Update)
- `<id>` is the Centra order number


```
<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://www.centra.com/webservices/">
  <SOAP-ENV:Body>
    <ns1:events_Get>
      <ns1:events>
        <ns1:event>
          <ns1:id>115</ns1:id>
          <ns1:type>order</ns1:type>
          <ns1:entry>30</ns1:entry>
          <ns1:mission>update</ns1:mission>
          <ns1:date>2019-03-27 12:52:20</ns1:date>
          <ns1:data>
            <ns1:order>
              <ns1:id>30</ns1:id>
              <ns1:type>retail</ns1:type>
              <ns1:store>1</ns1:store>
              <ns1:status>processing</ns1:status>
              <ns1:currency>EUR</ns1:currency>
              <ns1:currencyrate>10.43100</ns1:currencyrate>
              <ns1:basecurrency>SEK</ns1:basecurrency>
              <ns1:created>2019-03-27T12:52:20+01:00</ns1:created>
              <ns1:internal>false</ns1:internal>
              <ns1:preferred_shipping_date/>
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
                <ns1:subtotal>12</ns1:subtotal>
                <ns1:description>Sweden</ns1:description>
                <ns1:key>eur</ns1:key>
              </ns1:shipping>
              <ns1:payments>
                <ns1:name>dibs-window</ns1:name>
                <ns1:type>cc</ns1:type>
                <ns1:total>0</ns1:total>
                <ns1:status>incomplete</ns1:status>
                <ns1:method>test</ns1:method>
                <ns1:payment>
                  <ns1:type>auth</ns1:type>
                  <ns1:value>1135</ns1:value>
                  <ns1:created>2019-03-27T12:52:20+01:00</ns1:created>
                  <ns1:transaction>2404544843</ns1:transaction>
                </ns1:payment>
              </ns1:payments>
              <ns1:products>
                <ns1:product>
                  <ns1:id>PWC</ns1:id>
                  <ns1:tax>25.000</ns1:tax>
                  <ns1:sku/>
                  <ns1:origprice>1000.00</ns1:origprice>
                  <ns1:price>1000.00</ns1:price>
                  <ns1:discount>0</ns1:discount>
                  <ns1:qty>1</ns1:qty>
                  <ns1:subtotal>1000</ns1:subtotal>
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
                      <ns1:qty>1</ns1:qty>
                      <ns1:preorder>no</ns1:preorder>
                      <ns1:description/>
                      <ns1:orderitem>
                        <ns1:id>80</ns1:id>
                      </ns1:orderitem>
                      <ns1:warehouseitems>
                        <ns1:warehouse>
                          <ns1:id>OtherWarehouse</ns1:id>
                          <ns1:qty>1</ns1:qty>
                        </ns1:warehouse>
                      </ns1:warehouseitems>
                      <ns1:supplierorderitems/>
                    </ns1:size>
                  </ns1:sizes>
                  <ns1:comment/>
                </ns1:product>
                <ns1:product>
                  <ns1:id>T001</ns1:id>
                  <ns1:tax>25.000</ns1:tax>
                  <ns1:sku>TURTLE001</ns1:sku>
                  <ns1:origprice>123.00</ns1:origprice>
                  <ns1:price>123.00</ns1:price>
                  <ns1:discount>0</ns1:discount>
                  <ns1:qty>1</ns1:qty>
                  <ns1:subtotal>123</ns1:subtotal>
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
                      <ns1:id>S</ns1:id>
                      <ns1:sku>01</ns1:sku>
                      <ns1:qty>1</ns1:qty>
                      <ns1:preorder>no</ns1:preorder>
                      <ns1:description>Small</ns1:description>
                      <ns1:orderitem>
                        <ns1:id>81</ns1:id>
                      </ns1:orderitem>
                      <ns1:warehouseitems>
                        <ns1:warehouse>
                          <ns1:id>MainWarehouse</ns1:id>
                          <ns1:qty>1</ns1:qty>
                        </ns1:warehouse>
                      </ns1:warehouseitems>
                      <ns1:supplierorderitems/>
                    </ns1:size>
                  </ns1:sizes>
                  <ns1:comment/>
                </ns1:product>
              </ns1:products>
              <ns1:cancelled/>
              <ns1:shipments>
                <ns1:shipment>
                  <ns1:id>8</ns1:id>
                  <ns1:paid>no</ns1:paid>
                  <ns1:shipped>no</ns1:shipped>
                  <ns1:goodtogo>yes</ns1:goodtogo>
                  <ns1:appendix>1</ns1:appendix>
                  <ns1:shipmenttotal>1135.00</ns1:shipmenttotal>
                  <ns1:paidtotal>0.00</ns1:paidtotal>
                  <ns1:currency>EUR</ns1:currency>
                  <ns1:currencyrate>10.43100</ns1:currencyrate>
                  <ns1:basecurrency>SEK</ns1:basecurrency>
                  <ns1:created>2019-03-27T12:52:20+01:00</ns1:created>
                  <ns1:shippingaddress>
                    <ns1:firstname>Example</ns1:firstname>
                    <ns1:lastname>Person</ns1:lastname>
                    <ns1:address1>Teststreet 123</ns1:address1>
                    <ns1:address2/>
                    <ns1:city>Testcity</ns1:city>
                    <ns1:state/>
                    <ns1:zipcode>12345</ns1:zipcode>
                    <ns1:country>SE</ns1:country>
                    <ns1:email>someone@example.com</ns1:email>
                    <ns1:telephone>123456789</ns1:telephone>
                  </ns1:shippingaddress>
                  <ns1:carrierinformation>
                    <ns1:carrier/>
                    <ns1:service/>
                    <ns1:tracking/>
                    <ns1:packages>0</ns1:packages>
                  </ns1:carrierinformation>
                  <ns1:products>
                    <ns1:product>
                      <ns1:id>PWC</ns1:id>
                      <ns1:tax>25.000</ns1:tax>
                      <ns1:sku/>
                      <ns1:origprice>1000.00</ns1:origprice>
                      <ns1:price>1000.00</ns1:price>
                      <ns1:discount>0</ns1:discount>
                      <ns1:qty>1</ns1:qty>
                      <ns1:subtotal>1000</ns1:subtotal>
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
                          <ns1:qty>1</ns1:qty>
                          <ns1:preorder>no</ns1:preorder>
                          <ns1:description/>
                          <ns1:orderitem>
                            <ns1:id>80</ns1:id>
                          </ns1:orderitem>
                        </ns1:size>
                      </ns1:sizes>
                      <ns1:comment/>
                    </ns1:product>
                    <ns1:product>
                      <ns1:id>T001</ns1:id>
                      <ns1:tax>25.000</ns1:tax>
                      <ns1:sku>TURTLE001</ns1:sku>
                      <ns1:origprice>123.00</ns1:origprice>
                      <ns1:price>123.00</ns1:price>
                      <ns1:discount>0</ns1:discount>
                      <ns1:qty>1</ns1:qty>
                      <ns1:subtotal>123</ns1:subtotal>
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
                          <ns1:id>S</ns1:id>
                          <ns1:sku>01</ns1:sku>
                          <ns1:qty>1</ns1:qty>
                          <ns1:preorder>no</ns1:preorder>
                          <ns1:description>Small</ns1:description>
                          <ns1:orderitem>
                            <ns1:id>81</ns1:id>
                          </ns1:orderitem>
                        </ns1:size>
                      </ns1:sizes>
                      <ns1:comment/>
                    </ns1:product>
                  </ns1:products>
                  <ns1:refunds/>
                  <ns1:shipping>
                    <ns1:subtotal>12</ns1:subtotal>
                  </ns1:shipping>
                  <ns1:handling>
                    <ns1:subtotal>0.00</ns1:subtotal>
                  </ns1:handling>
                  <ns1:voucher>
                    <ns1:subtotal>0</ns1:subtotal>
                  </ns1:voucher>
                </ns1:shipment>
              </ns1:shipments>
              <ns1:carrierinformation>
                <ns1:carrier/>
                <ns1:service/>
                <ns1:account/>
                <ns1:taxid/>
              </ns1:carrierinformation>
              <ns1:customer>
                <ns1:id>20</ns1:id>
              </ns1:customer>
              <ns1:shippingaddress>
                <ns1:firstname>Example</ns1:firstname>
                <ns1:lastname>Person</ns1:lastname>
                <ns1:address1>Teststreet 123</ns1:address1>
                <ns1:address2/>
                <ns1:city>Testcity</ns1:city>
                <ns1:state/>
                <ns1:zipcode>12345</ns1:zipcode>
                <ns1:country>SE</ns1:country>
                <ns1:email>someone@example.com</ns1:email>
                <ns1:telephone>123456789</ns1:telephone>
              </ns1:shippingaddress>
              <ns1:billingaddress>
                <ns1:firstname>Example</ns1:firstname>
                <ns1:lastname>Person</ns1:lastname>
                <ns1:address1>Teststreet 123</ns1:address1>
                <ns1:address2/>
                <ns1:city>Testcity</ns1:city>
                <ns1:state/>
                <ns1:zipcode>12345</ns1:zipcode>
                <ns1:country>SE</ns1:country>
                <ns1:email>someone@example.com</ns1:email>
                <ns1:telephone>123456789</ns1:telephone>
              </ns1:billingaddress>
              <ns1:internalinformation/>
              <ns1:other/>
              <ns1:market>
                <ns1:id>Retail-Sweden</ns1:id>
                <ns1:description>Sweden</ns1:description>
              </ns1:market>
              <ns1:pricelist>
                <ns1:id>EUR-Retail</ns1:id>
                <ns1:description>Euro</ns1:description>
              </ns1:pricelist>
            </ns1:order>
          </ns1:data>
        </ns1:event>
      </ns1:events>
    </ns1:events_Get>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
```