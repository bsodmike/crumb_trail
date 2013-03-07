# CrumbTrail

## Rails Version

Tested for Rails 3.2.12 and is dependent on ActiveRecord `>=3.2`.

## API Summary
When you declare `has_crumb_trail` in your model, you get these methods:

```ruby
class Book < ActiveRecord::Base
  has_crumb_trail
end

# Returns true if the book has any logged changes
book.has_logs?

# Returns the book object in its previous state, i.e.
#
# book #=>
#   #<Book id: 64, title: "The Gutenberg Revolution", created_at: "2013-03-07 17:44:52", updated_at: "2013-03-07 17:44:52">
#
# book.previous_state #=>
#   #<Book id: 64, title: "Book", created_at: "2013-03-07 17:48:34", updated_at: "2013-03-07 17:48:34">
book.previous_state
```
## Features

* Logs every create, update and destroy for AR models that declare
`has_crumb_trail`
* Object state is [serialized to YAML as
default](http://api.rubyonrails.org/classes/ActiveRecord/AttributeMethods/Serialization/ClassMethods.html#method-i-serialize)

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
  should have the association of logs
  when changing object state
    when destroying an object
      should log object state after it is destroyed
    when saving a new object
      should log state of the current object
    when updating an object attribute
      should log object state for changes made
  CrumbTrail usage interface
    should respond to `has_logs?`
    without any logs
      should response to `previous_state` and return nil
      should respond to `previous_state` and return the previous object state

Finished in 0.10184 seconds
8 examples, 0 failures

Randomized with seed 14218
```

## Contribute

This gem is very lightweight as it stands as much hasn't been added to
the `CrumbTrail` 'interface' and simply saves AR model changes to the
`logs` table.

## License

This project rocks and uses MIT-LICENSE.
