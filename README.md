# CrumbTrail

# Rails Version



# Installation & Usage

## Rails 3

1. Install crumb_trail as a gem via your Gemfile:

```
gem 'crumb_trail'
```

2. Add `has_crumb_trail` to the models you want to track.

```ruby
class Client < ActiveRecord::Base
  has_crumb_trail
end
```

# Testing

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

# License

This project rocks and uses MIT-LICENSE.
