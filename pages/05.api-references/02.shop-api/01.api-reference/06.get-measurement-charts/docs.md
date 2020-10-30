---
title: Shop API - GET Measurement Charts
altTitle: GET Measurement Charts
excerpt: Fetching a single or multiple collections.
taxonomy:
  category: docs
---

# Get measurement charts

```text
GET  *base*/measurement-charts
```

```text
GET  *base*/measurement-charts/*measurementChartId*
```

Fetches a specific measurement chart referenced by its ID, or the **full** list of measurement charts.

If the measurement-chart-id parameter is specified, one measurement chart is fetched, otherwise **all measurement charts** in the catalog are fetched.

## Parameters

[parameter data="measurementChartId" datatype="int" isRequired=false storetype="b2b b2c" sublevel=1]
Measurement chart ID as integer.
[/parameter]

## Response
`200` `Content-type: application/json`

[parameter data="measurementChartId" datatype="int" isRequired=false storetype="b2b b2c" sublevel=1]
The ``measurementChartId`` for the measurement chart object.
``"20": {"name": "Women Jeans"}`` for measurement chart ID 20.
[/parameter]

[parameter data="name" datatype="string" sublevel=2]
The name of the measurement chart.
[/parameter]

[parameter data="rows" datatype="object" sublevel=2]
An object with all values for the table. This could be used as a lookup table to insert the proper values into a measurement chart. The ``columnNames`` and ``rowNames`` should be used to generate the measurement chart since they are sorted properly. The key values in the object are each row name corresponding with the values in ``rowNames``.
``"rows": {"Length": {...}}`` means one row in the measurement chart will have the title ``Length``. The value of each item is another object with the columns.
[/parameter]

[parameter data="value of each item" datatype="object" sublevel=3]
The columns for this row. The key values in the object are each column name corresponding with the values in ``columnNames``.
[/parameter]

[parameter data="value of each item" datatype="string" sublevel=4]
The value that should be in the specific combination of ``rowNames[i] + columnNames[i]``. This is a lookup table to use when generating the measurement chart.
You should do a lookup like this: ``columnValue = rows[rowName][columnName]``.
[/parameter]

[parameter data="rowNames" datatype="array" sublevel=2]
A sorted list of the rows that should be listed in the measurement chart. Each value corresponds with the object in ``"rows": {}``.
[/parameter]

[parameter data="columnNames" datatype="array" sublevel=2]
A sorted list of the columns that should be listed in the measurement chart. Each value corresponds with the object in each row from ``"rows": {"RowHeader": {"Column 1": 12}}``.
[/parameter]

[parameter data="unit" datatype="string" sublevel=2]
The unit which the measurement chart is calculated in. For example ``cm``.
[/parameter]

## Response example

```http
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

```http
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

```http
   HTTP/1.1 404 Not Found
   Content-type: application/json

   {
      "errors" : {
         "measurementChart" : "not found"
      }
   }
```