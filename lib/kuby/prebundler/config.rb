require 'kube-dsl'

module Kuby
  module Prebundler
    class Config
      extend ::KubeDSL::ValueFields

      value_fields :config_path
    end
  end
end
