require 'slack-ruby-bot'
require 'wit'
require 'json'
ENV['SLACK_API_TOKEN'] = '<token>'

SlackRubyBot.configure do |config|
  # Bot Aliases
  config.aliases = [':pong:', 'pongbot']
end




class GoaBot < SlackRubyBot::Bot

  command 'ping' do |client, data, match|
    client.say(text: 'pong', channel: data.channel)
  end

  match /(.*)/ do |client, data, match|
    wit = Wit.new(access_token: '<token>')
    rsp = wit.message(data.text)
    weather_info = get_weather_info(rsp)
    puts "Wit response #{weather_info.join(' and ')}"
    client.say(channel: data.channel, text: weather_info.join(' and '))
  end

  def self.get_weather_info(wit_response)
    weather_data = []
    is_weather = wit_response["entities"]["location"]
    if is_weather
      locations = is_weather.map do |l| l["value"] end
      locations.each do |loc|
        response = Net::HTTP.get_response(URI("http://samples.openweathermap.org/data/2.5/weather?q=#{loc}&appid=<token>"))
        weather = JSON.parse response.body
        puts "weather data: #{weather}"
        weather_data << "#{loc} will see #{weather["weather"][0]["description"]}" 
      end
    end
    weather_data
  end


end

GoaBot.run
