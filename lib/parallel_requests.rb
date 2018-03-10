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
          request = HTTParty.get(url)
          semaphore.synchronize do
            results[url] = request
          end
        end
      end
    end

    threads.each(&:join)
    results
  end
end
