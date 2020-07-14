# Update subscription

```eval_rst
.. api-name:: Subscription API
   :version: 1

.. endpoint::
   :method: PUT
   :url: *base*/subscription/subscription/*id*

.. authentication::
   :api_key: true
```

Update a subscription.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``status``

       .. type:: enum
          :required: false

     - Subscription status

       * ``active`` Subscription is active.
       * ``paused`` Subscription is paused.
       * ``cancelled`` Subscription is cancelled.
```

## Request examples

```eval_rst
.. code-block:: http
   :linenos:

   POST <base>/subscription/1 HTTP/1.1
   Content-Type: application/x-www-form-urlencoded

   status=active

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
   
     - List of subscriptions.

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
          
              .. type:: string
          
            - The interval between each subscription. Depending on `intervaltype` it will be months or days.

          * - ``intervalType``
          
              .. type:: string
          
            - The type of interval for the subscription.
          
              * ``Month`` interval is in months.
              * ``Day`` interval is in days.

          * - ``error``

              .. type:: boolean
                 :required: false

            - If ``true``, the subscription update was not successful. The ``status`` should contain information on why.
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
         "nextShip": "2020-05-06",
         "interval": "14",
         "intervalType": "Day"
       }
     ]  
   }
```

## Error examples

Subscription not found:

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "Subscription not found",
     "error": true
   }
```

Invalid subscription status:

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "Invalid status provided",
     "error": true
   }
```

Restore cancelled subscription error:

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "Cannot restore cancelled subscription",
     "error": true
   }
```
