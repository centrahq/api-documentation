---
title: Checkout API order flow
altTitle: API order flow
excerpt: See all API requests and responses that make up the process of creating an order in Centra's Checkout API
taxonomy:
  category: docs
---

Here's the basic happy-path order flow in Checkout API.

## Create selection - add items to selection

`POST {{url}}/api/checkout/items/1-1`

Creates a new selection (equivalent to a "basket") when a first item is added. `1-1` translates to `display ID 1`-`size ID 1`.

### API response

```json
{
    "token": "0ft2kmhg80tlkgq26fq4840vkp",
    "selection": {
        "language": null,
        "currency": "SEK",
        "paymentMethod": "dummy-first",
        "paymentMethodName": "first dummy payment",
        "shippingMethod": "",
        "shippingMethodName": "",
        "items": [
            {
                "item": "1-1",
                "productUrl": null,
                "category": null,
                "size": "",
                "sku": "123456789",
                "ean": "ABCDEFGHIJKL",
                "quantity": 2,
                "line": "0a6d0c85c097bffdd54ad0cac52b3435",
                "priceEach": "100.00 SEK",
                "priceEachAsNumber": 100,
                "totalPrice": "200.00 SEK",
                "totalPriceAsNumber": 200,
                "priceEachBeforeDiscount": "100.00 SEK",
                "priceEachBeforeDiscountAsNumber": 100,
                "anyDiscount": false,
                "taxPercent": 0,
                "priceEachWithoutTax": "100.00 SEK",
                "priceEachWithoutTaxAsNumber": 100,
                "priceEachReduction": "0.00 SEK",
                "priceEachReductionAsNumber": 0,
                "product": {
                    "product": "1",
                    "name": "Test Product",
                    "uri": "test-product",
                    "sku": "123456",
                    "productSku": "123",
                    "brand": "1",
                    "brandName": "Brand",
                    "brandUri": "brand",
                    "collection": "1",
                    "collectionName": "Collection",
                    "collectionUri": "collection",
                    "variantName": "Red",
                    "countryOrigin": "",
                    "excerpt": "",
                    "excerptHtml": "",
                    "description": "",
                    "descriptionHtml": "",
                    "metaTitle": "",
                    "metaDescription": "",
                    "metaKeywords": "",
                    "stockUnit": "",
                    "category": "1",
                    "centraProduct": "1",
                    "centraVariant": "1445",
                    "itemQuantityMinimum": 1,
                    "itemQuantityMultipleOf": 1,
                    "price": "100.00 SEK",
                    "priceAsNumber": 100,
                    "priceBeforeDiscount": "100.00 SEK",
                    "priceBeforeDiscountAsNumber": 100,
                    "discountPercent": 0,
                    "showAsOnSale": false,
                    "showAsNew": false,
                    "itemTable": {
                        "x": [
                            ""
                        ],
                        "y": [],
                        "dividerSymbol": "x"
                    },
                    "items": [
                        {
                            "item": "1-1",
                            "itemTableX": 0,
                            "itemTableY": 0,
                            "name": "",
                            "ean": "ABCDEFGHIJKL",
                            "sku": "123456789"
                        }
                    ],
                    "categoryName": [
                        "Shop"
                    ],
                    "categoryUri": "shop",
                    "media": [],
                    "presets": {
                        "prepacks": [],
                        "distributions": []
                    },
                    "tableMappings": {
                        "Size comment": {
                            "unit": "Size comment",
                            "x": [
                                "123"
                            ],
                            "y": [],
                            "dividerSymbol": "x"
                        }
                    },
                    "sh_color_text": 123,
                    "sh_tanning": "Dark tan"
                }
            }
        ],
        "discounts": {
            "anyDiscount": false,
            "discount": "0.00 SEK",
            "discountAsNumber": 0,
            "vouchers": [],
            "automaticDiscounts": []
        },
        "totals": {
            "itemsTotalPrice": "200.00 SEK",
            "itemsTotalPriceAsNumber": 200,
            "totalDiscountPrice": false,
            "totalDiscountPriceAsNumber": false,
            "shippingPrice": "0.00 SEK",
            "shippingPriceAsNumber": 0,
            "handlingCostPrice": "13.00 SEK",
            "handlingCostPriceAsNumber": 13,
            "totalQuantity": 2,
            "taxDeducted": false,
            "taxDeductedAsNumber": false,
            "taxAdded": false,
            "taxAddedAsNumber": false,
            "taxPercent": 0,
            "grandTotalPrice": "213.00 SEK",
            "grandTotalPriceAsNumber": 213,
            "grandTotalPriceTax": "0.00 SEK",
            "grandTotalPriceTaxAsNumber": 0
        },
        "vatExempt": false,
        "address": {
            "firstName": "",
            "lastName": "",
            "email": "",
            "phoneNumber": "",
            "company": "",
            "address1": "",
            "address2": "",
            "zipCode": "",
            "city": "",
            "state": "",
            "country": "",
            "vatNumber": ""
        },
        "shippingAddress": {
            "firstName": "",
            "lastName": "",
            "email": "",
            "phoneNumber": "",
            "company": "",
            "address1": "",
            "address2": "",
            "zipCode": "",
            "city": "",
            "state": "",
            "country": "",
            "vatNumber": ""
        },
        "additionalNotes": "",
        "currencyFormat": {
            "currency": "SEK",
            "name": "SEK",
            "prefix": "",
            "suffix": " SEK",
            "decimalPoint": ".",
            "decimalDigits": "2",
            "uri": "sek"
        }
    },
    "language": [
        {
            "language": "en",
            "name": "English"
        },
        {
            "language": "de",
            "name": "German"
        },
        {
            "language": "sv",
            "name": "Swedish"
        }
    ],
    "paymentMethods": [
        {
            "paymentMethod": "dummy-first",
            "name": "first dummy payment",
            "handlingCost": "13.00 SEK",
            "handlingCostAsNumber": 13
        },
        {
            "paymentMethod": "adyen",
            "name": "Adyen",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "adyen-checkout",
            "name": "Adyen Checkout",
            "clientSide": {
                "externalScript": "https://checkoutshopper-test.adyen.com/checkoutshopper/assets/js/sdk/checkoutSDK.1.9.5.min.js"
            },
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dibs-paywin",
            "name": "dibs",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy",
            "name": "dummy",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy-url",
            "name": "dummy",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy-direct",
            "name": "dummy",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy-double",
            "name": "dummy se",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "epayv2",
            "name": "ePay",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "kco3",
            "name": "kco3",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "stripe-checkout",
            "name": "Stripe Checkout",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "stripe-pi",
            "name": "Stripe Payments",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        }
    ],
    "paymentFields": {
        "termsAndConditions": {
            "type": "boolean",
            "required": true,
            "visible": true
        },
        "address": {
            "email": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "company": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "firstName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "lastName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address1": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address2": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "zipCode": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "city": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "state": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "country": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "phoneNumber": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "identityNumber": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "vatNumber": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "houseNumber": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "houseExtension": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "newsletter": {
                "type": "boolean",
                "required": false,
                "visible": true
            }
        },
        "shippingAddress": {
            "email": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "company": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "firstName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "lastName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address1": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address2": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "zipCode": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "city": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "state": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "country": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "phoneNumber": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "houseNumber": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "houseExtension": {
                "type": "string",
                "required": false,
                "visible": false
            }
        }
    },
    "shippingMethods": [],
    "countries": [
        {
            "country": "JP",
            "name": "Japan",
            "eu": false,
            "language": "en",
            "currency": "JPY"
        },
        {
            "country": "SE",
            "name": "Sweden",
            "eu": true,
            "language": "sv",
            "currency": "SEK"
        },
        {
            "country": "US",
            "name": "United States",
            "eu": false,
            "language": "en",
            "states": [
                {
                    "state": "AL",
                    "name": "Alabama"
                },
                {
                    "state": "AK",
                    "name": "Alaska"
                },
                {
                    "state": "AZ",
                    "name": "Arizona"
                },
                {
                    "state": "AR",
                    "name": "Arkansas"
                },
                {
                    "state": "CA",
                    "name": "California"
                },
                {
                    "state": "CO",
                    "name": "Colorado"
                },
                {
                    "state": "CT",
                    "name": "Connecticut"
                },
                {
                    "state": "DE",
                    "name": "Delaware"
                },
                {
                    "state": "DC",
                    "name": "District of Columbia"
                },
                {
                    "state": "FL",
                    "name": "Florida"
                },
                {
                    "state": "GA",
                    "name": "Georgia"
                },
                {
                    "state": "HI",
                    "name": "Hawaii"
                },
                {
                    "state": "ID",
                    "name": "Idaho"
                },
                {
                    "state": "IL",
                    "name": "Illinois"
                },
                {
                    "state": "IN",
                    "name": "Indiana"
                },
                {
                    "state": "IA",
                    "name": "Iowa"
                },
                {
                    "state": "KS",
                    "name": "Kansas"
                },
                {
                    "state": "KY",
                    "name": "Kentucky"
                },
                {
                    "state": "LA",
                    "name": "Louisiana"
                },
                {
                    "state": "ME",
                    "name": "Maine"
                },
                {
                    "state": "MD",
                    "name": "Maryland"
                },
                {
                    "state": "MA",
                    "name": "Massachusetts"
                },
                {
                    "state": "MI",
                    "name": "Michigan"
                },
                {
                    "state": "MN",
                    "name": "Minnesota"
                },
                {
                    "state": "MS",
                    "name": "Mississippi"
                },
                {
                    "state": "MO",
                    "name": "Missouri"
                },
                {
                    "state": "MT",
                    "name": "Montana"
                },
                {
                    "state": "NE",
                    "name": "Nebraska"
                },
                {
                    "state": "NV",
                    "name": "Nevada"
                },
                {
                    "state": "NH",
                    "name": "New Hampshire"
                },
                {
                    "state": "NJ",
                    "name": "New Jersey"
                },
                {
                    "state": "NM",
                    "name": "New Mexico"
                },
                {
                    "state": "NY",
                    "name": "New York"
                },
                {
                    "state": "NC",
                    "name": "North Carolina"
                },
                {
                    "state": "ND",
                    "name": "North Dakota"
                },
                {
                    "state": "OH",
                    "name": "Ohio"
                },
                {
                    "state": "OK",
                    "name": "Oklahoma"
                },
                {
                    "state": "OR",
                    "name": "Oregon"
                },
                {
                    "state": "PA",
                    "name": "Pennsylvania"
                },
                {
                    "state": "RI",
                    "name": "Rhode Island"
                },
                {
                    "state": "SC",
                    "name": "South Carolina"
                },
                {
                    "state": "SD",
                    "name": "South Dakota"
                },
                {
                    "state": "TN",
                    "name": "Tennessee"
                },
                {
                    "state": "TX",
                    "name": "Texas"
                },
                {
                    "state": "UT",
                    "name": "Utah"
                },
                {
                    "state": "VT",
                    "name": "Vermont"
                },
                {
                    "state": "VA",
                    "name": "Virginia"
                },
                {
                    "state": "WA",
                    "name": "Washington"
                },
                {
                    "state": "WV",
                    "name": "West Virginia"
                },
                {
                    "state": "WI",
                    "name": "Wisconsin"
                },
                {
                    "state": "WY",
                    "name": "Wyoming"
                }
            ],
            "currency": "USD"
        }
    ],
    "location": {
        "country": null,
        "name": "",
        "state": null,
        "stateName": "",
        "eu": false,
        "shipTo": false,
        "language": "en"
    }
}
```

