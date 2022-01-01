require 'kuby'

module Kuby
  module Prebundler
    class PrebundlerPhase < ::Kuby::Docker::Layer
      attr_accessor :prebundle_config, :bundler_phase

      def initialize(environment, bundler_phase)
        @bundler_phase = bundler_phase
        @bundler_phase.executable = 'prebundler'

        super(environment)
      end

      def method_missing(method_name, *args, **kwargs, &block)
        bundler_phase.send(method_name, *args, **kwargs, &block)
      end

      def respond_to_missing?(method_name)
        bundler_phase.respond_to?(method_name)
      end

      def apply_to(dockerfile)
        dockerfile.arg('PREBUNDLER_ACCESS_KEY_ID')
        dockerfile.arg('PREBUNDLER_SECRET_ACCESS_KEY')

        dockerfile.copy(prebundle_config || '.prebundle_config', '.')
        # dockerfile.run('gem', 'install', 'prebundler', '-v', "'< 1'")
        dockerfile.run('gem', 'install', 'specific_install')
        dockerfile.run('gem', 'specific_install', '-l', 'https://github.com/camertron/prebundler.git', '-b', 'eval_gemfile')
        dockerfile.env('GLI_DEBUG', 'true')

        bundler_phase.apply_to(dockerfile)
      end
    end
  end
end