# Update customer

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: PUT
   :url: *base*/customers/*customerId*

.. authentication::
   :api_key: true
```

Update customer information.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``customerId``

       .. type:: int
          :required: true

     - The ``customerID`` from :ref:`List customers <order-api-list-customers>`.

   * - ``firstName`` ``lastName`` ``...``

       .. type:: customer object

     - The customer object is explained in :ref:`Get Customer Parameters <order-api-get-customer-response>`.

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   PUT <base>/customers/4234 HTTP/1.1
   Content-type: application/json

   {
       "firstName": "Benjamin",
       "lastName": "Simon",
       "address1": "",
       "address2": "New Address2",
       "zipCode": "10500",
       "city": "BRIGHTON",
       "country": "US",
       "state": "CA",
       "phoneNumber": "9004505123",
       "gender": "",
       "consents": [
         {
           "key": "firts_con",
           "consented": true
         },
         {
           "key": "second_con",
           "consented": false,
           "version": "1.0",
           "language": "EN"
         }
       ]
   }
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

   * - ``customer``

       .. type:: object
          :required: true

     - Customer object. The customer object is explained in :ref:`Get Customer Parameters <order-api-get-customer-response>`.

```

## Response example

```eval_rst
.. code-block:: json
   :linenos:

   {
       "status": "ok",
       "customer": {
           "customerId": "1",
           "email": "benjamin.simon@example.com",
           "firstName": "Benjamin",
           "lastName": "Simon",
           "address1": "",
           "address2": "New Address2",
           "zipCode": "10500",
           "city": "BRIGHTON",
           "state": "CA",
           "country": "US",
           "phoneNumber": "9004505123",
           "newsletter": true,
           "gender": "",
           "registered": false,
           "consents": [
               {
                   "key": "test_key1",
                   "name": "Consent1",
                   "consented": false,
                   "text": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley ",
                   "language": "",
                   "version": "",
                   "created": "2018-03-15 20:42:59",
                   "modified": "2018-03-15 20:42:59"
               },
               {
                   "key": "firts_con",
                   "name": "",
                   "consented": true,
                   "text": "",
                   "language": "",
                   "version": "",
                   "created": "2018-03-21 12:17:54",
                   "modified": "2018-03-21 12:17:54"
               },
               {
                   "key": "second_con",
                   "name": "",
                   "consented": false,
                   "text": "",
                   "language": "EN",
                   "version": "1.0",
                   "created": "2018-03-21 12:17:54",
                   "modified": "2018-03-21 12:17:54"
               }
           ],
           "created": "2018-03-15 20:42:59",
           "modified": "2018-03-15 20:42:59"
       }
   }

```

## Error example

```eval_rst
.. code-block:: json
   :linenos:

   {
     "status": "no",
     "msg": "The customer was not found."
   }
```
