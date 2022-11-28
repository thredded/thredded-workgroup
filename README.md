# Thredded::Workgroup

Extension to [Thredded](http://github.com/thredded/thredded) with features useful to workgroup messaging.
 
The point of Thredded-workgroup is to enable migration of workgroup communication from non-shared email to shared opt-in communications -- everyone can see any of the workgroup communications.
     
originated in https://github.com/thredded/thredded/issues/347

Out the box enables a homepage with a top-level nav menu consisting of:

* Unread: a list of unread topics (ordered by last post) across all messageboards
* Awaiting reply: a list of all topics you follow where yours is the last post
* Following: a list of followed topics (ordered by last post) across all messageboards
* All: a list of all topics (ordered by last post) across all messageboards
* Messageboards: a list of messageboards (as Thredded's normal home page)

![Screenshot of navbar](docs/navbar.png)

It also shows you the followers of the current topic before you post, and allows you to remove unneeded followers. (The logic for this is that (unlike a social forum) you need to broadcast as little as possible (because the aim is to reduce unnecessary noise, because people can find messages they need to). When you are adding to a topic it may become less relevant to existing followers. The person adding the message is able to adjust followers,
like you might adjust the cc-list of conversation).
     
![Screenshot of post form](docs/followers-above-post.png)

## Installation

Add this line to your application's Gemfile (along with thredded if you want to specify a specific fork):

```ruby
gem 'thredded-workgroup'
```

### Jquery 

Since thredded v0.13.0, thredded doesn't need jquery, but thredded-workgroup (still) does.
So you need to include jquery and its ujs file, for example in your Gemfile: 

```ruby
gem "jquery-rails"
```
 
__NB: (see below for using main branch vs a released version)__

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thredded-workgroup

## Usage

add to routes.rb (**instead** of mounting Thredded)

```
  mount Thredded::Workgroup::Engine => "/thredded"
```

You will also need to follow the guidelines for installing Thredded, see https://github
.com/thredded/thredded#installation.

If you use an application layout (see Add thredded styles to your `application.scss` (see https://github.com/thredded/thredded#application-layout) below for customizing the styles), you will need to  include thredded **and** thredded-workgroup:


```scss
@import "thredded";
@import "thredded-workgroup";
```

Include thredded JavaScripts in your `application.js`:

```js
//= require thredded
//= require jquery3  
//= require jquery_ujs  
//= require thredded-workgroup
```

### Configuration

**Reveal on hover?** The last topic shown in the thredded workflow top level pages is by default condensed when too long and revealed by click. You can also have it reveal on hover. This requires adding a data attribute in the layout (e.g. the body, or another high container element), as <div data-thredded-condensable-hover="reveal">. You can preview this behaviour in the demo, by adding `?hover=reveal` to the url.

### View hooks

Thredded::Workgroup augments Thredded with some extra view hooks (see https://github.com/thredded/thredded/#view-hooks) for customization.

To see the extra view hooks provided by Thredded::Workgroup (with their arguments), run:

```bash
grep view_hooks -R --include '*.html.erb' "$(bundle show thredded-workgroup)"
```

## Main vs Released versions

NB: if you are using the main branch rather than a release version
(and as no release has been made yet you must be! :) ) then you may well need
also to use the latest main branch of thredded. So your gem file may need to say:

```ruby
 gem 'thredded', github: 'thredded/thredded', branch: 'main'
 gem 'thredded-workgroup', github: 'red56/thredded-workgroup', branch: 'main'
```

and you need to update both at the same time: `gem update thredded thredded-workgroup`

In the future we will be releasing thredded-workgroup versions soon after thredded versions.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Then create a database and seed it (this is all very similar to Thredded)

```
bundle exec rake db:create db:migrate db:seed
```

Run the server

```
guard
```
(you can alternatively run `dummy-rails s -p 3012` but guard runs livereload for you too, which makes development much more pleasant)

### Updating when thredded changes

For now, there are some copied resources from Thredded. When Thredded changes you need to update these too.
You need to have thredded installed with a github reference (check shared.gemfile)

run `bin/update_from_thredded`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/red56/thredded-workgroup. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

