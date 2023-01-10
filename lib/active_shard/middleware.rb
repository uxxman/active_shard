module ActiveShard
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      request = ActionDispatch::Request.new(env)
      api_key = request.get_header('HTTP_X_API_KEY') || request.params['x-api-key']

      if skip_middleware?(request.path)
        @app.call(request.env)
      elsif (shard = find_shard(api_key))
        ActiveShard.set(shard) { @app.call(request.env) }
      else
        [406, {}, {}]
      end
    end

    private

    def skip_middleware?(path)
      path == '/cashbacks/go_shopping' || path.starts_with?('/rails/active_storage')
    end

    def find_shard(api_key)
      case api_key
      when nil, ''
        nil
      when Rails.application.credentials.api_key!
        :default
      else
        Bank.find_by(api_key:)&.shard_name
      end
    end
  end
end