## Add another product to selection

`POST {{url}}/api/checkout/items/1-1`

Adding another item to selection, because we can.

### API response

```json
{
    "token": "0ft2kmhg80tlkgq26fq4840vkp",
    "selection": {
        "language": null,
        "currency": "SEK",
        "paymentMethod": "dummy-first",
        "paymentMethodName": "first dummy payment",
        "shippingMethod": "",
        "shippingMethodName": "",
        "items": [
            {
                "item": "1-1",
                "productUrl": null,
                "category": null,
                "size": "",
                "sku": "123456789",
                "ean": "ABCDEFGHIJKL",
                "quantity": 3,
                "line": "0a6d0c85c097bffdd54ad0cac52b3435",
                "priceEach": "100.00 SEK",
                "priceEachAsNumber": 100,
                "totalPrice": "300.00 SEK",
                "totalPriceAsNumber": 300,
                "priceEachBeforeDiscount": "100.00 SEK",
                "priceEachBeforeDiscountAsNumber": 100,
                "anyDiscount": false,
                "taxPercent": 0,
                "priceEachWithoutTax": "100.00 SEK",
                "priceEachWithoutTaxAsNumber": 100,
                "priceEachReduction": "0.00 SEK",
                "priceEachReductionAsNumber": 0,
                "product": {
                    "product": "1",
                    "name": "Test Product",
                    "uri": "test-product",
                    "sku": "123456",
                    "productSku": "123",
                    "brand": "1",
                    "brandName": "Brand",
                    "brandUri": "brand",
                    "collection": "1",
                    "collectionName": "Collection",
                    "collectionUri": "collection",
                    "variantName": "Red",
                    "countryOrigin": "",
                    "excerpt": "",
                    "excerptHtml": "",
                    "description": "",
                    "descriptionHtml": "",
                    "metaTitle": "",
                    "metaDescription": "",
                    "metaKeywords": "",
                    "stockUnit": "",
                    "category": "1",
                    "centraProduct": "1",
                    "centraVariant": "1445",
                    "itemQuantityMinimum": 1,
                    "itemQuantityMultipleOf": 1,
                    "price": "100.00 SEK",
                    "priceAsNumber": 100,
                    "priceBeforeDiscount": "100.00 SEK",
                    "priceBeforeDiscountAsNumber": 100,
                    "discountPercent": 0,
                    "showAsOnSale": false,
                    "showAsNew": false,
                    "itemTable": {
                        "x": [
                            ""
                        ],
                        "y": [],
                        "dividerSymbol": "x"
                    },
                    "items": [
                        {
                            "item": "1-1",
                            "itemTableX": 0,
                            "itemTableY": 0,
                            "name": "",
                            "ean": "ABCDEFGHIJKL",
                            "sku": "123456789"
                        }
                    ],
                    "categoryName": [
                        "Shop"
                    ],
                    "categoryUri": "shop",
                    "media": [],
                    "presets": {
                        "prepacks": [],
                        "distributions": []
                    },
                    "tableMappings": {
                        "Size comment": {
                            "unit": "Size comment",
                            "x": [
                                "123"
                            ],
                            "y": [],
                            "dividerSymbol": "x"
                        }
                    },
                    "sh_color_text": 123,
                    "sh_tanning": "Dark tan"
                }
            }
        ],
        "discounts": {
            "anyDiscount": false,
            "discount": "0.00 SEK",
            "discountAsNumber": 0,
            "vouchers": [],
            "automaticDiscounts": []
        },
        "totals": {
            "itemsTotalPrice": "300.00 SEK",
            "itemsTotalPriceAsNumber": 300,
            "totalDiscountPrice": false,
            "totalDiscountPriceAsNumber": false,
            "shippingPrice": "0.00 SEK",
            "shippingPriceAsNumber": 0,
            "handlingCostPrice": "13.00 SEK",
            "handlingCostPriceAsNumber": 13,
            "totalQuantity": 3,
            "taxDeducted": false,
            "taxDeductedAsNumber": false,
            "taxAdded": false,
            "taxAddedAsNumber": false,
            "taxPercent": 0,
            "grandTotalPrice": "313.00 SEK",
            "grandTotalPriceAsNumber": 313,
            "grandTotalPriceTax": "0.00 SEK",
            "grandTotalPriceTaxAsNumber": 0
        },
        "vatExempt": false,
        "address": {
            "firstName": "",
            "lastName": "",
            "email": "",
            "phoneNumber": "",
            "company": "",
            "address1": "",
            "address2": "",
            "zipCode": "",
            "city": "",
            "state": "",
            "country": "",
            "vatNumber": ""
        },
        "shippingAddress": {
            "firstName": "",
            "lastName": "",
            "email": "",
            "phoneNumber": "",
            "company": "",
            "address1": "",
            "address2": "",
            "zipCode": "",
            "city": "",
            "state": "",
            "country": "",
            "vatNumber": ""
        },
        "additionalNotes": "",
        "currencyFormat": {
            "currency": "SEK",
            "name": "SEK",
            "prefix": "",
            "suffix": " SEK",
            "decimalPoint": ".",
            "decimalDigits": "2",
            "uri": "sek"
        }
    },
    "language": [
        {
            "language": "en",
            "name": "English"
        },
        {
            "language": "de",
            "name": "German"
        },
        {
            "language": "sv",
            "name": "Swedish"
        }
    ],
    "paymentMethods": [
        {
            "paymentMethod": "dummy-first",
            "name": "first dummy payment",
            "handlingCost": "13.00 SEK",
            "handlingCostAsNumber": 13
        },
        {
            "paymentMethod": "adyen",
            "name": "Adyen",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "adyen-checkout",
            "name": "Adyen Checkout",
            "clientSide": {
                "externalScript": "https://checkoutshopper-test.adyen.com/checkoutshopper/assets/js/sdk/checkoutSDK.1.9.5.min.js"
            },
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dibs-paywin",
            "name": "dibs",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy",
            "name": "dummy",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy-url",
            "name": "dummy",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy-direct",
            "name": "dummy",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy-double",
            "name": "dummy se",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "epayv2",
            "name": "ePay",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "kco3",
            "name": "kco3",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "stripe-checkout",
            "name": "Stripe Checkout",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "stripe-pi",
            "name": "Stripe Payments",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        }
    ],
    "paymentFields": {
        "termsAndConditions": {
            "type": "boolean",
            "required": true,
            "visible": true
        },
        "address": {
            "email": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "company": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "firstName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "lastName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address1": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address2": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "zipCode": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "city": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "state": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "country": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "phoneNumber": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "identityNumber": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "vatNumber": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "houseNumber": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "houseExtension": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "newsletter": {
                "type": "boolean",
                "required": false,
                "visible": true
            }
        },
        "shippingAddress": {
            "email": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "company": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "firstName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "lastName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address1": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address2": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "zipCode": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "city": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "state": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "country": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "phoneNumber": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "houseNumber": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "houseExtension": {
                "type": "string",
                "required": false,
                "visible": false
            }
        }
    },
    "shippingMethods": [],
    "countries": [
        {
            "country": "JP",
            "name": "Japan",
            "eu": false,
            "language": "en",
            "currency": "JPY"
        },
        {
            "country": "SE",
            "name": "Sweden",
            "eu": true,
            "language": "sv",
            "currency": "SEK"
        },
        {
            "country": "US",
            "name": "United States",
            "eu": false,
            "language": "en",
            "states": [
                {
                    "state": "AL",
                    "name": "Alabama"
                },
                {
                    "state": "AK",
                    "name": "Alaska"
                },
                {
                    "state": "AZ",
                    "name": "Arizona"
                },
                {
                    "state": "AR",
                    "name": "Arkansas"
                },
                {
                    "state": "CA",
                    "name": "California"
                },
                {
                    "state": "CO",
                    "name": "Colorado"
                },
                {
                    "state": "CT",
                    "name": "Connecticut"
                },
                {
                    "state": "DE",
                    "name": "Delaware"
                },
                {
                    "state": "DC",
                    "name": "District of Columbia"
                },
                {
                    "state": "FL",
                    "name": "Florida"
                },
                {
                    "state": "GA",
                    "name": "Georgia"
                },
                {
                    "state": "HI",
                    "name": "Hawaii"
                },
                {
                    "state": "ID",
                    "name": "Idaho"
                },
                {
                    "state": "IL",
                    "name": "Illinois"
                },
                {
                    "state": "IN",
                    "name": "Indiana"
                },
                {
                    "state": "IA",
                    "name": "Iowa"
                },
                {
                    "state": "KS",
                    "name": "Kansas"
                },
                {
                    "state": "KY",
                    "name": "Kentucky"
                },
                {
                    "state": "LA",
                    "name": "Louisiana"
                },
                {
                    "state": "ME",
                    "name": "Maine"
                },
                {
                    "state": "MD",
                    "name": "Maryland"
                },
                {
                    "state": "MA",
                    "name": "Massachusetts"
                },
                {
                    "state": "MI",
                    "name": "Michigan"
                },
                {
                    "state": "MN",
                    "name": "Minnesota"
                },
                {
                    "state": "MS",
                    "name": "Mississippi"
                },
                {
                    "state": "MO",
                    "name": "Missouri"
                },
                {
                    "state": "MT",
                    "name": "Montana"
                },
                {
                    "state": "NE",
                    "name": "Nebraska"
                },
                {
                    "state": "NV",
                    "name": "Nevada"
                },
                {
                    "state": "NH",
                    "name": "New Hampshire"
                },
                {
                    "state": "NJ",
                    "name": "New Jersey"
                },
                {
                    "state": "NM",
                    "name": "New Mexico"
                },
                {
                    "state": "NY",
                    "name": "New York"
                },
                {
                    "state": "NC",
                    "name": "North Carolina"
                },
                {
                    "state": "ND",
                    "name": "North Dakota"
                },
                {
                    "state": "OH",
                    "name": "Ohio"
                },
                {
                    "state": "OK",
                    "name": "Oklahoma"
                },
                {
                    "state": "OR",
                    "name": "Oregon"
                },
                {
                    "state": "PA",
                    "name": "Pennsylvania"
                },
                {
                    "state": "RI",
                    "name": "Rhode Island"
                },
                {
                    "state": "SC",
                    "name": "South Carolina"
                },
                {
                    "state": "SD",
                    "name": "South Dakota"
                },
                {
                    "state": "TN",
                    "name": "Tennessee"
                },
                {
                    "state": "TX",
                    "name": "Texas"
                },
                {
                    "state": "UT",
                    "name": "Utah"
                },
                {
                    "state": "VT",
                    "name": "Vermont"
                },
                {
                    "state": "VA",
                    "name": "Virginia"
                },
                {
                    "state": "WA",
                    "name": "Washington"
                },
                {
                    "state": "WV",
                    "name": "West Virginia"
                },
                {
                    "state": "WI",
                    "name": "Wisconsin"
                },
                {
                    "state": "WY",
                    "name": "Wyoming"
                }
            ],
            "currency": "USD"
        }
    ],
    "location": {
        "country": null,
        "name": "",
        "state": null,
        "stateName": "",
        "eu": false,
        "shipTo": false,
        "language": "en"
    }
}
```

## Show selection

`GET {{url}}/api/checkout/selection`

