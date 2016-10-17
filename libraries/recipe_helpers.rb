module SimpleSlackHandler
  # Helper functions that need to be injected into the handler module rollup
  module Helpers
    def collect_args(resource_args = [])
      if resource_args.is_a? Array
        resource_args
      else
        [resource_args]
      end
    end
  end
end
