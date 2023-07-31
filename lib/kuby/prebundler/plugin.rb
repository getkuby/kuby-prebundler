require 'kuby'

module Kuby
  module Prebundler
    class Plugin < ::Kuby::Plugin
      attr_reader :config

      def configure(&block)
        config.instance_eval(&block) if block
      end

      def after_configuration
        bundler_phase = docker.bundler_phase
        docker.delete(:bundler_phase)
        docker.insert(:bundler_phase, PrebundlerPhase.new(environment, bundler_phase, config), after: :package_phase)
      end

      private

      def after_initialize
        @config = Config.new
      end

      def docker
        environment.docker
      end
    end
  end
end