View the selection, perhaps to review it on the Checkout page.

### API response

```json
{
    "token": "0ft2kmhg80tlkgq26fq4840vkp",
    "selection": {
        "language": null,
        "currency": "SEK",
        "paymentMethod": "dummy-first",
        "paymentMethodName": "first dummy payment",
        "shippingMethod": "",
        "shippingMethodName": "",
        "items": [
            {
                "item": "1-1",
                "productUrl": null,
                "category": null,
                "size": "",
                "sku": "123456789",
                "ean": "ABCDEFGHIJKL",
                "quantity": 3,
                "line": "0a6d0c85c097bffdd54ad0cac52b3435",
                "priceEach": "100.00 SEK",
                "priceEachAsNumber": 100,
                "totalPrice": "300.00 SEK",
                "totalPriceAsNumber": 300,
                "priceEachBeforeDiscount": "100.00 SEK",
                "priceEachBeforeDiscountAsNumber": 100,
                "anyDiscount": false,
                "taxPercent": 0,
                "priceEachWithoutTax": "100.00 SEK",
                "priceEachWithoutTaxAsNumber": 100,
                "priceEachReduction": "0.00 SEK",
                "priceEachReductionAsNumber": 0,
                "product": {
                    "product": "1",
                    "name": "Test Product",
                    "uri": "test-product",
                    "sku": "123456",
                    "productSku": "123",
                    "brand": "1",
                    "brandName": "Brand",
                    "brandUri": "brand",
                    "collection": "1",
                    "collectionName": "Collection",
                    "collectionUri": "collection",
                    "variantName": "Red",
                    "countryOrigin": "",
                    "excerpt": "",
                    "excerptHtml": "",
                    "description": "",
                    "descriptionHtml": "",
                    "metaTitle": "",
                    "metaDescription": "",
                    "metaKeywords": "",
                    "stockUnit": "",
                    "category": "1",
                    "centraProduct": "1",
                    "centraVariant": "1445",
                    "itemQuantityMinimum": 1,
                    "itemQuantityMultipleOf": 1,
                    "price": "100.00 SEK",
                    "priceAsNumber": 100,
                    "priceBeforeDiscount": "100.00 SEK",
                    "priceBeforeDiscountAsNumber": 100,
                    "discountPercent": 0,
                    "showAsOnSale": false,
                    "showAsNew": false,
                    "itemTable": {
                        "x": [
                            ""
                        ],
                        "y": [],
                        "dividerSymbol": "x"
                    },
                    "items": [
                        {
                            "item": "1-1",
                            "itemTableX": 0,
                            "itemTableY": 0,
                            "name": "",
                            "ean": "ABCDEFGHIJKL",
                            "sku": "123456789"
                        }
                    ],
                    "categoryName": [
                        "Shop"
                    ],
                    "categoryUri": "shop",
                    "media": [],
                    "presets": {
                        "prepacks": [],
                        "distributions": []
                    },
                    "tableMappings": {
                        "Size comment": {
                            "unit": "Size comment",
                            "x": [
                                "123"
                            ],
                            "y": [],
                            "dividerSymbol": "x"
                        }
                    },
                    "sh_color_text": 123,
                    "sh_tanning": "Dark tan"
                }
            }
        ],
        "discounts": {
            "anyDiscount": false,
            "discount": "0.00 SEK",
            "discountAsNumber": 0,
            "vouchers": [],
            "automaticDiscounts": []
        },
        "totals": {
            "itemsTotalPrice": "300.00 SEK",
            "itemsTotalPriceAsNumber": 300,
            "totalDiscountPrice": false,
            "totalDiscountPriceAsNumber": false,
            "shippingPrice": "0.00 SEK",
            "shippingPriceAsNumber": 0,
            "handlingCostPrice": "13.00 SEK",
            "handlingCostPriceAsNumber": 13,
            "totalQuantity": 3,
            "taxDeducted": false,
            "taxDeductedAsNumber": false,
            "taxAdded": false,
            "taxAddedAsNumber": false,
            "taxPercent": 0,
            "grandTotalPrice": "313.00 SEK",
            "grandTotalPriceAsNumber": 313,
            "grandTotalPriceTax": "0.00 SEK",
            "grandTotalPriceTaxAsNumber": 0
        },
        "vatExempt": false,
        "address": {
            "firstName": "",
            "lastName": "",
            "email": "",
            "phoneNumber": "",
            "company": "",
            "address1": "",
            "address2": "",
            "zipCode": "",
            "city": "",
            "state": "",
            "country": "",
            "vatNumber": ""
        },
        "shippingAddress": {
            "firstName": "",
            "lastName": "",
            "email": "",
            "phoneNumber": "",
            "company": "",
            "address1": "",
            "address2": "",
            "zipCode": "",
            "city": "",
            "state": "",
            "country": "",
            "vatNumber": ""
        },
        "additionalNotes": "",
        "currencyFormat": {
            "currency": "SEK",
            "name": "SEK",
            "prefix": "",
            "suffix": " SEK",
            "decimalPoint": ".",
            "decimalDigits": "2",
            "uri": "sek"
        }
    },
    "language": [
        {
            "language": "en",
            "name": "English"
        },
        {
            "language": "de",
            "name": "German"
        },
        {
            "language": "sv",
            "name": "Swedish"
        }
    ],
    "paymentMethods": [
        {
            "paymentMethod": "dummy-first",
            "name": "first dummy payment",
            "handlingCost": "13.00 SEK",
            "handlingCostAsNumber": 13
        },
        {
            "paymentMethod": "adyen",
            "name": "Adyen",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "adyen-checkout",
            "name": "Adyen Checkout",
            "clientSide": {
                "externalScript": "https://checkoutshopper-test.adyen.com/checkoutshopper/assets/js/sdk/checkoutSDK.1.9.5.min.js"
            },
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dibs-paywin",
            "name": "dibs",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy",
            "name": "dummy",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy-url",
            "name": "dummy",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy-direct",
            "name": "dummy",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy-double",
            "name": "dummy se",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "epayv2",
            "name": "ePay",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "kco3",
            "name": "kco3",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "stripe-checkout",
            "name": "Stripe Checkout",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "stripe-pi",
            "name": "Stripe Payments",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        }
    ],
    "paymentFields": {
        "termsAndConditions": {
            "type": "boolean",
            "required": true,
            "visible": true
        },
        "address": {
            "email": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "company": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "firstName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "lastName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address1": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address2": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "zipCode": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "city": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "state": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "country": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "phoneNumber": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "identityNumber": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "vatNumber": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "houseNumber": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "houseExtension": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "newsletter": {
                "type": "boolean",
                "required": false,
                "visible": true
            }
        },
        "shippingAddress": {
            "email": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "company": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "firstName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "lastName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address1": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address2": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "zipCode": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "city": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "state": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "country": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "phoneNumber": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "houseNumber": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "houseExtension": {
                "type": "string",
                "required": false,
                "visible": false
            }
        }
    },
    "shippingMethods": [],
    "countries": [
        {
            "country": "JP",
            "name": "Japan",
            "eu": false,
            "language": "en",
            "currency": "JPY"
        },
        {
            "country": "SE",
            "name": "Sweden",
            "eu": true,
            "language": "sv",
            "currency": "SEK"
        },
        {
            "country": "US",
            "name": "United States",
            "eu": false,
            "language": "en",
            "states": [
                {
                    "state": "AL",
                    "name": "Alabama"
                },
                {
                    "state": "AK",
                    "name": "Alaska"
                },
                {
                    "state": "AZ",
                    "name": "Arizona"
                },
                {
                    "state": "AR",
                    "name": "Arkansas"
                },
                {
                    "state": "CA",
                    "name": "California"
                },
                {
                    "state": "CO",
                    "name": "Colorado"
                },
                {
                    "state": "CT",
                    "name": "Connecticut"
                },
                {
                    "state": "DE",
                    "name": "Delaware"
                },
                {
                    "state": "DC",
                    "name": "District of Columbia"
                },
                {
                    "state": "FL",
                    "name": "Florida"
                },
                {
                    "state": "GA",
                    "name": "Georgia"
                },
                {
                    "state": "HI",
                    "name": "Hawaii"
                },
                {
                    "state": "ID",
                    "name": "Idaho"
                },
                {
                    "state": "IL",
                    "name": "Illinois"
                },
                {
                    "state": "IN",
                    "name": "Indiana"
                },
                {
                    "state": "IA",
                    "name": "Iowa"
                },
                {
                    "state": "KS",
                    "name": "Kansas"
                },
                {
                    "state": "KY",
                    "name": "Kentucky"
                },
                {
                    "state": "LA",
                    "name": "Louisiana"
                },
                {
                    "state": "ME",
                    "name": "Maine"
                },
                {
                    "state": "MD",
                    "name": "Maryland"
                },
                {
                    "state": "MA",
                    "name": "Massachusetts"
                },
                {
                    "state": "MI",
                    "name": "Michigan"
                },
                {
                    "state": "MN",
                    "name": "Minnesota"
                },
                {
                    "state": "MS",
                    "name": "Mississippi"
                },
                {
                    "state": "MO",
                    "name": "Missouri"
                },
                {
                    "state": "MT",
                    "name": "Montana"
                },
                {
                    "state": "NE",
                    "name": "Nebraska"
                },
                {
                    "state": "NV",
                    "name": "Nevada"
                },
                {
                    "state": "NH",
                    "name": "New Hampshire"
                },
                {
                    "state": "NJ",
                    "name": "New Jersey"
                },
                {
                    "state": "NM",
                    "name": "New Mexico"
                },
                {
                    "state": "NY",
                    "name": "New York"
                },
                {
                    "state": "NC",
                    "name": "North Carolina"
                },
                {
                    "state": "ND",
                    "name": "North Dakota"
                },
                {
                    "state": "OH",
                    "name": "Ohio"
                },
                {
                    "state": "OK",
                    "name": "Oklahoma"
                },
                {
                    "state": "OR",
                    "name": "Oregon"
                },
                {
                    "state": "PA",
                    "name": "Pennsylvania"
                },
                {
                    "state": "RI",
                    "name": "Rhode Island"
                },
                {
                    "state": "SC",
                    "name": "South Carolina"
                },
                {
                    "state": "SD",
                    "name": "South Dakota"
                },
                {
                    "state": "TN",
                    "name": "Tennessee"
                },
                {
                    "state": "TX",
                    "name": "Texas"
                },
                {
                    "state": "UT",
                    "name": "Utah"
                },
                {
                    "state": "VT",
                    "name": "Vermont"
                },
                {
                    "state": "VA",
                    "name": "Virginia"
                },
                {
                    "state": "WA",
                    "name": "Washington"
                },
                {
                    "state": "WV",
                    "name": "West Virginia"
                },
                {
                    "state": "WI",
                    "name": "Wisconsin"
                },
                {
                    "state": "WY",
                    "name": "Wyoming"
                }
            ],
            "currency": "USD"
        }
    ],
    "location": {
        "country": null,
        "name": "",
        "state": null,
        "stateName": "",
        "eu": false,
        "shipTo": false,
        "language": "en"
    }
}
```

## Change country to US

`PUT {{url}}/api/checkout/countries/US`

Customer can change shipping country, which would affect the shipping options and currency.

### API response

