module HerokuBlogpost
  class Creator
    URL = Rails.application.secrets.heroku_url
    KEY = '?key=' + Rails.application.secrets.heroku_key

    def initialize(body)
      @connection = Faraday.new(url: URL)
      @body = body
    end

    def call
      response = @connection.post('api/posts' + KEY) do |req|
        req.body = @body
      end
      JSON.parse(response.body)['id']
    end
  end
end
