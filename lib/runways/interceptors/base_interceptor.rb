# frozen_string_literal: true

module Runways
  class BaseInterceptor < ::GRPC::ServerInterceptor
    def all_request_responses(request: nil, call: nil, method: nil)
      yield
    end

    def request_response(request: nil, call: nil, method: nil, &block)
      all_request_responses(request: request, call: call, method: method, &block)
    end

    def client_streamer(request: nil, call: nil, method: nil, &block)
      all_request_responses(request: request, call: call, method: method, &block)
    end

    def server_streamer(request: nil, call: nil, method: nil, &block)
      all_request_responses(request: request, call: call, method: method, &block)
    end

    def bidi_streamer(request: nil, call: nil, method: nil, &block)
      all_request_responses(request: request, call: call, method: method, &block)
    end
  end
end
