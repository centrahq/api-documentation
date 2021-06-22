# Product Data 4 - Bundle product example

Bundles behave like real products in terms of adding them to a selection, applying discounts and creating shipments. They do not exist in reality in the warehouse, but consist of multiple "real" products, which needs to be taken into consideration by the pick-and-pack staff.

Non-bundle products look exactly the same as they used to: they include SKU, quantity, specific variant and size, price, warehouse etc. For bundles (and bundled products) a new section called `<bundleinfo>` was introduced. For example, here's a snippet from an order including a bundle consisting of two actual products:

```xml
<products>
    <product>
        <id>5910</id>
        <sku>BP1</sku>
        ...
        <qty>1</qty>
        <description>Bundle Part 1</description>
        <variation>
            <id>7938</id>
            <description>Test variation 1</description>
        </variation>
        <sizes>
            <size>
                <id>129</id>
                <sku></sku>
                <qty>1</qty>
                <description>One Size</description>
                <orderitem>
                    <id>2882</id>
                </orderitem>
                ...
            </size>
        </sizes>
        <comment></comment>
        <bundleinfo>
            <isbundle>false</isbundle>
            <partof>
                <product>
                    <id>5925</id>
                </product>
            </partof>
        </bundleinfo>
    </product>
    <product>
        <id>5927</id>
        <sku>BP2</sku>
        ...
        <qty>1</qty>
        <description>Bundle Part 2</description>
        <variation>
            <id>7955</id>
            <description>Test variation 2</description>
        </variation>
        <sizes>
            <size>
                <id>129</id>
                <sku></sku>
                <qty>1</qty>
                <description>One Size</description>
                <orderitem>
                    <id>2883</id>
                </orderitem>
                ...
            </size>
        </sizes>
        <comment></comment>
        <bundleinfo>
            <isbundle>false</isbundle>
            <partof>
                <product>
                    <id>5925</id>
                </product>
            </partof>
        </bundleinfo>
    </product>
    <product>
        <id>5925</id>
        <sku>B-221</sku>
        ...
        <qty>1</qty>
        <subtotal>0</subtotal>
        <description>Bundle 221</description>
        <variation>
            <id>7953</id>
            <description></description>
        </variation>
        <sizes>
            <size>
                <id>129</id>
                <sku></sku>
                <qty>1</qty>
                <description>One Size</description>
                <orderitem>
                    <id>2884</id>
                </orderitem>
                ...
            </size>
        </sizes>
        <comment></comment>
        <bundleinfo>
            <isbundle>true</isbundle>
        </bundleinfo>
    </product>
</products>
```

As you can see, of the 3 items two are a part of the bundle and the last one is the actual bundle product. This can be easily recognised by the tag `<isbundle>true</isbundle>` on product `5925`. Two other products are not bundles, but parts of it - we call them "bundled products". You can see they are a part of bundle product 5925: `<partof><product><id>5925</...>`. This means that product 5925 (SKU: `B-221`) should be ignored by the pick-and-pack team, and the contents of the bundle should be collected by taking one of products 5910 (SKU: `BP1`) and 5927 (SKU: `BP2`) and packing them together.

To sum up, there are 3 types of products:  
1. Standard, non-bundle products with no `<bundleinfo>` tag,  
2. Virtual bundle product, recognised by `<isbundle>true</isbundle>` - not a product in a warehouse, but a collection of bundled products,  
3. Bundled product - part of a bundle - tagged `<isbundle>false</isbundle>` and including the ID of the parent bundle product. These are the real warehouse products that need to be picked and packed as part of the order.

```eval_rst
.. warning:: The minimum required handling of bundles for a working integration is to inspect the products for the `isbundle` tag and ignore those products. You should instruct your team to only pick and pack the bundled products.
```
