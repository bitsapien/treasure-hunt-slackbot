require 'slack-ruby-bot'
require "sqlite3"

DB = SQLite3::Database.new "bot.db"


SlackRubyBot.configure do |config|
  # Bot Aliases
  config.aliases = [':pong:', 'pongbot']
end


module SlackRubyBot
  module Commands
    class Default < Base
      command 'about'
      match(/^(?<bot>[[:alnum:][:punct:]@<>]*)$/u)
      BHAJANS = ['https://www.youtube.com/watch?v=UFWM2tlCKHM', 'https://www.youtube.com/watch?v=J75uzIeMuR0
', 'https://www.youtube.com/watch?v=HAGSP9qvJLw','https://www.youtube.com/watch?v=CsZRTd_xgSc
', 'https://www.youtube.com/watch?v=oBuwBAt5vU8', 'https://www.youtube.com/watch?v=AKX86bM0kfc']
      def self.call(client, data, _match)
        client.say(channel: data.channel, text: BHAJANS.sample, gif: 'selfie')
      end
    end
  end
end


module SlackRubyBot
  module Commands
    class Hi < Base
      help do
        title 'hi'
        desc 'Says hello.'
      end

      def self.call(client, data, _match)
        client.say(channel: data.channel, text: "Tumhara Bhala Ho Bacha <@#{data.user}>! (Blessings kid  <@#{data.user}>!)", gif: 'hi')
      end
    end
  end
end

module SlackRubyBot
  module Commands
    class Unknown < Base
      match(/^(?<bot>\S*)[\s]*(?<expression>.*)$/)

      def self.call(client, data, _match)
        client.say(channel: data.channel, text: "<@#{data.user}>, learn to pray to me! Check `@mahadev help`", gif: 'understand')
      end
    end
  end
end


class GoaBot < SlackRubyBot::Bot
  # 1955515
  CLUE_CODES = {"PACPFW": {level: '1',team: 'praveen'},
                "PACBEM": {level: '1',team: 'arijit'},
                "PACXPX": {level: '1',team: 'sandeep'},
                "DALLASSWDRKE": {level: '2',team: 'praveen'},
                "DALLASARFPXY": {level: '2',team: 'arijit'},
                "DALLASVVSPBP": {level: '2',team: 'sandeep'},
                "FACESFIUOU": {level: '3',team: 'praveen'},
                "FACESVYYPC": {level: '3',team: 'arijit'},
                "FACESKRCNV": {level: '3',team: 'sandeep'},
                "CODELITMUSCLIUGYIYP": {level: '4',team: 'praveen'},
                "CODELITMUSLFMSUOLYC": {level: '4',team: 'arijit'},
                "CODELITMUSRSCSFITOM": {level: '4',team: 'sandeep'},
                "GITLABFQMXXJ": {level: '5',team: 'praveen'},
                "GITLABGBAWBM": {level: '5',team: 'arijit'},
                "GITLABEHAEQH": {level: '5',team: 'sandeep'},
                "ADDATBPU": {level: '6',team: 'praveen'},
                "ADDAZNQW": {level: '6',team: 'arijit'},
                "ADDAAESB": {level: '6',team: 'sandeep'}
                }
  # pacreception
  # pacreception
  # faces
  # codelitmus
  # commit.elitmus.in
  # adda
  LEVELS = {"1": {message: 'Get in to the lobby with this entry ticket - `AGHORA`!', 
                  people: {
                    praveen: '*The Conquered* and *The God of Truth*',
                    arijit: '*The Goddess of Victory* and *The Complete*', 
                    sandeep: '*The Conqueror of All Miseries* and *Great Ruler*'}},
            "2": {message: 'Inverse English to Hindi and vice versa : {photo bindu elitmus bindu saath}', 
                  people: {
                    praveen: '*The Ocean* and *The Image of God*',
                    arijit: '*The Superior* and *The Younger Brother*', 
                    sandeep: '*God of Creation* and *The Destroyer*'}},
            "3": {message: 'Go and code! Make sure you are using a Supreme Judge issued ID', 
                  people: {
                    praveen: '*The Destroyer* and *The First Warrior*',
                    arijit: '*The Point of Attraction* and *The One who came Later*', 
                    sandeep: '*The Husband of Shri* and *A Man*'}},
            "4": {message: 'Ask the developers to revert back the changes they made for the Goa trip!', people: {praveen: '',arijit: '', sandeep: ''}},
            "5": {message: 'Chalo Chai pe charcha karte hai (Let\'s have some discussion over tea.)', people: {praveen: '',arijit: '', sandeep: ''}},
            "6": {message: 'Go to https://goo.gl/LjfFlf', people: {praveen: '',arijit: '', sandeep: ''}}}

  ISSUES = {
    praveen: 'Report the developers to revert the changes they made to Dallas, also add an appropriate label',
    arijit: 'Report the developers to revert the changes they made to Reception, also add an appropriate label',
    sandeep: 'Report the developers to revert the changes they made to eLitmus Faces, also add an appropriate label'

  }

  ADDA_PUZZLE = {'111211312212313213322232333': 'You solved it! Go to https://goo.gl/LjfFlf',
                 '11121131221231321332223233311': 'You are quite close, but your circle\'s open',
                  '11121': 'Seriously? Any more such attempts and I kick you out!'}

    HELP = "
*How to send prayers*

> `@mahadev help`  _Gives you this help section_

> `@mahadev rules`  _The laws of the game_

> `@mahadev reveal <clue-code>`  _Shows you the path_

> `@mahadev check <answer>`  _Checks if you got it correct_
    "

COMMANDMENTS = "Welcome to Khuda Ki Khoj.
*Commandments*
> * Mahadev is the ultimate source of truth. Mahadev misses nothing, so no tricks!
> * For every hurdle you pass, you will receive a prize(gaurd your prize, like your life depends on it) and code to next hurdle.
> * The path to the divine one, will make you transcend through all :elitmus: applications.
> * Your treasure is a 10 digit code.
> * Ask Ganesha, though Ganesha is not obligated to answer all your questions. You can only ask Ganesha on #ganesha-speaks which is a public channel.
> * Learn to write prayers to mahadev using `mahadev help`"

RULES = "
> * Once you crack the clue, you need to ask @mahadev to reveal the path to the next clue using the code you receive at the end of solving the puzzle. eg: `@mahadev reveal XYZ`
> * You get 10 points for every clue you crack after explaining how to Ganesha's messengers.
> * We pray that you never have to giveup, but if you indeed turn out to be a loser, you can tell @ganesha. Say `@ganesha giveup`. This will cost you 10 points and an hour of additional time.
> * The team with the maximum points gets to share a chillam with @mahadev and a ride on @ganesha. In case of a tie, the team who's taken the least amount of time is chosen for the act.
> * You need to crack a minimum of 3 clues to qualify, else @mahadev anf @ganesha run away with the cool T-Shirts."


  command 'reveal', 'show', 'clue' do |client, data, match|
    code = CLUE_CODES[match['expression'].to_sym]
    if code.nil?
      msg = 'eh?'
    else
      if code[:level].eql? '4'
        msg = ISSUES[code[:team].to_sym]
      else
        msg = LEVELS[code[:level].to_sym][:message]
        puts " ------- #{LEVELS[code[:level].to_sym][:people][code[:team].to_sym]}" unless LEVELS[code[:level].to_sym][:people][code[:team].to_sym].empty?
        msg = msg + "\n> Only the chosen can login. \n> Ask #{LEVELS[code[:level].to_sym][:people][code[:team].to_sym]} to login\n Good luck!" unless LEVELS[code[:level].to_sym][:people][code[:team].to_sym].empty?
        insert_into_score_events(code[:level],data.channel.to_s)
      end
    end

    client.say(text: msg, channel: data.channel)
    msg = ''
  end

  command 'check' do |client, data, match|
    answer = match['expression'].to_sym
    if answer.nil?
      msg = 'Silence, huh?'
    else
      msg = ADDA_PUZZLE[answer.to_sym] || 'Naah!'
    end
    client.say(text: msg, channel: data.channel)
    insert_into_events('check',data.text.to_s,data.channel.to_s)
  end

  command 'madad','help' do |client, data, match|

    client.say(text: HELP, channel: data.channel)
  end

  command 'rules' do |client, data, match|

    client.say(text: RULES, channel: data.channel)
  end

  # command 'giveup' do |client, data, match|
  #   client.say(text: RULES, channel: data.channel)
  # end

  command 'ping' do |client, data, match|
    client.say(text: 'pong', channel: data.channel)
  end

  match /^How is the weather in (?<location>\w*)\?$/ do |client, data, match|
    client.say(channel: data.channel, text: "The weather in #{match[:location]} is nice.")
  end

  match /^((H|h)(i|I)) (?<bot>[[:alnum:][:punct:]@<>]*)$/ do |client, data, match|
    client.say(channel: data.channel, text: RULES)
    client.say(channel: data.channel, text: "Your clue - 'Go to lobby/goa' !")
  end

  # Welcome
  match /((H|h)i|(H|h)ello|(h|H)ey) (@*)((m|M)ahadev)/ do |client, data, match|
    client.say(channel: data.channel, text: RULES)
    client.say(channel: data.channel, text: "Your clue - 'Go to lobby/goa' !")
  end
# After getting invitation code
  match /INV1CODE/ do |client, data, match|
    client.say(channel: data.channel, text: "Go to lobby now! Want clue? Ask @indra")
  end

  match /daemon/ do |client, data, match|
    client.say(channel: data.channel, text: "Yea! I'm a daemon")
  end

  match /lobby/ do |client, data, match|
    client.say(channel: data.channel, text: "Go to lobby!")
  end

  match(/^(?<bot>\w*)$/) do |client, data, match|
    client.say(channel: data.channel, text: "ooooo")
  end

  def self.insert_into_score_events(level,team)
    DB.execute "INSERT INTO score_events (from_level, team) VALUES (?,?)", [level, team]
  end

  def self.insert_into_events(what,msg,team)
    DB.execute "INSERT INTO events (what, msg, team) VALUES (?,?,?)", [what,msg,team]
  end


end

GoaBot.run


# PRAVEEN(DALLAS) - That should get the developers going, here is your code - `GITLABFQMXXJ`, and ofcourse https://tasveer.elitmus.com/assets/clues/5.gif
# ARIJIT(RECEPTION) - That should get the developers going, here is your code - `GITLABGBAWBM`, and ofcourse https://tasveer.elitmus.com/assets/clues/5.gif
# SANDEEP(FACES) -  That should get the developers going, here is your code - `GITLABEHAEQH`, and ofcourse https://tasveer.elitmus.com/assets/clues/5.gif