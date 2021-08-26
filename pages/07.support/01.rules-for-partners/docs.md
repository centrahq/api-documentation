---
title: Cooperation with our Partners
altTitle: Best practice when in contact with us
taxonomy:
    category: docs
child_type: docs
---

We strive to be fast, effecient and friendly when working with our Partners. After all, if our cooperation is succesfull our shared clients will be too.

TL;DR: We are here to help, but we are also here to educate and guide where ever possible. Below is a short list of the types of things we can support you with, but we've also noted down some things that we try to coach you to learn instead.

<div class="tableWrapper" markdown='1'>
| What we do | What we don't do |
| --- | --- |
| **Products catalog** |
| We will show you example products and point to our documentation for creating new ones, [like this Support article](https://support.centra.com/centra-sections/general/catalog/adding-a-product) | We prefer not import entire product groups or catalogues, instead we'll tell you how to complete bulk actions in Centra UI, in this example our [products import](https://support.centra.com/centra-sections/general/catalog/importing-updating-products-from-an-excel-file) function |
| **Custom attributes** |
| We'll help you to understand the concept of attributes and share some examples with you [in our Custom Attributes docs](/overview/custom-attributes) | However, we will not build multiple attribute definitions for you, reviewing one you've created yourself and then advising you on the best outcome is much more effecient for us all.  |
| **Test orders** |
| We are happy to guide you on creating test orders, can explain the [order flow](/overview/orderflow) and even teach you how to [create / complete shipments](https://support.centra.com/centra-sections/retail-b2c/sales/expediting-a-b2c-order). | Creating multiple test order variations though is something you'll benifit from learning to do yourself. We'll aslo show the client how of course. based on required use-cases.
| **Stress and performance tests** |
| Once again, teaching you to run stress tests without our help is a much more effecient way to develop skillsets, and once you know how you have those skills in house.  |
</div>

## Our work - general guidence

#### Philosophy #1: We are here to help

Centra is awesome. We love our product, and we want to convince you of the same.

From a client support perspective, we do that by teaching each new brand about how to configure and use Centra in the way that's most appropriate for their Product and store requirements. We help them understand sales and logistics, product catalogues, shipping options, taxes (configured for each Markets), Warehouse and Stock configuration, currency settings, language config and translations. 
After initial onboarding, it is the responsibility of the client to keep their data updated with new Products, Markets, etc. As an Integration Partner try to give clients the job of managing their centra stores and data.

From a Partner support perspective, we love sharing our knowledge. We've created guides on the majority of centra's features, for example they include documentation on swaggers and changelogs, store flows and information on how to test integrations. 
Whether you are building a website, application, ERP integration, pick-and-pack Warehouse integration, or simply playing with our brand new GraphQL API, there are guides to help you succeed. 
And if you can't find what you are looking for, feel free to reach out to us in Slack! 

Are you a new Centra Partner? Welcome! Step one is familiarizing yourself with our Centra Fundementals documentation, these will help you understand the some core concepts. Once you do, you'll find it easier to follow specific docs and guides and most importantly you'll be ready for the next step.
So step 2 then, attend one of our partner webinars. At these sessions we'll show you around the Centra UI and explain the most commonly used APIs and their functions. 

#### Philosophy #2: Instead of solving every problem for you, we prefer to educate you on how to solve it yourself

We will be happy to answer any of your questions, either directly or by pointing to our documentation, and if something is missing - we will add it for sure. If you forgot how something works - just ask, and we will remind you. However, after explaining a concept once or twice, we will expect you to have that knowledge and not ask the same questions every week. We hope you understand - we have hundreds of customers developed with dozens of different Partners, so it would be impossible for us to give you 100% of our time and focus. The more you learn at early stages of working with Centra, the easier it will be to later work on adding more customers and new integrations.

We would also love if you introduced Centra to your new colleagues - you and they will have a common perspective on using Centra, and we believe explanation coming from a person working on the same problem is easier to understand than any documentation.

Having said that, we strive to have the best available docs, which we would measure by how many Partners are able to build working solutions without having to ask us any questions. We've had single integrations like that in the past already, and we're proud of that fact.

#### Philosophy 3: Technical Support and Professional Services are two completely different things

What we do for our Partners:

* **Technical support**  
  If you have technical questions, either about Centra UI or our APIs, let us know! Please make sure to always include as much details as you can - which customer and environment you are working with, what you are trying to achieve, how far have you managed to follow our guides and documentation, and so on.

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

## How we communicate - rules in Slack

#### Ping us when you need help

`@here` pings everyone who's online (has green dot status). Used to get our attention, it's fine if it takes us up to an hour to respond (usually much sooner, though). `@channel` pings everyone in that channel, currently available or not. Only doesn't ping people who have their notifications manually disabled. Use with caution, mostly to report urgent issues, sev 1 and such.

#### Do not use PM for business/technical questions

Ping the whole channel, not individual people. Don't PM (private message), unless it's for sharing API secrets, passwords, or for personal reasons. Any questions are better off asked in the public channel:
* because more people will see it, so you have a better chance to quickly find someone who knows the authoritative answer, and
* because once the question is answered, we all get to share this knowledge and know-how.
Plus, people are likely to be in meetings, so PMing a single person does not guarantee fast response times.

Similarly, the problem of using threads in Slack: They are great to keep an ongoing discussion away from people who are not interested in it, which is nice for when the discussion is ongoing. However, do **not** re-use them afterwards - since they have limited visibility, only you and one other person will see that message. If a day or more has passed, that person might not be online, so you are better off asking for updates in the main channel.

#### Provide full details every time

Please understand that Centra has way over a hundred customers, and we're helping many of them on the same day, everyday. You might be working on a specific customer and/or integration for weeks, so when you report an issue it might be obvious to you who this is for, but it's not for us. It will help a lot if you always reported us with:
- Name of the customer
- Which environment is this about (Prod / QA)
- Which API instance you are using
- What is the issue you are seeing, and what would be the expected result you're not seeing
- Be as specific as you can be! If you're seeing wrong behavior for some product, link to this product. If it's about category translations, tell us which category and which language.

#### Be nice :)

We are here to help, but it's not like all of us know all the answers at all time. Sometimes we'll help immediately, sometimes we will need to consult internally, and sometimes we will tell you the issue is not on our end and you need to contact the PSP or external service support. In any case, once we said we will look into a problem, pinging `@here` every 20 minutes will not help in speeding up the process. We understand you might be anxious, but we can be, too. We are all human, and we work best when we use positive reinforcement, not rudeness and shouting ;)
