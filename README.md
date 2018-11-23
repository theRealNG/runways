# Runways
Runways is a gRPC based ruby application. It will setup the basic project structure with active_record ORM.

## Installation

Install Runways at the command prompt:

  $ gem install runways

Create a new runways application:

  $ runways new hello

Run the following rake task to update protobuf files:

```ruby
	rake protobuf_files:update
```

Run the following command to start the server, the server will reload if any file is changed

```ruby
  APP_ENV=development rerun -- ruby SERVER_FILE.rb
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/theRealNG/runways. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Runways project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/runways/blob/master/CODE_OF_CONDUCT.md).

## TODO
- [x] Setup rake tasks for active record migrations
- [x] Create a sample RPC
- [ ] Setup logging
- [ ] Use ActiveRecord generators to handle ActiveRecord related tasks ( ex: generate migration, migrate, rollback )
- [ ] Create runways controller
- [x] Refactor generator code
- [ ] Refactor code to generate protobuf files when the application is initialized
- [x] Handle loading the server without DbConfig setup
- [ ] Handle DbConfig in the ActiveRecord style
- [ ] Modify rake task to replace `require` with `require_relative` in the services pb file
- [x] Handle file loading like how rails handles it
- [ ] Accept package name from command line
- [ ] Don't hard code port
- [ ] Figure out how to handle nil values in the GRPC request
- [ ] Add callbacks for RPC's
- [ ] Test for streaming rpcs
- [ ] How to generalize interceptors for simple & streaming rpcs
