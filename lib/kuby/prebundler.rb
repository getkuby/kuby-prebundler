require 'kube-dsl'
require 'kuby/prebundler/plugin'
require 'kuby/prebundler/prebundler_phase'

Kuby.register_plugin(:prebundler, ::Kuby::Prebundler::Plugin)
