```eval_rst
.. _order-api-list-customers:
```

# List customers

```eval_rst
.. api-name:: Order API
   :version: 1

.. endpoint::
   :method: GET
   :url: *base*/customers

.. authentication::
   :api_key: true
```

Return list of the customers.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``limit``

       .. type:: int
          :required: false

     - Limit amount of customers returned.

   * - ``offset``

       .. type:: int
          :required: false

     - Offset how far in to start returning customers.

   * - ``email``

       .. type:: string
          :required: false

     - Return a specific customer.

   * - ``created``

       .. type:: date
          :required: false

     - Get all customers added after a certain date.

   * - ``modified``

       .. type:: date
          :required: false

     - Get all customers modified after a certain date.

   * - ``xml``

       .. type:: boolean
          :required: false

     - Response in xml format instead of json.
```

## Request example

```eval_rst
.. code-block:: http
   :linenos:

   GET <base>/customers?limit=5&offset=5 HTTP/1.1

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

   * - ``customers``

       .. type:: array
          :required: true

     - Array of customers. The customer object is explained in :ref:`Get Customer Parameters <order-api-get-customer-response>`.

```

## Response example

```eval_rst
.. code-block:: json
   :linenos:

   {
       "status": "ok",
       "customers": [
           {
               "customerId": "1",
               "email": "max.buch@example.com",
               "firstName": "Max",
               "lastName": "Buch",
               "address1": "",
               "address2": "",
               "zipCode": "",
               "city": "",
               "state": "",
               "country": "SE",
               "phoneNumber": "",
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
                   }
               ],
               "created": "2018-03-15 20:42:59",
               "modified": "2018-03-15 20:42:59"
           },
           {
               "customerId": "6",
               "email": "felix.parker@example.com",
               "firstName": "Felix",
               "lastName": "Parker",
               "address1": "",
               "address2": "Forest st. 102",
               "zipCode": "95131",
               "city": "San Jose",
               "state": "CA",
               "country": "US",
               "phoneNumber": "",
               "newsletter": false,
               "gender": "",
               "registered": true,
               "consents": [],
               "created": "2018-03-15 20:42:59",
               "modified": "2018-03-15 20:42:59"
           }
       ]
   }
```
