## General information

### Header authorization
In [Altair GraphQL](https://altair.sirmuel.design/) you click on a sun rays (?) icon on the left and set header name to Authorization, and content to Bearer `{{graphql_token}}`. `{{graphql_token}}` is a string value , it should look like `c80d3d270c68ec422401fcfe2e195ee4`.

//TBD IMAGE

### Cookie authorization

Add cookie named `graphql-access` with only the access token as value.

For using Centra graphql you need user token with correct permissions. This could be done in two ways:
- in AMS
- using graphql and AMS admin token

## AMS way to get token
You need to go to

**System -> Api Tokens -> "+ Integration API TOKEN"**

Here we are able to provide restrictions, select permissions, and expiration time.
Requirements for generating token are:
- Providing description
- At least one permission
- Expirations time should be provided.

After that, we could click save, and we will be redirected to page, where

## Graphql generating user access token
Admin auth token for creating user for fetching data
To fetch token, we need to go to
**Diagnostics -> SysInfo -> GraphQL Access**
and  get(generate) Admin token //screenshot
This token is used to create user, which will communicate with backend.
GraphQL endpoint is usually 

`{centra_url}/graphql`

To create user we need proper authorization, so we need to add Admin token, to request header

`Authorization: Bearer {{admin_token}}`

Now, we can use mutation to create user to work with GraphQL

Mutation will look like this:

```

mutation token($user: GraphQLUserInput!, $ttl: Int) {
  generateToken(user: $user, ttl: $ttl) {
    token
    isValid
    expiresAt
    user {
      name
      permissions
    }
  }
}
```

Here - `GraphQLUserInput` is instance of a user,

it looks like:
```
{
"name": "John",
"permissions": ["*"]
}
```

`ttl` - is time to live in seconds. This is used to limit lifetime of token.
```
"ttl": 86400
```

Response should be like

```

```