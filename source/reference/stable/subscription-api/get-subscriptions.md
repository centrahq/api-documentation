# Get subscriptions

```eval_rst
.. api-name:: Subscription API
   :version: 1

.. endpoint::
   :method: GET
   :url: *base*/subscription/subscriptions?customerEmail=*email*

.. authentication::
   :api_key: true
```

Receive a list of all subscriptions for the customer.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``customerEmail``

       .. type:: string
          :required: true

     - Customer email address.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   GET <base>/subscription?customerEmail=example@centra.com HTTP/1.1

```

## Response

`200` `Content-type: application/json`

```eval_rst
.. list-table::
   :widths: auto

   * - ``status``

       .. type:: string
          :required: true

     - ``ok`` if success, else ``no``.

   * - ``subscriptions``
   
       .. type:: array
          :required: true
   
     - List of all customer subscriptions.

       .. list-table::
          :widths: auto

          * - ``status``

              .. type:: string
                 :required: true

            - The status of the subscription.

          * - ``id``

              .. type:: int
                 :required: true

            - The ID of the subscription.
           
          * - ``amount``

              .. type:: decimal2 (0.00)
                :required: true

            - The total value of the subscription.

          * - ``shipping``

              .. type:: decimal2 (0.00)
                :required: true

            - The shipping value of the subscription.

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
        
          * - ``pricelist``
          
              .. type:: string
          
            - Subscription price list id.

          * - ``packages``

              .. type:: array

            - List of subscription packages. Contains packages IDs.

          * - ``customer``
          
              .. type:: string
          
            - Subscription customer id.
```

## Response example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "ok",
     "subscriptions": [
       {
         "status": "active",
         "id": 3,
         "amount": "900.00",
         "shipping": "20.00",
         "itemCount": 2,
         "currency": "SEK",
         "createdAt": "2020-05-05 15:00:00",
         "startDate": "2020-05-05",
         "nextOrderDate": "2020-05-06",
         "interval": 14,
         "intervalType": "Day",
         "pricelist": "19",
         "packages": ["1"],
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
         "customer": "132"
       },
       {
         "status": "paused",
         "id": 4,
         "amount": "500.00",
         "shipping": "20.00",
         "itemCount": 1,
         "currency": "SEK",
         "createdAt": "2020-04-03 12:00:00",
         "startDate": "2020-04-03",
         "nextOrderDate": "2020-04-04",
         "interval": 14,
         "intervalType": "Day",
         "pricelist": "19",
         "packages": ["1"],
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
         "customer": "132"
       }
     ]
   }
```
