# CrumbTrail

## Rails Version

Tested for Rails 3.2.12 and is dependent on ActiveRecord `>=3.2`.

## Installation & Usage

### Rails 3

* Install crumb_trail as a gem via your Gemfile:

```
gem 'crumb_trail'
```

* Generate a migration which will add a `logs` table to your database.

```
bundle exec rails generate crumb_trail:install
```

* Run the migrations.

```
bundle exec rake db:migrate
```

* Add `has_crumb_trail` to the models you want to track.

```ruby
class Client < ActiveRecord::Base
  has_crumb_trail
end
```

## Testing

First perform `bundle exec rake db:migrate && rake db:test:clone`.  Simply run the tests with `rake` in `crumb_trail/`.

```bash
CrumbTrail
  should be a Module

ActiveRecord Models that declare `has_crumb_trail`
  should have_many logs
  should log object state for changes made
  should log object state after it is destroyed
  should log changes when saving a new object
    logs current object

Finished in 0.07734 seconds
5 examples, 0 failures

Randomized with seed 48086
```

## Contribute

This gem is very lightweight as it stands as much hasn't been added to
the `CrumbTrail` 'interface' and simply saves AR model changes to the
`logs` table.

## License

This project rocks and uses MIT-LICENSE.
