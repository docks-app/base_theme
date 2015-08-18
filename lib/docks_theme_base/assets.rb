require "pathname"
require "docks/errors"

module Docks
  module Themes
    class Assets
      attr_reader :root, :source_root

      def initialize(options)
        @root = Pathname.new(options.fetch(:root))

        source = options.fetch(:source_root, false)
        @source_root = source && Pathname.new(source)
      end

      def path_for(*asset_path)
        asset_path = File.join(*asset_path)
        path = root + asset_path
        source_path = source_root && source_root + asset_path

        if path.exist?
          path
        elsif source_path && source_path.exist?
          source_path
        else
          fail Docks::NoAssetError,
               "No asset matching '#{asset_path}' was found in the asset folders."
        end
      end

      def files_for(*asset_path)
        Dir[root + File.join(asset_path)]
      end

      def scripts
        files_for("scripts/*.js")
      end

      def styles
        files_for("styles/*.css")
      end
    end
  end
end
