require "singleton"

require_relative "assets.rb"

module Docks
  module Themes
    class Base
      include Singleton

      attr_reader :assets

      def initialize
        @assets = Assets.new(root: File.expand_path("../../../assets", __FILE__))
      end

      def styles
        assets.styles
      end

      def scripts
        assets.scripts
      end

      def setup(builder)
        setup_styles(builder, builder.options.style_language)
        setup_scripts(builder, builder.options.script_language)
        setup_templates(builder, builder.options.template_language)
      end

      def configure(_config)
      end

      private

      def setup_styles(builder, language)
        builder.add_assets(:styles, assets.files_for("styles/#{language}/**/*"))
      end

      def setup_scripts(builder, language)
        builder.add_assets(:scripts, assets.files_for("scripts/#{language}/**/*"))
      end

      def setup_templates(builder, language)
        builder.add_assets(:templates, assets.files_for("templates/#{language}/**/*"))
      end
    end
  end
end
