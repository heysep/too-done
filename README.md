# TooDone

TooDone is a CLI based to-do-list app I built at The Iron Yard Academy. 

It uses Thor gem as the main mechanism for interacting through the CLI.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'too_done'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install too_done

## Usage

You can run the app with `bundle exec ruby lib/too_dead.rb SUBCOMMAND ARGS` but since that is so verbose, you might want to add a shell alias to make your life easier.

Shell aliases are just shorthand for longer commands. Writing

`alias tasks="bundle exec ruby lib/too_done.rb"`

would allow you to run the app with tasks SUBCOMMAND ARGS which is much more convenient.

### Available Subcommands

```
  too_done.rb add 'TASK'             # Add a TASK to a todo list.
  too_done.rb delete [LIST OR USER]  # Delete a todo list or a user.
  too_done.rb done                   # Mark a task as completed.
  too_done.rb edit                   # Edit a task from a todo list.
  too_done.rb help [COMMAND]         # Describe available commands or one specific command
  too_done.rb show                   # Show the tasks on a todo list in reverse order.
  too_done.rb switch USER            # Switch session to manage USER's todo lists.
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/too_done. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

