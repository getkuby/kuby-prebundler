require 'kuby'

module Kuby
  module Prebundler
    class PrebundlerPhase < ::Kuby::Docker::Layer
      attr_accessor :prebundle_config, :bundler_phase, :config

      def initialize(environment, bundler_phase, config)
        @bundler_phase = bundler_phase
        @bundler_phase.executable = 'prebundle'
        @config = config

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

        dockerfile.copy(config.config_path || '.prebundle_config', '.')
        # dockerfile.run('gem', 'install', 'prebundler', '-v', "'< 1'")
        dockerfile.run(["(unset BUNDLE_GEMFILE; unset BUNDLE_WITHOUT; git clone --branch eval_gemfile_set_pwd https://github.com/camertron/prebundler.git && cd prebundler && bundle && bundle exec rake build && gem install pkg/prebundler-0.15.0.gem && cd .. && rm -rf prebundler)"])

        bundler_phase.apply_to(dockerfile)
      end
    end
  end
end
