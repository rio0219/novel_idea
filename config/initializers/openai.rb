OpenAI.configure do |config|
  api_key = ENV["OPENAI_API_KEY"]
  raise "OPENAI_API_KEY is missing" unless api_key
  config.access_token = api_key
end
