require 'twitter'

class Tweet < Post
  @@CLIENT = Twitter::REST::Client.new do |config|
    config.consumer_key = 'h29RY0n5bGKZLWUuUpDMh6HL5'
    config.consumer_secret = 'LrO1xP8ymZnRxHkDMB18JFjgsW38K5g9SVkBFzBJrFsfnPxBkT'
    config.access_token = '751709819007070208-HK1wKOwjEhif8kx3qtPs65i2PPgietx'
    config.access_token_secret = 'Xp76FzmQjegVTJKCJOgwFQ18AbZP0Q4AmE2VWM8ZI8FWv'
  end
  def read_from_console
    puts "Новий твит (140 символов!):"
    @text = STDIN.gets.chomp[0..140]
    puts "Отправляем ваш твит: #{@text.encode('utf-8')}"
    @@CLIENT.update(@text.encode('utf-8'))
    puts "Твит отправлен"
  end

  def to_strings
    time_string = "Создано: #{@created_at.strftime("%Y.%m.%d, %H:%M:%S")}  \n\r \n\r"
    return @text.unshift(time_string)
  end

 def to_db_hash
   return super.merge( {
    'text' => @text
                      } )
 end

  def load_data(data_hash)
    super(data_hash)
    @text = data_hash['text'].split('\n\r')
  end
end