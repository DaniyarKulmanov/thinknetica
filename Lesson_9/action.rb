require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
# work with input data
class Action
  attr_reader :trains

  def initialize
    @trains = []
  end

  def run
    loop do
      type = input_data  'Введите тип поезда:', '1 - Passenger',
                         '2 - Cargo', '0 - Выход'
      break if type == '0'
      name = input_data 'Введите имя:'
      break if name == '0'
      number = input_data 'Введите номер поезда:'
      break if number == '0'
      create_train name, type, number
    end
  end

  def input_data(text1, text2 = nil, text3 = nil, text4 = nil)
    puts_txt text1
    puts_txt text2
    puts_txt text3
    puts_txt text4
    input = gets.chomp
    input
  end

  def create_train(name, type, number)
    if type == '1'
      @trains << PassengerTrain.new(name, number)
      result  @trains[-1]
    elsif type == '2'
      @trains << CargoTrain.new(name, number)
      result  @trains[-1]
    end
  rescue RuntimeError => mistake
    try_again mistake
  end

  def result(train)
    puts "Поезд имя = #{train.name}",
         "номер = #{train.number}",
         "тип = #{train.class} создан"
  end

  def puts_txt(text)
    puts text unless text.nil?
  end

  def try_again(error)
    puts error.message
  end
end