```json
{
    "token": "0ft2kmhg80tlkgq26fq4840vkp",
    "selection": {
        "language": null,
        "currency": "USD",
        "paymentMethod": "dummy-first",
        "paymentMethodName": "first dummy payment",
        "shippingMethod": "usd",
        "shippingMethodName": "USD",
        "items": [
            {
                "item": "1-1",
                "productUrl": null,
                "category": null,
                "size": "",
                "sku": "123456789",
                "ean": "ABCDEFGHIJKL",
                "quantity": 3,
                "line": "0a6d0c85c097bffdd54ad0cac52b3435",
                "priceEach": "10.00 USD",
                "priceEachAsNumber": 10,
                "totalPrice": "30.00 USD",
                "totalPriceAsNumber": 30,
                "priceEachBeforeDiscount": "10.00 USD",
                "priceEachBeforeDiscountAsNumber": 10,
                "anyDiscount": false,
                "taxPercent": 0,
                "priceEachWithoutTax": "10.00 USD",
                "priceEachWithoutTaxAsNumber": 10,
                "priceEachReduction": "0.00 USD",
                "priceEachReductionAsNumber": 0,
                "product": {
                    "product": "1",
                    "name": "Test Product",
                    "uri": "test-product",
                    "sku": "123456",
                    "productSku": "123",
                    "brand": "1",
                    "brandName": "Brand",
                    "brandUri": "brand",
                    "collection": "1",
                    "collectionName": "Collection",
                    "collectionUri": "collection",
                    "variantName": "Red",
                    "countryOrigin": "",
                    "excerpt": "",
                    "excerptHtml": "",
                    "description": "",
                    "descriptionHtml": "",
                    "metaTitle": "",
                    "metaDescription": "",
                    "metaKeywords": "",
                    "stockUnit": "",
                    "category": "1",
                    "centraProduct": "1",
                    "centraVariant": "1445",
                    "itemQuantityMinimum": 1,
                    "itemQuantityMultipleOf": 1,
                    "price": "10.00 USD",
                    "priceAsNumber": 10,
                    "priceBeforeDiscount": "10.00 USD",
                    "priceBeforeDiscountAsNumber": 10,
                    "discountPercent": 0,
                    "showAsOnSale": false,
                    "showAsNew": false,
                    "itemTable": {
                        "x": [
                            ""
                        ],
                        "y": [],
                        "dividerSymbol": "x"
                    },
                    "items": [
                        {
                            "item": "1-1",
                            "itemTableX": 0,
                            "itemTableY": 0,
                            "name": "",
                            "ean": "ABCDEFGHIJKL",
                            "sku": "123456789"
                        }
                    ],
                    "categoryName": [
                        "Shop"
                    ],
                    "categoryUri": "shop",
                    "media": [],
                    "presets": {
                        "prepacks": [],
                        "distributions": []
                    },
                    "tableMappings": {
                        "Size comment": {
                            "unit": "Size comment",
                            "x": [
                                "123"
                            ],
                            "y": [],
                            "dividerSymbol": "x"
                        }
                    },
                    "sh_color_text": 123,
                    "sh_tanning": "Dark tan"
                }
            }
        ],
        "discounts": {
            "anyDiscount": false,
            "discount": "0.00 USD",
            "discountAsNumber": 0,
            "vouchers": [],
            "automaticDiscounts": []
        },
        "totals": {
            "itemsTotalPrice": "30.00 USD",
            "itemsTotalPriceAsNumber": 30,
            "totalDiscountPrice": false,
            "totalDiscountPriceAsNumber": false,
            "shippingPrice": "10.00 USD",
            "shippingPriceAsNumber": 10,
            "handlingCostPrice": "13.00 USD",
            "handlingCostPriceAsNumber": 13,
            "totalQuantity": 3,
            "taxDeducted": false,
            "taxDeductedAsNumber": false,
            "taxAdded": false,
            "taxAddedAsNumber": false,
            "taxPercent": 0,
            "grandTotalPrice": "53.00 USD",
            "grandTotalPriceAsNumber": 53,
            "grandTotalPriceTax": "0.00 USD",
            "grandTotalPriceTaxAsNumber": 0
        },
        "vatExempt": false,
        "address": {
            "firstName": "",
            "lastName": "",
            "email": "",
            "phoneNumber": "",
            "company": "",
            "address1": "",
            "address2": "",
            "zipCode": "",
            "city": "",
            "state": "",
            "country": "",
            "vatNumber": ""
        },
        "shippingAddress": {
            "firstName": "",
            "lastName": "",
            "email": "",
            "phoneNumber": "",
            "company": "",
            "address1": "",
            "address2": "",
            "zipCode": "",
            "city": "",
            "state": "",
            "country": "",
            "vatNumber": ""
        },
        "additionalNotes": "",
        "currencyFormat": {
            "currency": "USD",
            "name": "USD",
            "prefix": "",
            "suffix": " USD",
            "decimalPoint": ".",
            "decimalDigits": "2",
            "uri": "usd"
        }
    },
    "language": [
        {
            "language": "en",
            "name": "English"
        },
        {
            "language": "de",
            "name": "German"
        },
        {
            "language": "sv",
            "name": "Swedish"
        }
    ],
    "paymentMethods": [
        {
            "paymentMethod": "dummy-first",
            "name": "first dummy payment",
            "handlingCost": "13.00 USD",
            "handlingCostAsNumber": 13
        },
        {
            "paymentMethod": "adyen",
            "name": "Adyen",
            "handlingCost": "0.00 USD",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "adyen-checkout",
            "name": "Adyen Checkout",
            "clientSide": {
                "externalScript": "https://checkoutshopper-test.adyen.com/checkoutshopper/assets/js/sdk/checkoutSDK.1.9.5.min.js"
            },
            "handlingCost": "0.00 USD",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dibs-paywin",
            "name": "dibs",
            "handlingCost": "0.00 USD",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy",
            "name": "dummy",
            "handlingCost": "0.00 USD",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy-url",
            "name": "dummy",
            "handlingCost": "0.00 USD",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy-direct",
            "name": "dummy",
            "handlingCost": "0.00 USD",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy-double",
            "name": "dummy us",
            "handlingCost": "12.00 USD",
            "handlingCostAsNumber": 12
        },
        {
            "paymentMethod": "dummy-us",
            "name": "dummy us2",
            "handlingCost": "24.00 USD",
            "handlingCostAsNumber": 24
        },
        {
            "paymentMethod": "epayv2",
            "name": "ePay",
            "handlingCost": "0.00 USD",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "kco3",
            "name": "kco3",
            "handlingCost": "0.00 USD",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "stripe-checkout",
            "name": "Stripe Checkout",
            "handlingCost": "0.00 USD",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "stripe-pi",
            "name": "Stripe Payments",
            "handlingCost": "0.00 USD",
            "handlingCostAsNumber": 0
        }
    ],
    "paymentFields": {
        "termsAndConditions": {
            "type": "boolean",
            "required": true,
            "visible": true
        },
        "address": {
            "email": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "company": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "firstName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "lastName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address1": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address2": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "zipCode": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "city": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "state": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "country": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "phoneNumber": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "identityNumber": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "vatNumber": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "houseNumber": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "houseExtension": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "newsletter": {
                "type": "boolean",
                "required": false,
                "visible": true
            }
        },
        "shippingAddress": {
            "email": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "company": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "firstName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "lastName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address1": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address2": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "zipCode": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "city": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "state": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "country": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "phoneNumber": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "houseNumber": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "houseExtension": {
                "type": "string",
                "required": false,
                "visible": false
            }
        }
    },
    "shippingMethods": [
        {
            "shippingMethod": "usd",
            "name": "USD",
            "price": "10.00 USD",
            "priceAsNumber": 10
        }
    ],
    "countries": [
        {
            "country": "JP",
            "name": "Japan",
            "eu": false,
            "language": "en",
            "currency": "JPY"
        },
        {
            "country": "SE",
            "name": "Sweden",
            "eu": true,
            "language": "sv",
            "currency": "SEK"
        },
        {
            "country": "US",
            "name": "United States",
            "eu": false,
            "language": "en",
            "states": [
                {
                    "state": "AL",
                    "name": "Alabama"
                },
                {
                    "state": "AK",
                    "name": "Alaska"
                },
                {
                    "state": "AZ",
                    "name": "Arizona"
                },
                {
                    "state": "AR",
                    "name": "Arkansas"
                },
                {
                    "state": "CA",
                    "name": "California"
                },
                {
                    "state": "CO",
                    "name": "Colorado"
                },
                {
                    "state": "CT",
                    "name": "Connecticut"
                },
                {
                    "state": "DE",
                    "name": "Delaware"
                },
                {
                    "state": "DC",
                    "name": "District of Columbia"
                },
                {
                    "state": "FL",
                    "name": "Florida"
                },
                {
                    "state": "GA",
                    "name": "Georgia"
                },
                {
                    "state": "HI",
                    "name": "Hawaii"
                },
                {
                    "state": "ID",
                    "name": "Idaho"
                },
                {
                    "state": "IL",
                    "name": "Illinois"
                },
                {
                    "state": "IN",
                    "name": "Indiana"
                },
                {
                    "state": "IA",
                    "name": "Iowa"
                },
                {
                    "state": "KS",
                    "name": "Kansas"
                },
                {
                    "state": "KY",
                    "name": "Kentucky"
                },
                {
                    "state": "LA",
                    "name": "Louisiana"
                },
                {
                    "state": "ME",
                    "name": "Maine"
                },
                {
                    "state": "MD",
                    "name": "Maryland"
                },
                {
                    "state": "MA",
                    "name": "Massachusetts"
                },
                {
                    "state": "MI",
                    "name": "Michigan"
                },
                {
                    "state": "MN",
                    "name": "Minnesota"
                },
                {
                    "state": "MS",
                    "name": "Mississippi"
                },
                {
                    "state": "MO",
                    "name": "Missouri"
                },
                {
                    "state": "MT",
                    "name": "Montana"
                },
                {
                    "state": "NE",
                    "name": "Nebraska"
                },
                {
                    "state": "NV",
                    "name": "Nevada"
                },
                {
                    "state": "NH",
                    "name": "New Hampshire"
                },
                {
                    "state": "NJ",
                    "name": "New Jersey"
                },
                {
                    "state": "NM",
                    "name": "New Mexico"
                },
                {
                    "state": "NY",
                    "name": "New York"
                },
                {
                    "state": "NC",
                    "name": "North Carolina"
                },
                {
                    "state": "ND",
                    "name": "North Dakota"
                },
                {
                    "state": "OH",
                    "name": "Ohio"
                },
                {
                    "state": "OK",
                    "name": "Oklahoma"
                },
                {
                    "state": "OR",
                    "name": "Oregon"
                },
                {
                    "state": "PA",
                    "name": "Pennsylvania"
                },
                {
                    "state": "RI",
                    "name": "Rhode Island"
                },
                {
                    "state": "SC",
                    "name": "South Carolina"
                },
                {
                    "state": "SD",
                    "name": "South Dakota"
                },
                {
                    "state": "TN",
                    "name": "Tennessee"
                },
                {
                    "state": "TX",
                    "name": "Texas"
                },
                {
                    "state": "UT",
                    "name": "Utah"
                },
                {
                    "state": "VT",
                    "name": "Vermont"
                },
                {
                    "state": "VA",
                    "name": "Virginia"
                },
                {
                    "state": "WA",
                    "name": "Washington"
                },
                {
                    "state": "WV",
                    "name": "West Virginia"
                },
                {
                    "state": "WI",
                    "name": "Wisconsin"
                },
                {
                    "state": "WY",
                    "name": "Wyoming"
                }
            ],
            "currency": "USD"
        }
    ],
    "location": {
        "country": "US",
        "name": "United States",
        "state": null,
        "stateName": "",
        "eu": false,
        "shipTo": true,
        "language": "en"
    }
}
```

