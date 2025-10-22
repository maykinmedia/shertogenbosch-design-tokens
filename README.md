# 's-Hertogenbosch Design Tokens and theme

[NL Design System](https://www.nldesignsystem.nl/) design token values for "the 's-Hertogenbosch theme".

The shertogenbosch theme is used in environments that support styling with NL Design System
(community) components. It serves as the source of truth for any theme/design choices.

## How it works

Specify the design tokens in JSON files, which are picked up and merged using the
[style-dictionary](https://www.npmjs.com/package/style-dictionary) library. The resulting packages
include various build targets, such as ES6 modules, CSS variables files, SASS vars... to be consumed
in downstream projects.

The draft [Design Token Format](https://design-tokens.github.io/community-group/format/) drives the
structure of these design tokens.

## Usage

**Using tokens**

If you are only _consuming_ the design tokens, the easiest integration path is adding the NPM
package as dependency to your project:

```bash
npm install --save-dev @maykinmedia/shertogenbosch-design-tokens
```

Then, import the desired build target artifact and run your usual build chain.

Or, deploy the Docker image somewhere publicly and refer to the hosted assets.

## Developing

The source of truth is defined in the `src` directory, this includes the tokens themselves and any
CSS overrides that may be necessary. The `src` acts as input for the build process, which emits
compilation targets into the `dist` folder.

Next, the `assets` directory contains ready-to-use assets such as images, favicon and fonts.

The final step of the build process combines `dist` artifacts and makes everything ready for
consumption in the `assets` directory. That folder is ultimately included in the container image.

When building the docker image, you can provide the build arg `VERSION`, which determines the final
URL where the assets are available. E.g.:

```bash
docker build --build-arg=VERSION=0.1.0 --tag maykinmedia/shertogenbosch-design-tokens:0.1.0 .
```

Will lead to the following URL structure: `https://theme.example.com/0.1.0/assets/theme.css`.

## Release flow

We don't let `npm` apply the git tags when releasing a new version, instead follow this process:

```bash
npm version minor  # or major or patch, depending on the nature of the changes
git commit -am ":bookmark: Bump to version <newVersion>"
git tag "<newVersion>"
git push origin main --tags
```

If you have PGP keys set up, you can use them for the git tag operation.

The CI pipeline will then publish the new version to npmjs.
