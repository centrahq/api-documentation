# Centra public API documentation

This project contains the source of Centra's public API documentation. The documentation is located at https://docs.centra.com. 

### Thanks

Thanks to [Mollie](https://github.com/mollie) for licensing their API Documentation under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/?). We've adapted their theme and made some changes that worked for us. Thank you very much! 

## Contribute

- [Issue Tracker](https://github.com/centrahq/api-documentation/issues)
- [Source Code](https://github.com/centrahq/api-documentation)

We take pull requests on our documentation as well, if you think that something can be improved please open a PR.

The documentation is formatted using markdown. All
documentation should be written in US English.

### Prerequisites

- Python > 2.7.9 
- [pip](https://pypi.org/project/pip/), Python's package manager. [Installation instructions](https://pip.pypa.io/en/stable/installing/). 
- Node > 9.x

### Running locally

Create a fork, or clone this repository if you have write access:

```shell
git clone git@github.com:centrahq/api-documentation.git
```

Then visit the downloaded repository and install dependencies:

```shell
cd api-documentation
make install
```

### Generate HTML and supporting files

Finally, build the documentation, its CSS and JS files by running:

```shell
make html
```

You can now preview the generated documentation by opening `build/html/index.html`:

```shell
open build/html/index.html
```

### Making changes to copy 

After running `make html` at least once, you can use `make html-only` to quickly update the HTML files if you changed 
some copy. This way, you can have a quick [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop).  

```shell
$ make html-only
Running Sphinx v1.8.3
...
updating environment: 0 added, 2 changed, 0 removed
...
build succeeded.

The HTML pages are in build/html.
$ open build/html/index.html
```

Sphinx will only update files for which the source files have changed. 

### Styling docs

You can make changes to the styling by starting a web server locally:

```shell
make start
```

Visit `http://localhost:8000` to preview your changes. CSS & JS changes will appear without the need to refresh your 
browser.

### Releasing new versions of the documentation

Deployment is handled using continuous deployment.

Successful builds on the `master` branch will be automatically deployed. 

### Redirects

Redirects are handled using a Lambda@Edge function installed on the North Carolina AWS region. This Lambda@Edge contains the code from: [origin-response.js](https://github.com/centrahq/api-documentation/blob/master/.lambda-functions/origin-response.js).

Update the function and deploy it again at Lambda@Edge to add more redirects.

## Support

If you are having issues, please let us know. We accept pull requests on our public documentation.

You can get support via support@centra.com.

## Working at Centra

We have a career page listing our current positions: [Centra Careers](https://careers.centra.com).

## License

The documentation is licensed under the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/?) license.
