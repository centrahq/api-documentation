# Voyado

## How to do abandoned cart with Voyado?

Depending on your set up with Voyado and what API you use, there are different solutions to solve a proper abandoned cart solution.

### CheckoutAPI

With the CheckoutAPI the user has a token key that is the one keeping track of the current selection. You can provide the token for the cart as the value for Voyado to send in the abandoned cart-link. The cart-link should then change to the token provided, so the customer that clicks the link in the abandoned cart email would switch their token to the one provided. There's no endpoint to trigger to switch the token, but rather the `API-token`-value already being used in the communication with Centra is the one to be switched.

### ShopAPI

With the ShopAPI you always know the current selection ID for the open cart, since all those endpoints are under `/selections/{selectionId}/`. If you're using a Javascript solution for Voyado to register the current selection, you can provide Voyado with the selection ID of the current cart. You can then make an endpoint that will change the current user's selection ID to the one provided. There's no endpoint to trigger a switch to the new selection, but you would then make sure the `selectionId` being used in the communication with Centra is switched. Also make sure you validate the value being sent as only being `^[a-f0-9]+$`. You could also make a `GET /selections/{selection}` to validate that the selection still exists.

## How to use vouchers with Voyado promotions?

### Overview
This guide explains how you can combine Voyado's promotions with Centra's voucher logic, to offer your members in Voyado discounts or perks such as free shipping. You have access to the full voucher logic in Centra when designing promotions in Voyado and Centra ensures promotions are redeemed from Voyado once used. 

### Prerequisites
In this scenario we assume that you already have an account in Voyado and configured the plugin `Voyado v2` in Centra.

### In Centra
The first thing you need to do is add a new voucher to your store. The only thing that is required for this scenario is `Method: code`, `Max usage: 0` and `Start/stop date` set accordingly to your needs. The `code` can be anything you want. 

### In Voyado
It's time to add new promotion in Voyado.

1. Login to your account in Voyado
1. Go to Promotions > Active
1. Select New promotion > Multi-channel promotion
1. Create promotion
1. Set `Start date` and `End date` the same as in Centra
1. Check `Can be used online`
1. Select `External promotion code` and provide Centra's voucher code in the next field
1. It's up to you how you fill out the other fields - the presentation part can be useful for your frontend application
1. Save it, then Activate it
1. Assign contacts

```eval_rst
.. image:: images/voyado-promotions-with-voucher.png
   :scale: 50 %
```

### Frontend

You present available promotions from Voyado to your customer by fetching them from Voyado. 

Remember to query Voyado with additional header `apikey`.

If you don't have your customer's Voyado ID
1. Query `https://{{yourVoyadoDomain}}/api/v2/contactoverview?contactType={{type}}&email={{email}}`
1. In the response you'll get `promotions` list.

If you have your customer's Voyado ID use `https://{{yourVoyadoDomain}}/api/v2/contacts/{{customerVoyadoId}}/promotions?redemptionChannelType=ECOM` which will return list of promotions for this user.

A single promotion looks like this
```json
{
    "id": "12704681-e1d9-4861-9e75-abad00de9a6a",
    "externalId": null,
    "type": "Multichannel",
    "name": "Demo promotion",
    "expiresOn": null,
    "heading": "Demo promotion title",
    "description": "Demo description",
    "redeemed": true,
    "redeemedOn": "2020-05-07T13:14:48+02:00",
    "imageUrl": null,
    "link": null,
    "redemptionChannels": [
      {
        "type": "ECOM",
        "valueType": "EXTERNALOFFER",
        "value": "code",
        "instruction": null
      }
    ]
  }
```

Only show the customer promotions that have redemption channel with value type `EXTERNALOFFER` and were not redeemed yet. As you can see in example above - your voucher code is in redemption channel under `value` key.
When customer selects the promotion, you should apply this code to the active selection.

When paying for an order instruct Centra to redeem Voyado's promotion so it won't be shown again. Centra will redeem the promotion from Voyado if and only if the payment is successful. 
Example payment query body:
```json
{
    "paymentMethod": ...,
    "termsAndConditions": ...,
    "paymentReturnPage": ...,
    "additionalFields": {
    	"voyado_promotion_id": "12704681-e1d9-4861-9e75-abad00de9a6a"
    },
    "address": {...
    }
}
```


### Security
Remember that you shouldn't reveal your Voyado's `apikey` to public. These queries should be done on backend.

Anyone with access to the vocuher `code` will be able to use it, so make sure to keep it secret if you don't want that. 