## Change country back to Sweden

`PUT {{url}}/api/checkout/countries/SE`

Changing the country back, because we can.

### API response

```json
{
    "token": "0ft2kmhg80tlkgq26fq4840vkp",
    "selection": {
        "language": null,
        "currency": "SEK",
        "paymentMethod": "dummy-first",
        "paymentMethodName": "first dummy payment",
        "shippingMethod": "sek",
        "shippingMethodName": "SEK",
        "items": [
            {
                "item": "1-1",
                "productUrl": null,
                "category": null,
                "size": "",
                "sku": "123456789",
                "ean": "ABCDEFGHIJKL",
                "quantity": 3,
                "line": "0a6d0c85c097bffdd54ad0cac52b3435",
                "priceEach": "100.00 SEK",
                "priceEachAsNumber": 100,
                "totalPrice": "300.00 SEK",
                "totalPriceAsNumber": 300,
                "priceEachBeforeDiscount": "100.00 SEK",
                "priceEachBeforeDiscountAsNumber": 100,
                "anyDiscount": false,
                "taxPercent": 25,
                "priceEachWithoutTax": "80.00 SEK",
                "priceEachWithoutTaxAsNumber": 80,
                "priceEachReduction": "0.00 SEK",
                "priceEachReductionAsNumber": 0,
                "product": {
                    "product": "1",
                    "name": "Test Product",
                    "uri": "test-product",
                    "sku": "123456",
                    "productSku": "123",
                    "brand": "1",
                    "brandName": "Brand",
                    "brandUri": "brand",
                    "collection": "1",
                    "collectionName": "Collection",
                    "collectionUri": "collection",
                    "variantName": "Red",
                    "countryOrigin": "",
                    "excerpt": "",
                    "excerptHtml": "",
                    "description": "",
                    "descriptionHtml": "",
                    "metaTitle": "",
                    "metaDescription": "",
                    "metaKeywords": "",
                    "stockUnit": "",
                    "category": "1",
                    "centraProduct": "1",
                    "centraVariant": "1445",
                    "itemQuantityMinimum": 1,
                    "itemQuantityMultipleOf": 1,
                    "price": "100.00 SEK",
                    "priceAsNumber": 100,
                    "priceBeforeDiscount": "100.00 SEK",
                    "priceBeforeDiscountAsNumber": 100,
                    "discountPercent": 0,
                    "showAsOnSale": false,
                    "showAsNew": false,
                    "itemTable": {
                        "x": [
                            ""
                        ],
                        "y": [],
                        "dividerSymbol": "x"
                    },
                    "items": [
                        {
                            "item": "1-1",
                            "itemTableX": 0,
                            "itemTableY": 0,
                            "name": "",
                            "ean": "ABCDEFGHIJKL",
                            "sku": "123456789"
                        }
                    ],
                    "categoryName": [
                        "Shop"
                    ],
                    "categoryUri": "shop",
                    "media": [],
                    "presets": {
                        "prepacks": [],
                        "distributions": []
                    },
                    "tableMappings": {
                        "Size comment": {
                            "unit": "Size comment",
                            "x": [
                                "123"
                            ],
                            "y": [],
                            "dividerSymbol": "x"
                        }
                    },
                    "sh_color_text": 123,
                    "sh_tanning": "Dark tan"
                }
            }
        ],
        "discounts": {
            "anyDiscount": false,
            "discount": "0.00 SEK",
            "discountAsNumber": 0,
            "vouchers": [],
            "automaticDiscounts": []
        },
        "totals": {
            "itemsTotalPrice": "300.00 SEK",
            "itemsTotalPriceAsNumber": 300,
            "totalDiscountPrice": false,
            "totalDiscountPriceAsNumber": false,
            "shippingPrice": "50.00 SEK",
            "shippingPriceAsNumber": 50,
            "handlingCostPrice": "13.00 SEK",
            "handlingCostPriceAsNumber": 13,
            "totalQuantity": 3,
            "taxDeducted": false,
            "taxDeductedAsNumber": false,
            "taxAdded": false,
            "taxAddedAsNumber": false,
            "taxPercent": 25,
            "grandTotalPrice": "363.00 SEK",
            "grandTotalPriceAsNumber": 363,
            "grandTotalPriceTax": "72.60 SEK",
            "grandTotalPriceTaxAsNumber": 72.6
        },
        "vatExempt": false,
        "address": {
            "firstName": "",
            "lastName": "",
            "email": "",
            "phoneNumber": "",
            "company": "",
            "address1": "",
            "address2": "",
            "zipCode": "",
            "city": "",
            "state": "",
            "country": "",
            "vatNumber": ""
        },
        "shippingAddress": {
            "firstName": "",
            "lastName": "",
            "email": "",
            "phoneNumber": "",
            "company": "",
            "address1": "",
            "address2": "",
            "zipCode": "",
            "city": "",
            "state": "",
            "country": "",
            "vatNumber": ""
        },
        "additionalNotes": "",
        "currencyFormat": {
            "currency": "SEK",
            "name": "SEK",
            "prefix": "",
            "suffix": " SEK",
            "decimalPoint": ".",
            "decimalDigits": "2",
            "uri": "sek"
        }
    },
    "language": [
        {
            "language": "en",
            "name": "English"
        },
        {
            "language": "de",
            "name": "German"
        },
        {
            "language": "sv",
            "name": "Swedish"
        }
    ],
    "paymentMethods": [
        {
            "paymentMethod": "dummy-first",
            "name": "first dummy payment",
            "handlingCost": "13.00 SEK",
            "handlingCostAsNumber": 13
        },
        {
            "paymentMethod": "adyen",
            "name": "Adyen",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "adyen-checkout",
            "name": "Adyen Checkout",
            "clientSide": {
                "externalScript": "https://checkoutshopper-test.adyen.com/checkoutshopper/assets/js/sdk/checkoutSDK.1.9.5.min.js"
            },
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dibs-paywin",
            "name": "dibs",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy",
            "name": "dummy",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy-url",
            "name": "dummy",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy-direct",
            "name": "dummy",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "dummy-double",
            "name": "dummy se",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "epayv2",
            "name": "ePay",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "kco3",
            "name": "kco3",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "stripe-checkout",
            "name": "Stripe Checkout",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        },
        {
            "paymentMethod": "stripe-pi",
            "name": "Stripe Payments",
            "handlingCost": "0.00 SEK",
            "handlingCostAsNumber": 0
        }
    ],
    "paymentFields": {
        "termsAndConditions": {
            "type": "boolean",
            "required": true,
            "visible": true
        },
        "address": {
            "email": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "company": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "firstName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "lastName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address1": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address2": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "zipCode": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "city": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "state": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "country": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "phoneNumber": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "identityNumber": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "vatNumber": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "houseNumber": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "houseExtension": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "newsletter": {
                "type": "boolean",
                "required": false,
                "visible": true
            }
        },
        "shippingAddress": {
            "email": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "company": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "firstName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "lastName": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address1": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "address2": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "zipCode": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "city": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "state": {
                "type": "string",
                "required": false,
                "visible": true
            },
            "country": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "phoneNumber": {
                "type": "string",
                "required": true,
                "visible": true
            },
            "houseNumber": {
                "type": "string",
                "required": false,
                "visible": false
            },
            "houseExtension": {
                "type": "string",
                "required": false,
                "visible": false
            }
        }
    },
    "shippingMethods": [
        {
            "shippingMethod": "sek",
            "name": "SEK",
            "price": "50.00 SEK",
            "priceAsNumber": 50
        }
    ],
    "countries": [
        {
            "country": "JP",
            "name": "Japan",
            "eu": false,
            "language": "en",
            "currency": "JPY"
        },
        {
            "country": "SE",
            "name": "Sweden",
            "eu": true,
            "language": "sv",
            "currency": "SEK"
        },
        {
            "country": "US",
            "name": "United States",
            "eu": false,
            "language": "en",
            "states": [
                {
                    "state": "AL",
                    "name": "Alabama"
                },
                {
                    "state": "AK",
                    "name": "Alaska"
                },
                {
                    "state": "AZ",
                    "name": "Arizona"
                },
                {
                    "state": "AR",
                    "name": "Arkansas"
                },
                {
                    "state": "CA",
                    "name": "California"
                },
                {
                    "state": "CO",
                    "name": "Colorado"
                },
                {
                    "state": "CT",
                    "name": "Connecticut"
                },
                {
                    "state": "DE",
                    "name": "Delaware"
                },
                {
                    "state": "DC",
                    "name": "District of Columbia"
                },
                {
                    "state": "FL",
                    "name": "Florida"
                },
                {
                    "state": "GA",
                    "name": "Georgia"
                },
                {
                    "state": "HI",
                    "name": "Hawaii"
                },
                {
                    "state": "ID",
                    "name": "Idaho"
                },
                {
                    "state": "IL",
                    "name": "Illinois"
                },
                {
                    "state": "IN",
                    "name": "Indiana"
                },
                {
                    "state": "IA",
                    "name": "Iowa"
                },
                {
                    "state": "KS",
                    "name": "Kansas"
                },
                {
                    "state": "KY",
                    "name": "Kentucky"
                },
                {
                    "state": "LA",
                    "name": "Louisiana"
                },
                {
                    "state": "ME",
                    "name": "Maine"
                },
                {
                    "state": "MD",
                    "name": "Maryland"
                },
                {
                    "state": "MA",
                    "name": "Massachusetts"
                },
                {
                    "state": "MI",
                    "name": "Michigan"
                },
                {
                    "state": "MN",
                    "name": "Minnesota"
                },
                {
                    "state": "MS",
                    "name": "Mississippi"
                },
                {
                    "state": "MO",
                    "name": "Missouri"
                },
                {
                    "state": "MT",
                    "name": "Montana"
                },
                {
                    "state": "NE",
                    "name": "Nebraska"
                },
                {
                    "state": "NV",
                    "name": "Nevada"
                },
                {
                    "state": "NH",
                    "name": "New Hampshire"
                },
                {
                    "state": "NJ",
                    "name": "New Jersey"
                },
                {
                    "state": "NM",
                    "name": "New Mexico"
                },
                {
                    "state": "NY",
                    "name": "New York"
                },
                {
                    "state": "NC",
                    "name": "North Carolina"
                },
                {
                    "state": "ND",
                    "name": "North Dakota"
                },
                {
                    "state": "OH",
                    "name": "Ohio"
                },
                {
                    "state": "OK",
                    "name": "Oklahoma"
                },
                {
                    "state": "OR",
                    "name": "Oregon"
                },
                {
                    "state": "PA",
                    "name": "Pennsylvania"
                },
                {
                    "state": "RI",
                    "name": "Rhode Island"
                },
                {
                    "state": "SC",
                    "name": "South Carolina"
                },
                {
                    "state": "SD",
                    "name": "South Dakota"
                },
                {
                    "state": "TN",
                    "name": "Tennessee"
                },
                {
                    "state": "TX",
                    "name": "Texas"
                },
                {
                    "state": "UT",
                    "name": "Utah"
                },
                {
                    "state": "VT",
                    "name": "Vermont"
                },
                {
                    "state": "VA",
                    "name": "Virginia"
                },
                {
                    "state": "WA",
                    "name": "Washington"
                },
                {
                    "state": "WV",
                    "name": "West Virginia"
                },
                {
                    "state": "WI",
                    "name": "Wisconsin"
                },
                {
                    "state": "WY",
                    "name": "Wyoming"
                }
            ],
            "currency": "USD"
        }
    ],
    "location": {
        "country": "SE",
        "name": "Sweden",
        "state": null,
        "stateName": "",
        "eu": true,
        "shipTo": false,
        "language": "en"
    }
}
```

