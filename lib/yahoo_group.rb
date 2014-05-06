require "httparty"

class YahooGroup

  include HTTParty

  base_uri "https://groups.yahoo.com/api/v1/groups"

  def initialize(id, cookies)
    @id, @cookies = id, cookies
  end

  def message_ids(query = {})
    query.reverse_merge!({
      start: 0,
      count: 9_999_999,
      sortOrder: "asc",
      direction: 1
    })

    response = self.class.get("/#{@id}/messages", headers: { "Cookie" => @cookies }, query: query)
    response["ygData"]["messages"].map { |m| m["messageId"] }
  end

  def messages(from, to)
    ids = message_ids
    to  = message_ids.size < to ? message_ids.size : to

    ids[from...to].map do |id|
      message(id).tap { |m| yield(m) if block_given? }
    end
  end

  def message(id)
    tries = 3
    begin
      self.class.get("/#{@id}/messages/#{id}", headers: { "Cookie" => @cookies })["ygData"]
    rescue => error
      tries -= 1
      retry if tries > 0
      raise error
    end
  end

end
