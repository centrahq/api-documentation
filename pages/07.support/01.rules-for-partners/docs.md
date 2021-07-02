---
title: How we work - rules of engagement with our Partners
altTitle: Rules of Engagement
taxonomy:
    category: docs
child_type: docs
---

Let's talk about some rules we strive to keep when working with our Partners. We hope to build efficient and professional relations, resulting in creating more amazing integrations for more and more happy Customers.

## How we work - general rules

#### Philosophy #1: We are here to help

Centra is great. We love our product, and we want to convince you about it.

On our Customer's side, we do that by guiding each new brand into configuring and using Centra in the way appropriate for their Products and sales logistics, including config like Products catalog, shipping options, taxes appropriate to their Markets, Warehouse and Stock configuration, currencies, languages and translations. After initial onboarding, it is the responsibility of the Customer to keep their data updated with new Products, Markets, etc. Therefore, as an Integration Partner, you can and should expect the data to be provided by the Customer.

On our Partner's side, we love sharing our knowledge, guides we wrote for different features, Swaggers and changelogs, and any piece of knowledge you may need to properly build and test your integration. Whether you are building a website, an app, ERP integration, pick-and-pack Warehouse integration, or simply playing with our brand new GraphQL API, we either have or should have a place in our docs where you can find what you're looking for. And if we don't - that's why we want to be able to talk to all of you directly in Slack. After you've read our basic docs, we would also like to invite you to our Partner webinars, where we demo the Centra UI as well as the most commonly used APIs and their functions. And that's actually the order we'd like to do that - first, we'll ask you to familiarize yourself with Centra basics, so that you understand the idea of how it works, and once you do, and can follow our specific docs to solve your use cases, then we will be happy to help you out in direct Slack support. Because of the sheer amount of Customers and Partners we need to talk to each day, we hope you understand why we like to work this way.

#### Philosophy #2: Instead of solving every problem for you, we prefer to educate you on how to solve it yourself

We will be happy to answer any of your questions, either directly or by pointing to our documentation, and if something is missing - we will add it for sure. If you forgot how something works - just ask, and we will remind you. However, after explaining a concept once or twice, we will expect you to have that knowledge and not ask the same questions every week. We hope you understand - we have hundreds of customers developed with dozens of different Partners, so it would be impossible for us to give you 100% of our time and focus. The more you learn at early stages of working with Centra, the easier it will be to later work on adding more customers and new integrations.

We would also love if you introduced Centra to your new colleagues - you and they will have a common perspective on using Centra, and we believe explanation coming from a person working on the same problem is easier to understand than any documentation.

Having said that, we strive to have the best available docs, which we would measure by how many Partners are able to build working solutions without having to ask us any questions. We've had single integrations like that in the past already, and we're proud of that fact.

#### Philosophy 3: Technical Support and Professional Services are two completely different things

What we do for our Partners:

* **Technical support**  
  If you have technical questions, either about Centra UI or our APIs, let us know! Please make sure to always include as much details as you can - which customer and environment you are working with, what you are trying to achieve, how far have you managed to follow our guides and documentation, and so on

* **Bug reports and verification**  
  If you encounter any behaviour that deviates from documentation or common sense, let us know! We want Centra to work reliably for everyone, so any technical issues will be looked at and fixed, if deemed necessary.

* **Questions about technical features**  
  If you have questions about new features, specific APIs, things mentioned in our newsletter - ask away! Even if we don't respond immediately, we will find a way to explain it to you as best we can.

* **(Optional) Basic monitoring of your websites (Pingdom-based with alerts in Slack)**  
  With this we can help you share the burden of monitoring status of Customer's websites - we will discover if it fails to load, warn you about certificates that will soon expire, etc.

What we don't do:

* **Professional services (unless paid for)**  
  If your request is out of scope of technical support, and you still want us to spend time working on it, we should agree on how much our time is going to cost.

* **Filling environments with data**  
  This is the responsibility of our common Customers - we give them education and tools to set up or import Products and their media, Markets, Shipping alternatives, Taxes, etc. We don't have automated tools to, for example, generate test orders - this is near to impossible to do well, since the amount of permutations of different setups, plugins, flows and integrations grows exponentially with every new, unique Customer.

* **Testing of customer's configurations / plugins**
  Centra should throw errors when, for example, payment plugin fails to authenticate. Most of the times Centra can't help, though, since Customers have their own agreements with Payment / E-mail / other providers and any issues with those services is outside of our control.

* **Application design advice**  
  Don't ask us how many Warehouses should be set up - this is something our Customer should know!

For example:

<div class="tableWrapper" markdown='1'>
| What we do | What we don't do |
| --- | --- |
| **Products catalog** |
| We will show you example products and point to our documentation for creating new ones | We will not fill your environment with meaningful products, for that we have bulk actions in Centra UI, and also the products import function |
| **Custom attributes** |
| We will help you understand the concepts and give you some examples | We will not build 10+ attribute definitions for you, but we can do a review of the ones you have added |
| **Test orders** |
| We will guide you how to create them, explain the order flow, teach you how to create / complete shipments, etc. | We will not generate dozens of test order permutations for you, those should be generated by you or the customer, based on required use-cases, payment and shipping methods |
| **Stress and performance tests** |
| We will tell you how we usually do them and give you hints to start | We will not run them for you, unless it's treated as paid Professional Services work |
</div>

## How we communicate - rules in Slack

#### Ping us when you need help

`@here` pings everyone who's online (has green dot status). Used to get our attention, it's fine if it takes us up to an hour to respond (usually much sooner, though). `@channel` pings everyone in that channel, currently available or not. Only doesn't ping people who have their notifications manually disabled. Use with caution, mostly to report urgent issues, sev 1 and such.

#### Do not use PM for business/technical questions

Ping the whole channel, not individual people. Don't PM (private message), unless it's for sharing API secrets, passwords, or for personal reasons. Any questions are better off asked in the public channel, both because more people will see it, and are therefore likely to respond, and because once the question is answered, we all get to share this knowledge and know-how. Plus, people are likely to be in meetings, so PMing a single person does not guarantee fast response times.

#### Provide full details every time

Please understand that Centra has way over 100 customers, and we're helping many of them on the same day, everyday. You might be working on a specific customer/integration for weeks, so when you report an issue it might be obvious to you who this is for, but it's not for us. It will help a lot if you always reported us with:
- Name of the customer
- Which environment is this (Prod / QA)
- Which API instance you are using
- What is the issue you are seeing, and what would be the expected result you're not seeing
- Be as specific as you can be! If you're seeing wrong behaviour for some product, link to this product. If it's about category translations, tell us which category and which language.

#### Be nice :)

We are here to help, but it's not like all of us know all the answers at all time. Sometimes we'll help immediately, sometimes we will need to consult internally, and sometimes we will tell you the issue is not on our end and you need to contact the PSP or external service support. In any case, once we said we will look into a problem, pinging `@here` every 20 minutes will not help in speeding up the process. We understand you might be anxious, but we can be, too. We are all human, and we work best when we use positive reinforcement, not rudeness and shouting ;)
