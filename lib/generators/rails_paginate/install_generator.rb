module RailsPaginate
  module Generators # :nodoc:
    # Install Generator
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Install the rails_paginate plugin"
      def install
        copy_file "config/initializers/paginate.rb", "config/initializers/paginate.rb"
        copy_file "config/locales/en.yml", "config/locales/paginate.en.yml"
        copy_file "config/locales/de.yml", "config/locales/paginate.de.yml"
      end
    end
  end
end