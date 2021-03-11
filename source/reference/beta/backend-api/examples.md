#### All markets with countries for store ID 1:
##### Request All markets with countries for store
```
{
  markets(where: {storeId: 1}, sort: [id_DESC]) {
    id
    name
    assignedToCountries {
      name
      code
    }
  }
}
```
#### Response example

#### The whole folder structure:
##### Request example
```
{
  folders(where: {isTopFolder: true}) {
    id
    name
    childFolders {
      id
      name
      childFolders {
        id
        name
      }
    }
  }
}
```
##### Response example

#### Latest confirmed wholesale orders with account and buyer data.
This one uses [Relay connection](https://relay.dev/graphql/connections.htm) format, so you can see `totalCount` and whether there is a previous page (because it's backward pagination):

##### Request example
```
{
  orderConnection(last: 10, where: {storeType: WHOLESALE, status: CONFIRMED}, sort: orderDate_ASC) {
    totalCount
    pageInfo {
      hasPreviousPage
      startCursor
    }
    edges {
      node {
        id
        number
        grandTotal { 
          value
          currency { code }
          formattedValue
        }
        orderDate (format: "Y-m-d")
        
        ...on WholesaleOrder {
          account { name }
          buyer { email }
        }
      }
    }
  }
}
```
##### Response example