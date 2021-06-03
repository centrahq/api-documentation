# Register payment

```eval_rst
.. api-name:: Subscription API
   :version: 1

.. endpoint::
   :method: POST
   :url: *base*/subscription/payment

.. authentication::
   :api_key: true
```

This will complete the subscription. Often called when user comes back to `payment_url` from `/subscription/order`. All GET/POST-params sent by the payment plugin needs to be attached to this call.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``id``

       .. type:: string
          :required: true

     - The subscription ID from :doc:`Create Subscription </reference/stable/subscription-api/create-subscription>`.

   * - ``payment``

       .. type:: string
          :required: true

     - URI of payment plugin to be used. Needs to be set up before as a payment plugin for the store.

   * - ``checksum``

       .. type:: string
          :required: true

     - The value from the ``checksum`` response from :doc:`Create Subscription </reference/stable/subscription-api/create-subscription>`.

   * - **[all GET/POST params sent by payment provider]**

     - Attach all GET/POST parameters sent from the payment provider to the ``payment_url`` from :doc:`Create Subscription </reference/stable/subscription-api/create-subscription>`. These will be used to validate if the payment was successful.

```

## Request examples

```eval_rst
.. code-block:: http
   :linenos:

   POST <base>/subscription/payment HTTP/1.1
   Content-Type: application/x-www-form-urlencoded

   id=3&payment=nets&[+all GET/POST params sent by payment provider]

```

## Response

`200` `Content-type: application/json`

```eval_rst
.. list-table::
   :widths: auto

   * - ``status``

       .. type:: string
          :required: true

     - ``ok`` if success, else a message explaining what went wrong.

   * - ``id``

       .. type:: int
          :required: true

     - The ID of the subscription that was created.

   * - ``amount``

       .. type:: decimal2 (0.00)
          :required: true

     - The total value of the subscription.

   * - ``shipping``

       .. type:: decimal2 (0.00)
          :required: true

     - The shipping value for the first order of the subscription.

   * - ``itemCount``

       .. type:: int
          :required: true

     - The total amount of products in the subscription.

   * - ``currency``

       .. type:: string

     - The currency that the subscription was registered with, ``SEK``, ``USD``, ``EUR``, etc.

   * - ``address``

       .. type:: object

     - An address object with the customer information.

       .. list-table::
          :widths: auto

          * - ``firstName`` ``lastName``

              .. type:: string

            - The name of the customer.

          * - ``address`` ``coaddress`` ``city`` ``state`` ``zipcode`` ``phoneNumber``

              .. type:: string

            - The customer's address information.

          * - ``country``

              .. type:: string

            - The country of the customer. ISO-Alpha-2 (``SE``, ``US``, ``GB`` etc)

   * - ``createdAt``

       .. type:: string

     - The date in ``Y-m-d H-i-s`` format when the subscription was created.

   * - ``startDate``

       .. type:: string

     - The date in ``Y-m-d`` format when the subscription starts.

   * - ``nextOrderDate``

       .. type:: string

     - The date in ``Y-m-d`` format when the subscription has next shipping.

   * - ``interval``

       .. type:: int

     - The interval between each subscription. Depending on `intervaltype` it will be months or days.

   * - ``intervalType``

       .. type:: string

     - The type of interval for the subscription.

       * ``Month`` interval is in months.
       * ``Day`` interval is in days.

   * - ``receipt``

       .. type:: string

     - Html snippet that contains a receipt for a subscription payment. Is not null for Klarna payments.

   * - ``error``

       .. type:: boolean
           :required: false

     - If ``true``, the payment was not successful. The ``status`` should contain information on why.

```

## Response example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "ok",
     "id": 3,
     "amount": "900.00",
     "shipping": "20.00",
     "itemCount": 2,
     "currency": "SEK",
     "address": {
       "firstName": "Kalle",
       "lastName": "Anka",
       "phoneNumber": "+4687203333",
       "address1": "Malarvarvsbacken 8",
       "address2": "c/o Young Skilled AB",
       "zipCode": "11733",
       "city": "Stockholm",
       "state": "",
       "country": "SE"
     },
     "createdAt": "2020-05-05 15:00:00",
     "startDate": "2020-05-05",
     "nextOrderDate": "2020-05-06",
     "interval": 14,
     "intervalType": "Day",
     "receipt": "<div>...</div>"
   }
```

## Error example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "Could not register customer",
     "error": true
   }
```
