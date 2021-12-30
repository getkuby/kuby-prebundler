require 'kuby'

module Kuby
  module Prebundler
    class PrebundlerPhase < ::Kuby::Docker::BundlerPhase
      attr_accessor :prebundle_config

      def apply_to(dockerfile)
        dockerfile.arg('PREBUNDLER_ACCESS_KEY_ID')
        dockerfile.arg('PREBUNDLER_SECRET_ACCESS_KEY')

        dockerfile.copy(prebundle_config || '.prebundle_config', '.')
        dockerfile.run('gem', 'install', 'prebundler', '-v', "'< 1'")

        super

        dockerfile.commands.each do |cmd|
          next unless cmd.is_a?(Kuby::Docker::Dockerfile::Run)

          if cmd.args[0..1] == ['bundle', 'install']
            cmd.args[0] = 'prebundle'
          end
        end
      end
    end
  end
end