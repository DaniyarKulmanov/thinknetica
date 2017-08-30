require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'wagons'
require_relative 'action'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'

action = Action.new

loop do
  puts 'Выберите действия(введите "0" для выхода):',
       '1 - Создать станцию',
       '2 - Создать поезд',
       '3 - Создать маршрут, добавить или удалить станцию в маршрут',
       '4 - Назначить маршрут поезду',
       '5 - Добавить вагон',
       '6 - Добавить отцепить вагон',
       '7 - Перемещение поезда',
       '8 - Просмотреть список станций и поездов',
       't - Создать тестовые данные (5 станций, 2 поезда, 1 маршрут)'
  command = gets.chomp
  break if command == '0'

  case command
  when '1'then action.create_station
  when '2'then action.create_train
  when '3'then action.create_route
  when '4'then action.assign_route_to_train
  when '5'then action.train_add_wagon
  when '6'then action.train_del_wagon
  when '7'then action.move_train
  when '8'then action.all_trains_and_stations
  when 't'then action.create_test_data
  else
    puts 'Введите число от 1 до 8 или t'
  end
end






