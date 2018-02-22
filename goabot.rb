require 'slack-ruby-bot'
require 'wit'
require 'json'
ENV['SLACK_API_TOKEN'] = 'xoxb-318259888832-F3f8p1XTPKRrb6HAeUeLPjGP'

SlackRubyBot.configure do |config|
  # Bot Aliases
  config.aliases = [':pong:', 'pongbot']
end




class GoaBot < SlackRubyBot::Bot

  command 'ping' do |client, data, match|
    client.say(text: 'pong', channel: data.channel)
  end

  match /(.*)/ do |client, data, match|
    wit = Wit.new(access_token: 'HW6DPGANRVSEW35PZPDTZ2AYWTE5BJDU')
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
        response = Net::HTTP.get_response(URI("http://samples.openweathermap.org/data/2.5/weather?q=#{loc}&appid=b6907d289e10d714a6e88b30761fae22"))
        weather = JSON.parse response.body
        puts "weather data: #{weather}"
        weather_data << "#{loc} will see #{weather["weather"][0]["description"]}" 
      end
    end
    weather_data
  end


end

GoaBot.run


# PRAVEEN(DALLAS) - That should get the developers going, here is your code - `GITLABFQMXXJ`, and ofcourse https://tasveer.elitmus.com/assets/clues/5.gif
# ARIJIT(RECEPTION) - That should get the developers going, here is your code - `GITLABGBAWBM`, and ofcourse https://tasveer.elitmus.com/assets/clues/5.gif
# SANDEEP(FACES) -  That should get the developers going, here is your code - `GITLABEHAEQH`, and ofcourse https://tasveer.elitmus.com/assets/clues/5.gif
