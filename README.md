# Thredded::PersonalizedNavigation

PersonalizedNavigation for [Thredded](http://github.com/thredded/thredded)

originated in https://github.com/thredded/thredded/issues/347

Out the box enables a homepage with a top-level nav menu consisting of:

* Unread: a list of unread topics (ordered by last post) across all messageboards
* Following: a list of followed topics (ordered by last post) across all messageboards
* ~~Posted: a list of topics you've posted to (ordered by your last post) across all messageboards~~ (not yet implemented)
* All topics: a list of all topics (ordered by last post) across all messageboards
* All messageboards: a list of messageboards (as present)

It adds a navbar like this:

<img width="898" alt="screenshot" src="https://cloud.githubusercontent.com/assets/18395/17519867/a07ca5e8-5e45-11e6-86e1-953fdc399168.png">


## Installation

Add this line to your application's Gemfile (along with thredded if you want to specify a specific fork):

```ruby
gem 'thredded-personalized-navigation'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thredded-personalized-navigation

## Usage

add to routes.rb (**instead** of mounting Thredded)

```
  mount Thredded::PersonalizedNavigation::Engine => "/thredded"
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Then create a database and seed it (this is all very similar to Thredded)

```
bundle exec rake db:create db:migrate db:seed
```

Run the server

```
dummy-rails s -p 3012
```

### Updating when thredded changes

For now, there are some copied resources from Thredded. When Thredded changes you need to update these too.
You need to have thredded checked out next to this repo.

run `script/update_from_thredded`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/thredded-personalized-navigation. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