## Inject payment details

`POST {{url}}/api/checkout/payment`

Fill out the checkout fields, shipping details and select payment option.

```json
{
	"paymentMethod": "dummy",
	"paymentReturnPage": "http://example.com/success",
	"paymentFailedPage": "http://example.com/failure",
	"termsAndConditions": "true",
	"address": {
		"newsletter": false,
		"email": "abc123@example.com",
		"phoneNumber": "123456789",
		"firstName": "Test Billing",
		"lastName": "Testson Billing",
		"address1": "Address One",
		"address2": "Address Two",
		"zipCode": "12345",
		"city": "Malmo",
		"country": "SE"
	},
	"shippingAddress": {
		"phoneNumber": "123456789",
		"firstName": "Test Shipping",
		"lastName": "Testson Shipping",
		"address1": "ShipAddress One",
		"address2": "ShipAddress Two",
		"zipCode": "12345",
		"city": "Stockholm",
		"country": "SE"
	}
}
```

### API response

```json
{
    "token": "0ft2kmhg80tlkgq26fq4840vkp",
    "action": "form",
    "formHtml": "<form id=\"form-b9de780983b0f84702b546e22a40c7eb\" action=\"http://example.com/success?centraPaymentMethod=dummy\" accept-charset=\"UTF-8\" method=\"post\"><input type=\"hidden\" name=\"ba_order_num\" value=\"61\" /><input type=\"hidden\" name=\"amount\" value=\"350.00\" /><input type=\"hidden\" name=\"trans\" value=\"89cb2728644d8d42603732bc86f9851b\" /><input type=\"hidden\" name=\"currency\" value=\"3\" /><input type=\"hidden\" name=\"signature\" value=\"bfc8414d462c7f1e6c13683f819fb559b89ad868\" /><noscript><input type=\"submit\" /></noscript><script>document.getElementById('form-b9de780983b0f84702b546e22a40c7eb').submit();</script></form>"
}
```

## Receipt - payment result

`POST {{url}}/api/checkout/payment-result`

Finalise the checkout, get order confirmation.

```json
{
	"paymentMethodFields": {
		"selection": "{{selection}}",
		"ba_order_num": "{{order_num}}",
		"amount": "{{amount}}",
		"trans": "{{trans}}",
		"currency": "{{currency}}",
		"signature": "{{signature}}"
	}
}
```

### API response

```json
{
    "token": "0ft2kmhg80tlkgq26fq4840vkp",
    "order": {
        "order": "61",
        "status": "progress",
        "statusDescription": "Confirmed",
        "message": "Thank you for your order!",
        "date": "2019-09-16 14:42:11",
        "affiliateHtml": "",
        "language": null,
        "currency": "SEK",
        "paymentMethod": "dummy",
        "paymentMethodName": "dummy",
        "shippingMethod": "sek",
        "shippingMethodName": "SEK",
        "items": [
            {
                "item": "1-1",
                "productUrl": null,
                "category": null,
                "size": "",
                "sku": "123456789",
                "ean": "ABCDEFGHIJKL",
                "quantity": 1,
                "storePickup": false,
                "line": "0a6d0c85c097bffdd54ad0cac52b3435",
                "priceEach": "100.00 SEK",
                "priceEachAsNumber": 100,
                "totalPrice": "100.00 SEK",
                "totalPriceAsNumber": 100,
                "priceEachBeforeDiscount": "100.00 SEK",
                "priceEachBeforeDiscountAsNumber": 100,
                "anyDiscount": false,
                "taxPercent": 25,
                "priceEachWithoutTax": "80.00 SEK",
                "priceEachWithoutTaxAsNumber": 80,
                "priceEachReduction": "0.00 SEK",
                "priceEachReductionAsNumber": 0,
                "product": {
                    "product": "1",
                    "name": "Test Product",
                    "uri": "test-product",
                    "sku": "123456",
                    "productSku": "123",
                    "brand": "1",
                    "brandName": "Brand",
                    "brandUri": "brand",
                    "collection": "1",
                    "collectionName": "Collection",
                    "collectionUri": "collection",
                    "variantName": "Red",
                    "countryOrigin": "",
                    "excerpt": "",
                    "excerptHtml": "",
                    "description": "",
                    "descriptionHtml": "",
                    "metaTitle": "",
                    "metaDescription": "",
                    "metaKeywords": "",
                    "stockUnit": "",
                    "category": "1",
                    "centraProduct": "1",
                    "centraVariant": "1445",
                    "itemQuantityMinimum": 1,
                    "itemQuantityMultipleOf": 1,
                    "price": "100.00 SEK",
                    "priceAsNumber": 100,
                    "priceBeforeDiscount": "100.00 SEK",
                    "priceBeforeDiscountAsNumber": 100,
                    "discountPercent": 0,
                    "showAsOnSale": false,
                    "showAsNew": false,
                    "itemTable": {
                        "x": [
                            ""
                        ],
                        "y": [],
                        "dividerSymbol": "x"
                    },
                    "items": [
                        {
                            "item": "1-1",
                            "itemTableX": 0,
                            "itemTableY": 0,
                            "name": "",
                            "ean": "ABCDEFGHIJKL",
                            "sku": "123456789"
                        }
                    ],
                    "categoryName": [
                        "Shop"
                    ],
                    "categoryUri": "shop",
                    "media": [],
                    "presets": {
                        "prepacks": [],
                        "distributions": []
                    },
                    "tableMappings": {
                        "Size comment": {
                            "unit": "Size comment",
                            "x": [
                                "123"
                            ],
                            "y": [],
                            "dividerSymbol": "x"
                        }
                    },
                    "sh_color_text": 123,
                    "sh_tanning": "Dark tan"
                }
            },
            {
                "item": "1-1",
                "productUrl": null,
                "category": null,
                "size": "",
                "sku": "123456789",
                "ean": "ABCDEFGHIJKL",
                "quantity": 1,
                "storePickup": false,
                "line": "4ef4501c8614a4fab0bd1c0941f46789",
                "priceEach": "100.00 SEK",
                "priceEachAsNumber": 100,
                "totalPrice": "100.00 SEK",
                "totalPriceAsNumber": 100,
                "priceEachBeforeDiscount": "100.00 SEK",
                "priceEachBeforeDiscountAsNumber": 100,
                "anyDiscount": false,
                "taxPercent": 25,
                "priceEachWithoutTax": "80.00 SEK",
                "priceEachWithoutTaxAsNumber": 80,
                "priceEachReduction": "0.00 SEK",
                "priceEachReductionAsNumber": 0,
                "product": {
                    "product": "1",
                    "name": "Test Product",
                    "uri": "test-product",
                    "sku": "123456",
                    "productSku": "123",
                    "brand": "1",
                    "brandName": "Brand",
                    "brandUri": "brand",
                    "collection": "1",
                    "collectionName": "Collection",
                    "collectionUri": "collection",
                    "variantName": "Red",
                    "countryOrigin": "",
                    "excerpt": "",
                    "excerptHtml": "",
                    "description": "",
                    "descriptionHtml": "",
                    "metaTitle": "",
                    "metaDescription": "",
                    "metaKeywords": "",
                    "stockUnit": "",
                    "category": "1",
                    "centraProduct": "1",
                    "centraVariant": "1445",
                    "itemQuantityMinimum": 1,
                    "itemQuantityMultipleOf": 1,
                    "price": "100.00 SEK",
                    "priceAsNumber": 100,
                    "priceBeforeDiscount": "100.00 SEK",
                    "priceBeforeDiscountAsNumber": 100,
                    "discountPercent": 0,
                    "showAsOnSale": false,
                    "showAsNew": false,
                    "itemTable": {
                        "x": [
                            ""
                        ],
                        "y": [],
                        "dividerSymbol": "x"
                    },
                    "items": [
                        {
                            "item": "1-1",
                            "itemTableX": 0,
                            "itemTableY": 0,
                            "name": "",
                            "ean": "ABCDEFGHIJKL",
                            "sku": "123456789"
                        }
                    ],
                    "categoryName": [
                        "Shop"
                    ],
                    "categoryUri": "shop",
                    "media": [],
                    "presets": {
                        "prepacks": [],
                        "distributions": []
                    },
                    "tableMappings": {
                        "Size comment": {
                            "unit": "Size comment",
                            "x": [
                                "123"
                            ],
                            "y": [],
                            "dividerSymbol": "x"
                        }
                    },
                    "sh_color_text": 123,
                    "sh_tanning": "Dark tan"
                }
            },
            {
                "item": "1-1",
                "productUrl": null,
                "category": null,
                "size": "",
                "sku": "123456789",
                "ean": "ABCDEFGHIJKL",
                "quantity": 1,
                "storePickup": false,
                "line": "de73ae0469a3565650e6b60cf9802931",
                "priceEach": "100.00 SEK",
                "priceEachAsNumber": 100,
                "totalPrice": "100.00 SEK",
                "totalPriceAsNumber": 100,
                "priceEachBeforeDiscount": "100.00 SEK",
                "priceEachBeforeDiscountAsNumber": 100,
                "anyDiscount": false,
                "taxPercent": 25,
                "priceEachWithoutTax": "80.00 SEK",
                "priceEachWithoutTaxAsNumber": 80,
                "priceEachReduction": "0.00 SEK",
                "priceEachReductionAsNumber": 0,
                "product": {
                    "product": "1",
                    "name": "Test Product",
                    "uri": "test-product",
                    "sku": "123456",
                    "productSku": "123",
                    "brand": "1",
                    "brandName": "Brand",
                    "brandUri": "brand",
                    "collection": "1",
                    "collectionName": "Collection",
                    "collectionUri": "collection",
                    "variantName": "Red",
                    "countryOrigin": "",
                    "excerpt": "",
                    "excerptHtml": "",
                    "description": "",
                    "descriptionHtml": "",
                    "metaTitle": "",
                    "metaDescription": "",
                    "metaKeywords": "",
                    "stockUnit": "",
                    "category": "1",
                    "centraProduct": "1",
                    "centraVariant": "1445",
                    "itemQuantityMinimum": 1,
                    "itemQuantityMultipleOf": 1,
                    "price": "100.00 SEK",
                    "priceAsNumber": 100,
                    "priceBeforeDiscount": "100.00 SEK",
                    "priceBeforeDiscountAsNumber": 100,
                    "discountPercent": 0,
                    "showAsOnSale": false,
                    "showAsNew": false,
                    "itemTable": {
                        "x": [
                            ""
                        ],
                        "y": [],
                        "dividerSymbol": "x"
                    },
                    "items": [
                        {
                            "item": "1-1",
                            "itemTableX": 0,
                            "itemTableY": 0,
                            "name": "",
                            "ean": "ABCDEFGHIJKL",
                            "sku": "123456789"
                        }
                    ],
                    "categoryName": [
                        "Shop"
                    ],
                    "categoryUri": "shop",
                    "media": [],
                    "presets": {
                        "prepacks": [],
                        "distributions": []
                    },
                    "tableMappings": {
                        "Size comment": {
                            "unit": "Size comment",
                            "x": [
                                "123"
                            ],
                            "y": [],
                            "dividerSymbol": "x"
                        }
                    },
                    "sh_color_text": 123,
                    "sh_tanning": "Dark tan"
                }
            }
        ],
        "discounts": {
            "anyDiscount": false,
            "discount": "0.00 SEK",
            "discountAsNumber": 0,
            "vouchers": [],
            "automaticDiscounts": []
        },
        "totals": {
            "itemsTotalPrice": "300.00 SEK",
            "itemsTotalPriceAsNumber": 300,
            "totalDiscountPrice": false,
            "totalDiscountPriceAsNumber": false,
            "shippingPrice": "50.00 SEK",
            "shippingPriceAsNumber": 50,
            "handlingCostPrice": "0.00 SEK",
            "handlingCostPriceAsNumber": 0,
            "totalQuantity": 3,
            "taxDeducted": false,
            "taxDeductedAsNumber": false,
            "taxAdded": false,
            "taxAddedAsNumber": false,
            "taxPercent": 25,
            "grandTotalPrice": "350.00 SEK",
            "grandTotalPriceAsNumber": 350,
            "grandTotalPriceTax": "70.00 SEK",
            "grandTotalPriceTaxAsNumber": 70
        },
        "vatExempt": false,
        "address": {
            "email": "abc123@example.com",
            "firstName": "Test Billing",
            "lastName": "Testson Billing",
            "company": "",
            "address1": "Address One",
            "address2": "Address Two",
            "zipCode": "12345",
            "city": "Malmo",
            "state": "",
            "country": "SE",
            "countryName": "Sweden",
            "phoneNumber": "123456789",
            "vatNumber": ""
        },
        "shippingAddress": {
            "email": "abc123@example.com",
            "firstName": "Test Shipping",
            "lastName": "Testson Shipping",
            "company": "",
            "address1": "ShipAddress One",
            "address2": "ShipAddress Two",
            "zipCode": "12345",
            "city": "Stockholm",
            "state": "",
            "country": "SE",
            "countryName": "Sweden",
            "phoneNumber": "123456789"
        },
        "giftMessage": "",
        "additionalNotes": "",
        "shipments": [],
        "paymentMethodData": {
            "html_snippet": "Dummy payment plugin snippet"
        },
        "currencyFormat": {
            "currency": "SEK",
            "name": "SEK",
            "prefix": "",
            "suffix": " SEK",
            "decimalPoint": ".",
            "decimalDigits": "2",
            "uri": "sek"
        }
    },
    "language": [
        {
            "language": "en",
            "name": "English"
        },
        {
            "language": "de",
            "name": "German"
        },
        {
            "language": "sv",
            "name": "Swedish"
        }
    ],
    "countries": [
        {
            "country": "JP",
            "name": "Japan",
            "eu": false,
            "language": "en",
            "currency": "JPY"
        },
        {
            "country": "SE",
            "name": "Sweden",
            "eu": true,
            "language": "sv",
            "currency": "SEK"
        },
        {
            "country": "US",
            "name": "United States",
            "eu": false,
            "language": "en",
            "states": [
                {
                    "state": "AL",
                    "name": "Alabama"
                },
                {
                    "state": "AK",
                    "name": "Alaska"
                },
                {
                    "state": "AZ",
                    "name": "Arizona"
                },
                {
                    "state": "AR",
                    "name": "Arkansas"
                },
                {
                    "state": "CA",
                    "name": "California"
                },
                {
                    "state": "CO",
                    "name": "Colorado"
                },
                {
                    "state": "CT",
                    "name": "Connecticut"
                },
                {
                    "state": "DE",
                    "name": "Delaware"
                },
                {
                    "state": "DC",
                    "name": "District of Columbia"
                },
                {
                    "state": "FL",
                    "name": "Florida"
                },
                {
                    "state": "GA",
                    "name": "Georgia"
                },
                {
                    "state": "HI",
                    "name": "Hawaii"
                },
                {
                    "state": "ID",
                    "name": "Idaho"
                },
                {
                    "state": "IL",
                    "name": "Illinois"
                },
                {
                    "state": "IN",
                    "name": "Indiana"
                },
                {
                    "state": "IA",
                    "name": "Iowa"
                },
                {
                    "state": "KS",
                    "name": "Kansas"
                },
                {
                    "state": "KY",
                    "name": "Kentucky"
                },
                {
                    "state": "LA",
                    "name": "Louisiana"
                },
                {
                    "state": "ME",
                    "name": "Maine"
                },
                {
                    "state": "MD",
                    "name": "Maryland"
                },
                {
                    "state": "MA",
                    "name": "Massachusetts"
                },
                {
                    "state": "MI",
                    "name": "Michigan"
                },
                {
                    "state": "MN",
                    "name": "Minnesota"
                },
                {
                    "state": "MS",
                    "name": "Mississippi"
                },
                {
                    "state": "MO",
                    "name": "Missouri"
                },
                {
                    "state": "MT",
                    "name": "Montana"
                },
                {
                    "state": "NE",
                    "name": "Nebraska"
                },
                {
                    "state": "NV",
                    "name": "Nevada"
                },
                {
                    "state": "NH",
                    "name": "New Hampshire"
                },
                {
                    "state": "NJ",
                    "name": "New Jersey"
                },
                {
                    "state": "NM",
                    "name": "New Mexico"
                },
                {
                    "state": "NY",
                    "name": "New York"
                },
                {
                    "state": "NC",
                    "name": "North Carolina"
                },
                {
                    "state": "ND",
                    "name": "North Dakota"
                },
                {
                    "state": "OH",
                    "name": "Ohio"
                },
                {
                    "state": "OK",
                    "name": "Oklahoma"
                },
                {
                    "state": "OR",
                    "name": "Oregon"
                },
                {
                    "state": "PA",
                    "name": "Pennsylvania"
                },
                {
                    "state": "RI",
                    "name": "Rhode Island"
                },
                {
                    "state": "SC",
                    "name": "South Carolina"
                },
                {
                    "state": "SD",
                    "name": "South Dakota"
                },
                {
                    "state": "TN",
                    "name": "Tennessee"
                },
                {
                    "state": "TX",
                    "name": "Texas"
                },
                {
                    "state": "UT",
                    "name": "Utah"
                },
                {
                    "state": "VT",
                    "name": "Vermont"
                },
                {
                    "state": "VA",
                    "name": "Virginia"
                },
                {
                    "state": "WA",
                    "name": "Washington"
                },
                {
                    "state": "WV",
                    "name": "West Virginia"
                },
                {
                    "state": "WI",
                    "name": "Wisconsin"
                },
                {
                    "state": "WY",
                    "name": "Wyoming"
                }
            ],
            "currency": "USD"
        }
    ],
    "location": {
        "country": "SE",
        "name": "Sweden",
        "state": null,
        "stateName": "",
        "eu": true,
        "shipTo": false,
        "language": "en"
    }
}
```

