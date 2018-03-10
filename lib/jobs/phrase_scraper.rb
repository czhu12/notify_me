class Job::PhraseScraper
  def initalize(threads=2)
    @threads = 2
  end

  def scrape(requests)
    requests.each do |request|
      data = request.call()
      sleep(request.rate_limit)
    end
  end
end
