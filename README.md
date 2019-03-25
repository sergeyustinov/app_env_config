# AppEnvConfig

Provide ability to load config from yml files and use it at enviroments configuration files and in whole app

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'app_env_config'
```

And then execute:

    $ bundle

    $ rails g app_env_config:install

## Usage

gem added APP_CONFIG constant that you can use everywhere with symobol or string keys
for ex.

APP_CONFIG.dig(:api, :token)
APP_CONFIG['title']

or you can use

AppEnvConfig.get 'file_name', use_env_or_not

AppEnvConfig.get 'sidekiq', false


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/app_env_config. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

