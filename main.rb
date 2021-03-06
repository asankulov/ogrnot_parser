require 'telegram/bot'
require_relative 'ogrnot_parser.rb'


TOKEN = 'TOKEN'
smsId2 = smsId = 0
login = pass = ''

Telegram::Bot::Client.run(TOKEN) do |bot|

  bot.listen do |message|

    case message.text
      when '/start', '/start start'
        bot.api.send_message(chat_id: message.chat.id, text: "Привет, #{message.from.first_name}")

      when '/ogr'
        bot.api.send_message(chat_id: message.chat.id, text: 'Отправьте идентификационный номер')
        smsId = message.message_id

      when '/stop'
        bot.api.send_message(chat_id: message.chat.id, text: "Пока, #{message.from.first_name}")

      else
        if (message.message_id.to_i - smsId.to_i) == 2
          smsId2 = message.message_id
          login = message.text
          bot.api.send_message(chat_id: message.chat.id, text: "пароль")
        end
        if (message.message_id.to_i - smsId2.to_i) == 2
          pass = message.text
          org = OgrnotHtml.new
          if org.save_html(login, pass)=="Fuck! Undefined method!"
            bot.api.send_message(chat_id: message.chat.id, text: 'логин или пароль не верны, введите заново! /ogr')
            next
          end

          res = org.parser
          not_message = ''
          res.each_pair do |key, value|
            not_message += key + "\n" + value.join("\n") + "\n\n"
          end
          bot.api.send_message(chat_id: message.chat.id, text: "Дорогой(ая), #{message.from.first_name} твои баллы: \n\n#{not_message}")
        end
    end
  end
end
