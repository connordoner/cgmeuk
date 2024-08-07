# ConnorGurney.me.uk

This repository holds the content and assets, infrastructure-as-code definitions and documentation for my personal website.

## Getting started

If you’d simply like to view the content of my personal website, navigate to the [content/](./content/) directory. All of the pages within that directory are hand-written HTML, just as Tim Berners-Lee intended (I presume, anyway, as I haven’t asked him).

You’re also more than welcome to [contribute](#contributing) if you’d like, but please remember that this is _my_ personal website, and that I might therefore suggest your contributions belong elsewhere, such as your own personal website (there can never be too many!).

## Deployment

Changes are deployed automatically when they’re pushed to the `main` branch using a [GitHub Actions workflow](./.github/workflows/deploy.yml). They can then be accessed at [connorgurney.me.uk](https://www.connorgurney.me.uk).

As long as you’re [logged in to Terraform Cloud](https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-login), you can also deploy manually by running the following command:

```shell
terraform -chdir=./infra apply
```

## Contributing

I intend to work mostly by myself on this project (it is _my_ personal website, after all!). However, I’ll be using some technologies that I’ve only got limited experience with, so I do welcome suggestions on how to improve.

If you’d like to contribute code, please open a pull request against this repository. It would be helpful if you could explain what you’ve done and why so that I can understand the underlying reasons for your suggestion.

Otherwise, you can either [create an issue](https://github.com/connorgurney/cgmeuk/issues) with details of your suggestion or [email me](mailto:webmaster@connorgurney.me.uk). In any event, please write a descriptive title or subject line, as this helps me to triage suggestions.

All that said, if you’re reporting a security vulnerability, please email me at [security@connorgurney.me.uk](mailto:security@connorgurney.me.uk) instead. This avoids the vulnerability being in the open whilst I work to fix it.

## License

The source code and assets in this repository are licensed under the [GNU General Public License v3.0](./LICENSE.md).

I retain the copyright to all of the content on my personal website (that is, everything in the `content/` directory) at the moment, but I will be reviewing my stance to this as part of this project.
