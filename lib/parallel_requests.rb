class ParallelRequests
  def self.fetch_parallel(urls, threads=10)
    queue = urls.inject(Queue.new, :push)
    semaphore = Mutex.new
    results = {}
    threads = Array.new(threads) do
      Thread.new do
        until queue.empty?
          # This will remove the first object from @queue
          url = queue.shift
          request = HTTParty.get(url, timeout: 10)
          semaphore.synchronize do
            results[url] = request
            if results.length % 10 == 0
              Rails.logger.debug("Downloaded #{results.size} / #{urls.size}")
            end
          end
        end
      end
    end

    threads.each(&:join)
    results
  end
end
