name: CD

on:
  push:
    branches:
      - main

  create_github_release:
    runs-on: ubuntu-24.04
    name: Create GitHub Release PR
    steps:
      - uses: google-github-actions/release-please-action@v3
        with:
          changelog-path: CHANGELOG.md
          default-branch: main
          include-v-in-tag: true
          package-name: semantic_boolean
          release-type: ruby
          version-file: lib/semantic_boolean/version.rb
