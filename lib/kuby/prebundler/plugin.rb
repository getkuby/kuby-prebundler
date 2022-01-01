require 'kuby'

module Kuby
  module Prebundler
    class Plugin < ::Kuby::Plugin
      def after_configuration
        # require 'pry-byebug'
        # binding.pry
        bundler_phase = docker.bundler_phase
        docker.delete(:bundler_phase)
        docker.insert(:bundler_phase, PrebundlerPhase.new(environment, bundler_phase), after: :package_phase)
      end

      private

      def docker
        environment.docker
      end
    end
  end
end