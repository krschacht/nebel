require "httparty"

class YahooGroup

  include HTTParty

  base_uri "https://groups.yahoo.com/api/v1/groups/K5science"

  def initialize(cookies)
    @cookies = cookies
  end

  def message_ids(query = {})
    query.reverse_merge!({
      start: 2740,
      count: 3000, # There are ~2,700 total messages
      sortOrder: "asc",
      direction: -1,
      chrome: "raw",
      tz: "America/Chicago",
      ts: 1396559671823
    })

    response = self.class.get("/messages", headers: { "Cookie" => @cookies }, query: query)
    response["ygData"]["messages"].map { |m| m["messageId"] }
  end

  def messages
    message_ids[0...3].map do |message_id|
      message = message(message_id)
      yield(message) if block_given?
      message
    end
  end

  def message(id)
    self.class.get("/messages/#{id}", headers: { "Cookie" => @cookies })["ygData"]
  end

end