## Order summary

`GET {{url}}/api/checkout/selection`

See? It's no longer a selection, now it's an order.

### API response

```json
{
    "token": "0ft2kmhg80tlkgq26fq4840vkp",
    "order": {
        "order": "61",
        "status": "progress",
        "statusDescription": "Confirmed",
        "message": "Thank you for your order!",
        "date": "2019-09-16 14:42:11",
        "language": null,
        "currency": "SEK",
        "paymentMethod": "dummy",
        "paymentMethodName": "dummy",
        "shippingMethod": "sek",
        "shippingMethodName": "SEK",
        "items": [
            {
                "item": "1-1",
                "productUrl": null,
                "category": null,
                "size": "",
                "sku": "123456789",
                "ean": "ABCDEFGHIJKL",
                "quantity": 1,
                "storePickup": false,
                "line": "0a6d0c85c097bffdd54ad0cac52b3435",
                "priceEach": "100.00 SEK",
                "priceEachAsNumber": 100,
                "totalPrice": "100.00 SEK",
                "totalPriceAsNumber": 100,
                "priceEachBeforeDiscount": "100.00 SEK",
                "priceEachBeforeDiscountAsNumber": 100,
                "anyDiscount": false,
                "taxPercent": 25,
                "priceEachWithoutTax": "80.00 SEK",
                "priceEachWithoutTaxAsNumber": 80,
                "priceEachReduction": "0.00 SEK",
                "priceEachReductionAsNumber": 0,
                "product": {
                    "product": "1",
                    "name": "Test Product",
                    "uri": "test-product",
                    "sku": "123456",
                    "productSku": "123",
                    "brand": "1",
                    "brandName": "Brand",
                    "brandUri": "brand",
                    "collection": "1",
                    "collectionName": "Collection",
                    "collectionUri": "collection",
                    "variantName": "Red",
                    "countryOrigin": "",
                    "excerpt": "",
                    "excerptHtml": "",
                    "description": "",
                    "descriptionHtml": "",
                    "metaTitle": "",
                    "metaDescription": "",
                    "metaKeywords": "",
                    "stockUnit": "",
                    "category": "1",
                    "centraProduct": "1",
                    "centraVariant": "1445",
                    "itemQuantityMinimum": 1,
                    "itemQuantityMultipleOf": 1,
                    "price": "100.00 SEK",
                    "priceAsNumber": 100,
                    "priceBeforeDiscount": "100.00 SEK",
                    "priceBeforeDiscountAsNumber": 100,
                    "discountPercent": 0,
                    "showAsOnSale": false,
                    "showAsNew": false,
                    "itemTable": {
                        "x": [
                            ""
                        ],
                        "y": [],
                        "dividerSymbol": "x"
                    },
                    "items": [
                        {
                            "item": "1-1",
                            "itemTableX": 0,
                            "itemTableY": 0,
                            "name": "",
                            "ean": "ABCDEFGHIJKL",
                            "sku": "123456789"
                        }
                    ],
                    "categoryName": [
                        "Shop"
                    ],
                    "categoryUri": "shop",
                    "media": [],
                    "presets": {
                        "prepacks": [],
                        "distributions": []
                    },
                    "tableMappings": {
                        "Size comment": {
                            "unit": "Size comment",
                            "x": [
                                "123"
                            ],
                            "y": [],
                            "dividerSymbol": "x"
                        }
                    },
                    "sh_color_text": 123,
                    "sh_tanning": "Dark tan"
                }
            },
            {
                "item": "1-1",
                "productUrl": null,
                "category": null,
                "size": "",
                "sku": "123456789",
                "ean": "ABCDEFGHIJKL",
                "quantity": 1,
                "storePickup": false,
                "line": "4ef4501c8614a4fab0bd1c0941f46789",
                "priceEach": "100.00 SEK",
                "priceEachAsNumber": 100,
                "totalPrice": "100.00 SEK",
                "totalPriceAsNumber": 100,
                "priceEachBeforeDiscount": "100.00 SEK",
                "priceEachBeforeDiscountAsNumber": 100,
                "anyDiscount": false,
                "taxPercent": 25,
                "priceEachWithoutTax": "80.00 SEK",
                "priceEachWithoutTaxAsNumber": 80,
                "priceEachReduction": "0.00 SEK",
                "priceEachReductionAsNumber": 0,
                "product": {
                    "product": "1",
                    "name": "Test Product",
                    "uri": "test-product",
                    "sku": "123456",
                    "productSku": "123",
                    "brand": "1",
                    "brandName": "Brand",
                    "brandUri": "brand",
                    "collection": "1",
                    "collectionName": "Collection",
                    "collectionUri": "collection",
                    "variantName": "Red",
                    "countryOrigin": "",
                    "excerpt": "",
                    "excerptHtml": "",
                    "description": "",
                    "descriptionHtml": "",
                    "metaTitle": "",
                    "metaDescription": "",
                    "metaKeywords": "",
                    "stockUnit": "",
                    "category": "1",
                    "centraProduct": "1",
                    "centraVariant": "1445",
                    "itemQuantityMinimum": 1,
                    "itemQuantityMultipleOf": 1,
                    "price": "100.00 SEK",
                    "priceAsNumber": 100,
                    "priceBeforeDiscount": "100.00 SEK",
                    "priceBeforeDiscountAsNumber": 100,
                    "discountPercent": 0,
                    "showAsOnSale": false,
                    "showAsNew": false,
                    "itemTable": {
                        "x": [
                            ""
                        ],
                        "y": [],
                        "dividerSymbol": "x"
                    },
                    "items": [
                        {
                            "item": "1-1",
                            "itemTableX": 0,
                            "itemTableY": 0,
                            "name": "",
                            "ean": "ABCDEFGHIJKL",
                            "sku": "123456789"
                        }
                    ],
                    "categoryName": [
                        "Shop"
                    ],
                    "categoryUri": "shop",
                    "media": [],
                    "presets": {
                        "prepacks": [],
                        "distributions": []
                    },
                    "tableMappings": {
                        "Size comment": {
                            "unit": "Size comment",
                            "x": [
                                "123"
                            ],
                            "y": [],
                            "dividerSymbol": "x"
                        }
                    },
                    "sh_color_text": 123,
                    "sh_tanning": "Dark tan"
                }
            },
            {
                "item": "1-1",
                "productUrl": null,
                "category": null,
                "size": "",
                "sku": "123456789",
                "ean": "ABCDEFGHIJKL",
                "quantity": 1,
                "storePickup": false,
                "line": "de73ae0469a3565650e6b60cf9802931",
                "priceEach": "100.00 SEK",
                "priceEachAsNumber": 100,
                "totalPrice": "100.00 SEK",
                "totalPriceAsNumber": 100,
                "priceEachBeforeDiscount": "100.00 SEK",
                "priceEachBeforeDiscountAsNumber": 100,
                "anyDiscount": false,
                "taxPercent": 25,
                "priceEachWithoutTax": "80.00 SEK",
                "priceEachWithoutTaxAsNumber": 80,
                "priceEachReduction": "0.00 SEK",
                "priceEachReductionAsNumber": 0,
                "product": {
                    "product": "1",
                    "name": "Test Product",
                    "uri": "test-product",
                    "sku": "123456",
                    "productSku": "123",
                    "brand": "1",
                    "brandName": "Brand",
                    "brandUri": "brand",
                    "collection": "1",
                    "collectionName": "Collection",
                    "collectionUri": "collection",
                    "variantName": "Red",
                    "countryOrigin": "",
                    "excerpt": "",
                    "excerptHtml": "",
                    "description": "",
                    "descriptionHtml": "",
                    "metaTitle": "",
                    "metaDescription": "",
                    "metaKeywords": "",
                    "stockUnit": "",
                    "category": "1",
                    "centraProduct": "1",
                    "centraVariant": "1445",
                    "itemQuantityMinimum": 1,
                    "itemQuantityMultipleOf": 1,
                    "price": "100.00 SEK",
                    "priceAsNumber": 100,
                    "priceBeforeDiscount": "100.00 SEK",
                    "priceBeforeDiscountAsNumber": 100,
                    "discountPercent": 0,
                    "showAsOnSale": false,
                    "showAsNew": false,
                    "itemTable": {
                        "x": [
                            ""
                        ],
                        "y": [],
                        "dividerSymbol": "x"
                    },
                    "items": [
                        {
                            "item": "1-1",
                            "itemTableX": 0,
                            "itemTableY": 0,
                            "name": "",
                            "ean": "ABCDEFGHIJKL",
                            "sku": "123456789"
                        }
                    ],
                    "categoryName": [
                        "Shop"
                    ],
                    "categoryUri": "shop",
                    "media": [],
                    "presets": {
                        "prepacks": [],
                        "distributions": []
                    },
                    "tableMappings": {
                        "Size comment": {
                            "unit": "Size comment",
                            "x": [
                                "123"
                            ],
                            "y": [],
                            "dividerSymbol": "x"
                        }
                    },
                    "sh_color_text": 123,
                    "sh_tanning": "Dark tan"
                }
            }
        ],
        "discounts": {
            "anyDiscount": false,
            "discount": "0.00 SEK",
            "discountAsNumber": 0,
            "vouchers": [],
            "automaticDiscounts": []
        },
        "totals": {
            "itemsTotalPrice": "300.00 SEK",
            "itemsTotalPriceAsNumber": 300,
            "totalDiscountPrice": false,
            "totalDiscountPriceAsNumber": false,
            "shippingPrice": "50.00 SEK",
            "shippingPriceAsNumber": 50,
            "handlingCostPrice": "0.00 SEK",
            "handlingCostPriceAsNumber": 0,
            "totalQuantity": 3,
            "taxDeducted": false,
            "taxDeductedAsNumber": false,
            "taxAdded": false,
            "taxAddedAsNumber": false,
            "taxPercent": 25,
            "grandTotalPrice": "350.00 SEK",
            "grandTotalPriceAsNumber": 350,
            "grandTotalPriceTax": "70.00 SEK",
            "grandTotalPriceTaxAsNumber": 70
        },
        "vatExempt": false,
        "address": {
            "email": "abc123@example.com",
            "firstName": "Test Billing",
            "lastName": "Testson Billing",
            "company": "",
            "address1": "Address One",
            "address2": "Address Two",
            "zipCode": "12345",
            "city": "Malmo",
            "state": "",
            "country": "SE",
            "countryName": "Sweden",
            "phoneNumber": "123456789",
            "vatNumber": ""
        },
        "shippingAddress": {
            "email": "abc123@example.com",
            "firstName": "Test Shipping",
            "lastName": "Testson Shipping",
            "company": "",
            "address1": "ShipAddress One",
            "address2": "ShipAddress Two",
            "zipCode": "12345",
            "city": "Stockholm",
            "state": "",
            "country": "SE",
            "countryName": "Sweden",
            "phoneNumber": "123456789"
        },
        "giftMessage": "",
        "additionalNotes": "",
        "shipments": [],
        "currencyFormat": {
            "currency": "SEK",
            "name": "SEK",
            "prefix": "",
            "suffix": " SEK",
            "decimalPoint": ".",
            "decimalDigits": "2",
            "uri": "sek"
        }
    },
    "language": [
        {
            "language": "en",
            "name": "English"
        },
        {
            "language": "de",
            "name": "German"
        },
        {
            "language": "sv",
            "name": "Swedish"
        }
    ],
    "countries": [
        {
            "country": "JP",
            "name": "Japan",
            "eu": false,
            "language": "en",
            "currency": "JPY"
        },
        {
            "country": "SE",
            "name": "Sweden",
            "eu": true,
            "language": "sv",
            "currency": "SEK"
        },
        {
            "country": "US",
            "name": "United States",
            "eu": false,
            "language": "en",
            "states": [
                {
                    "state": "AL",
                    "name": "Alabama"
                },
                {
                    "state": "AK",
                    "name": "Alaska"
                },
                {
                    "state": "AZ",
                    "name": "Arizona"
                },
                {
                    "state": "AR",
                    "name": "Arkansas"
                },
                {
                    "state": "CA",
                    "name": "California"
                },
                {
                    "state": "CO",
                    "name": "Colorado"
                },
                {
                    "state": "CT",
                    "name": "Connecticut"
                },
                {
                    "state": "DE",
                    "name": "Delaware"
                },
                {
                    "state": "DC",
                    "name": "District of Columbia"
                },
                {
                    "state": "FL",
                    "name": "Florida"
                },
                {
                    "state": "GA",
                    "name": "Georgia"
                },
                {
                    "state": "HI",
                    "name": "Hawaii"
                },
                {
                    "state": "ID",
                    "name": "Idaho"
                },
                {
                    "state": "IL",
                    "name": "Illinois"
                },
                {
                    "state": "IN",
                    "name": "Indiana"
                },
                {
                    "state": "IA",
                    "name": "Iowa"
                },
                {
                    "state": "KS",
                    "name": "Kansas"
                },
                {
                    "state": "KY",
                    "name": "Kentucky"
                },
                {
                    "state": "LA",
                    "name": "Louisiana"
                },
                {
                    "state": "ME",
                    "name": "Maine"
                },
                {
                    "state": "MD",
                    "name": "Maryland"
                },
                {
                    "state": "MA",
                    "name": "Massachusetts"
                },
                {
                    "state": "MI",
                    "name": "Michigan"
                },
                {
                    "state": "MN",
                    "name": "Minnesota"
                },
                {
                    "state": "MS",
                    "name": "Mississippi"
                },
                {
                    "state": "MO",
                    "name": "Missouri"
                },
                {
                    "state": "MT",
                    "name": "Montana"
                },
                {
                    "state": "NE",
                    "name": "Nebraska"
                },
                {
                    "state": "NV",
                    "name": "Nevada"
                },
                {
                    "state": "NH",
                    "name": "New Hampshire"
                },
                {
                    "state": "NJ",
                    "name": "New Jersey"
                },
                {
                    "state": "NM",
                    "name": "New Mexico"
                },
                {
                    "state": "NY",
                    "name": "New York"
                },
                {
                    "state": "NC",
                    "name": "North Carolina"
                },
                {
                    "state": "ND",
                    "name": "North Dakota"
                },
                {
                    "state": "OH",
                    "name": "Ohio"
                },
                {
                    "state": "OK",
                    "name": "Oklahoma"
                },
                {
                    "state": "OR",
                    "name": "Oregon"
                },
                {
                    "state": "PA",
                    "name": "Pennsylvania"
                },
                {
                    "state": "RI",
                    "name": "Rhode Island"
                },
                {
                    "state": "SC",
                    "name": "South Carolina"
                },
                {
                    "state": "SD",
                    "name": "South Dakota"
                },
                {
                    "state": "TN",
                    "name": "Tennessee"
                },
                {
                    "state": "TX",
                    "name": "Texas"
                },
                {
                    "state": "UT",
                    "name": "Utah"
                },
                {
                    "state": "VT",
                    "name": "Vermont"
                },
                {
                    "state": "VA",
                    "name": "Virginia"
                },
                {
                    "state": "WA",
                    "name": "Washington"
                },
                {
                    "state": "WV",
                    "name": "West Virginia"
                },
                {
                    "state": "WI",
                    "name": "Wisconsin"
                },
                {
                    "state": "WY",
                    "name": "Wyoming"
                }
            ],
            "currency": "USD"
        }
    ],
    "location": {
        "country": "SE",
        "name": "Sweden",
        "state": null,
        "stateName": "",
        "eu": true,
        "shipTo": false,
        "language": "en"
    }
}
```
That's all, folks!
