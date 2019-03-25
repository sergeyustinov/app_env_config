require 'yaml'

module AppEnvConfig
  @@cache = {}

  class << self
    def root_path
      # ENV['BUNDLE_GEMFILE'].gsub(/\/Gemfile\z/, '')
      Rails.root || Pathname.new(ENV['RAILS_ROOT'] || Dir.pwd)
    end

    def get(config_name, with_env = true)
      @@cache[config_name] ||= {}
      @@cache[config_name][with_env] ||= uncached(config_name, with_env)
    end

    def uncached(config_name, with_env = true)
      hash = YAML.load(ERB.new(File.read([root_path, 'config', "#{config_name}.yml"].join('/'))).result)

      res = hash && hash['default'] || {}

      hash = res[Rails.env] if with_env

      (hash ? res.deep_merge(hash) : res).with_indifferent_access
    end
  end
end
