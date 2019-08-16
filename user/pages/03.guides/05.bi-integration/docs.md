---
title: Integrating Centra with Business Intelligence systems
altTitle: BI integration
excerpt: Learn how to integrate your Centra with your Business Intelligence system
taxonomy:
  category: docs
---

### Background

Centra is designed to make it as easy as possible to integrate powerful Business Intelligence (BI) tools and to make the integrations easy to maintain. By combining data from Centra and other systems, Business Intelligence specialists can create tailored dashboards and reports to analyze any business to any level of detail.

While legacy BI integrations often rely on raw database exports, data from Centra is exported through an API with a clearly defined interface. This layer of abstraction between Centra’s data storage and the BI system provides 3 distinct advantages:

1. The API which forms the format contact between Centra and the BI system remains constant when Centra is updated. Thus it becomes feasible to maintain the integration even though Centra is releasing new versions every 2 weeks
2. Under the hood Centra can use its high-speed multi-tenant database to enable instant access to enable real time analytics of data that would traditionally only have been possible to analyze in nightly batch jobs
3. The API offers an integrated event mechanism that can notify the BI system of changes and trigger an immediate transfer of data. Thus, transferring data to the BI system can happen instantaneously when data is updated

### Accessing data

Centra data should be accessed through Centra’s GraphQL based Integration API. Centra Integration API offers access to virtually all data in Centra and thus enables creating a 360 degree view of the business being analyzed. Unlike the Centra Store API, Centra Integration API does not operate on a per-store level, instead all data in Centra is available through a single Integration API.

The GraphQL format is particularly well-suited for BI applications, as queries can be formed in any way required to access the data to be analyzed, and the data can be structured in the most convenient form for importing into the BI application’s structure.

[notice-box=info]
Unlike Centra’s APIs for building E-commerce stores, Centra Integration API does not offer any response time guarantees. Complex queries can be formed, resulting in complex database operations with slow response time. Make sure to respect set rate limitations and use pagination when exporting data.
[/notice-box]

### Data security

Centra Integration API can be configured with different access rights. For BI applications, read-only access to all data is recommended.

[notice-box=info]
Ensure security is managed carefully when using Centra Integration API. The API offers access to virtually all data in Centra, including personal information and sensitive business information.

Ensure all applicable legislation and privacy agreements with customers are respected before using Centra Integration API to export data from Centra.
[/notice-box]

### Data format

The data exported from the API is documented in the [API reference section](https://centra-api-documentation-demo.herokuapp.com/api-references), which also includes an explanation of how to use the GraphQL API.

[notice-box=info]
The data model described in the API reference assumes full access to all data. With limited access rights, the data set available will be reduced.
[/notice-box]
