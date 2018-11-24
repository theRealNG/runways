module Runways
  class BenchmarkInterceptor < BaseInterceptor
    def all_request_responses(request: nil, call: nil, method: nil)
      realtime = Benchmark.realtime do
        yield
      end

      puts "Completed in #{realtime} secs"
    end
  end
end
