require 'rails/generators/base'

module AppEnvConfig
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __dir__)

      desc 'Copy conifg file to application and set APP_CONFIG constant for next use'

      def copy_yml
        copy_file 'app_config.yml', 'config/app_config.yml'
      end

      def create_constant
        write_to_file(
          file: 'config/environment.rb',
          line: 'Rails.application.initialize!',
          content_before: "APP_CONFIG = AppEnvConfig.get('app_config')",
          shift: "\n" * 2
        )
      end

      protected

      def file_contain_content?(options = {})
        file_content = File.read(options[:file])

        (options[:content_before].blank? || file_content.include?(options[:content_before])) &&
          (options[:content_after].blank? || file_content.include?(options[:content_after]))
      end

      def write_to_file(options = {})
        return if file_contain_content?(options)

        gsub_file options[:file], /(#{Regexp.escape(options[:line])})/mi do |match|
          [
            options[:content_before].presence,
            match,
            options[:content_after].presence
          ].compact.join(options.fetch(:shift, "\n"))
        end
      end
    end
  end
end
