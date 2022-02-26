The checklist for releasing a new version of Thredded.

Pre-requisites for the releaser:

* Push access to RubyGems.

Release checklist:

- [ ] Update gem version in `version.rb` and `README.md`.
- [ ] Update `CHANGELOG.md`. Ensure that the following link points to the future git tag for this version:
  * [ ] The "See the full list of changes here" link.
- [ ] Wait for the Travis build to come back green.
- [ ] Tag the release and push it to rubygems:

  ```bash
  rake release
  ```
- [ ] Copy the release notes from the changelog to [GitHub Releases](https://github.com/thredded/thredded/releases).
