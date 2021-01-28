---
title: How to sell Gift Certificates in your Store
altTitle: Gift Certificates
excerpt: Gift Certificates are "virtual" products that are handled differently in Centra. Here is how to handle them in your Front End.
taxonomy:
  category: docs
---

## How do Gift Certificates work in Centra?

[notice-box=info]
Currently, gift certificates are only supported in [Shop API](/api-references/shop-api).
[/notice-box]

In Centra, gift certificates can be purchased with the same flow as standard products. Once you buy a GC and pay for it, a voucher will be automatically generated and sent to your end customer via e-mail. However, since GCs are virtual items, there are some differences:

* Gift certificates cannot belong to the same selection as "real" products. Once you add a GC to your selection, other items will be removed from it.
* You can only buy one gift certificate at a time. If you add a new GC to your selection, previous one will be removed.
* Orders including gift certificates will be automatically finalised, with an automatically created, completed Shipment.

### Types of GCs

You can learn the basics of creating gift certificates in [Gift Certificates in B2C](https://support.centra.com/centra-sections/retail-b2c/promo/creating-a-gift-certificate) article on our Support site.

There are two types of gift certificates:
* `Priceoff` - this is a certificate that has pre-defined value in each of currencies you want to sell in,
* `Dynamic Priceoff` - this is a certificate with no pre-defined value, you can choose it in your front end.

## Payment flow with Gift Certificates

Here's what they each look like when you fetch them using [GET /gift-certificates](https://docs.centra.com/swagger-ui/?api=ShopAPI#/default/get_gift_certificates) call:

```json
{
    "gift-2": {
        "giftCertificate": "gift-2",
        "name": "Pre-defined gift certificate",
        "currencyOfSaleOnly": true,
        "showGiftAmount": false,
        "type": "predeterminedAmount",
        "amountByCurrency": {
            "USD": {
                "amount": "10.00 USD",
                "amountAsNumber": 10
            },
            "SEK": {
                "amount": "100 SEK",
                "amountAsNumber": 100
            },
            "JPY": {
                "amount": "1 000 JPY",
                "amountAsNumber": 1000
            }
        }
    },
    "gift-1": {
        "giftCertificate": "gift-1",
        "name": "Dynamic gift certificate",
        "currencyOfSaleOnly": false,
        "showGiftAmount": true,
        "type": "anyAmount"
    }
}
```

As you can see, `Dynamic gift certificate` can have any value, while the `Pre-defined gift certificate` allows you to only purchase a GB for 10 USD, 100 SEK or 1000 JPY.

Once you have the list of available GCs, you can add them to your selection by calling [POST /selections/{selection}/gift-certificates/{giftCertificate}](https://docs.centra.com/swagger-ui/?api=ShopAPI#/default/post_selections__selection__gift_certificates__giftCertificate_), for example:
`POST /selections/{selection}/gift-certificates/gift-2`

In case of a `Dynamic Priceoff` certificate, you will either need to add `"amount": X` to your POST, or call [POST /selections/{selection}/gift-certificates/{giftCertificate}/amount/{amount}](https://docs.centra.com/swagger-ui/?api=ShopAPI#/default/post_selections__selection__gift_certificates__giftCertificate__amount__amount_), e.g.:
`POST /selections/{selection}/gift-certificates/gift-1/amount/100`
The amount is always specified in the currency of the selection.

Once the certificate is added to your selection, you can proceed with the normal payment flow - with [POST /selections/{selection}/payment](https://docs.centra.com/swagger-ui/?api=ShopAPI#/default/post_selections__selection__payment) followed by [POST /selections/{selection}/payment-result](https://docs.centra.com/swagger-ui/?api=ShopAPI#/default/post_selections__selection__payment_result) to finalise it. Additionally, you can add `"giftMessage": "ABC"` to your `POST /payment` call. This message will be saved on the order.

Once the payment is finalised, the Order will have an automatic Shipment created and completed, resulting in Order being finalised as well. Your customer will receive the purchased voucher code via e-mail. You can also see the generated credit voucher in Promo -> Vouchers.
