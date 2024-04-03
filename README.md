# Centra public API documentation

This project contains the source of Centra's public API documentation. The documentation is located at https://docs.centra.com.

## Contribute

- [Issue Tracker](https://github.com/centrahq/api-documentation/issues)
- [Source Code](https://github.com/centrahq/api-documentation)

We take pull requests on our documentation as well, if you think that something can be improved please open a PR.

The documentation is formatted using markdown. All
documentation should be written in US English.

### Running locally

See [readme](docs/run-locally.md).

### Releasing new versions of the documentation

Deployment is handled using continuous deployment.

Successful builds on the `production` branch will be automatically deployed.

## Working at Centra

We have a career page listing our current positions: [Centra Careers](https://careers.centra.com).

## License

The documentation is licensed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/?) license.

## Storyblok migarition

As part of migration to Storyblok we have to make redirects to [centra.dev](https://centra.dev). Those redirects you can find in `/config/site.yaml` file.
External redirections in Grav CMS are working only when page you are trying to visit hasn't any content. This is why we added _moved suffix in `.md` files, we don't need to delete files, but Grav CMS see that we haven't content in pages we want to redirect to external website. For more informations check [this PR](https://github.com/centrahq/api-documentation/pull/666)
