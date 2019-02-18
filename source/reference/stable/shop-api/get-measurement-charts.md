# Get measurement charts

```eval_rst
.. api-name:: Shop API
   :version: 1

.. endpoint::
   :method: GET
   :url: *base*/measurement-charts

.. endpoint::
   :method: GET
   :url: *base*/measurement-charts/*measurementChartId*

.. authentication::
   :api_key: true
```

Fetches a specific measurement chart referenced by its ID, or the **full** list of measurement charts.

If the measurement-chart-id parameter is specified, one measurement chart is fetched, otherwise **all measurement charts** in the catalog are fetched.

## Parameters

```eval_rst
.. list-table::
   :widths: auto

   * - ``measurementChartId``

       .. type:: int
          :required: false

     - Measurement chart ID as integer.

```

## Response
`200` `Content-type: application/json`

```eval_rst
.. list-table::
   :widths: auto

   * - object key

       .. type:: measurement chart object
          :required: true

     - The ``measurementChartId`` for the measurement chart object.

       ``"20": {"name": "Women Jeans"}`` for measurement chart ID 20.

       .. list-table::
          :widths: auto

          * - ``name``

              .. type:: string

            - The name of the measurement chart.

          * - ``rows``

              .. type:: object

            - An object with all values for the table. This could be used as a lookup table to insert the proper values into a measurement chart. The ``columnNames`` and ``rowNames`` should be used to generate the measurement chart since they are sorted properly. The key values in the object are each row name corresponding with the values in ``rowNames``.

              ``"rows": {"Length": {...}}`` means one row in the measurement chart will have the title ``Length``. The value of each item is another object with the columns.

              .. list-table::
                 :widths: auto

                 * - value of each item

                     .. type:: object

                   - The columns for this row. The key values in the object are each column name corresponding with the values in ``columnNames``.

                     .. list-table::
                        :widths: auto

                        * - value of each item

                            .. type:: string

                          - The value that should be in the specific combination of ``rowNames[i] + columnNames[i]``. This is a lookup table to use when generating the measurement chart.

                            You should do a lookup like this: ``columnValue = rows[rowName][columnName]``.

          * - ``rowNames``

              .. type:: array

            - A sorted list of the rows that should be listed in the measurement chart. Each value corresponds with the object in ``"rows": {}``.

          * - ``columnNames``

              .. type:: array

            - A sorted list of the columns that should be listed in the measurement chart. Each value corresponds with the object in each row from ``"rows": {"RowHeader": {"Column 1": 12}}``.

          * - ``unit``

              .. type:: string

            - The unit which the measurement chart is calculated in. For example ``cm``.

```

## Response example

```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 200 OK
   Content-type: application/json

   {
     "2": {
       "name" : "Test",
       "rows" : {
          "Length" : {
             "L" : "30",
             "M" : "27",
             "S" : "23"
          }
       },
       "columnNames" : [
          "S",
          "M",
          "L"
       ],
       "unit" : "cm",
       "rowNames" : [
          "Length"
       ],
       "measurementChart" : "2"
     }
   }
```

Fetching a specific collection using `collectionId`:

```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 200 OK
   Content-type: application/json

   {
      "name" : "Test",
      "rows" : {
         "Length" : {
            "L" : "30",
            "M" : "27",
            "S" : "23"
         }
      },
      "columnNames" : [
         "S",
         "M",
         "L"
      ],
      "unit" : "cm",
      "rowNames" : [
         "Length"
      ],
      "measurementChart" : "2"
   }
```

## Error example

```eval_rst
.. code-block:: http
   :linenos:

   HTTP/1.1 404 Not Found
   Content-type: application/json

   {
      "errors" : {
         "measurementChart" : "not found"
      }
   }
```
