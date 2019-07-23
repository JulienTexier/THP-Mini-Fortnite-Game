require 'bundler'
Bundler.require
require 'pry'

require_relative 'lib/game'
require_relative 'lib/player'

puts "------------------------------------------------"
puts "|   Bienvenue sur 'ILS VEULENT TOUS MA POO' !   |"
puts "|Le but du jeu est d'être le dernier survivant!!|"
puts "-------------------------------------------------"

puts "Quel est le nom de ton joueur?"
print "> "
my_game = Game.new(gets.chomp)
while my_game.is_still_ongoing?  #Tant que is_still_ongoing? est true, le jeud continue
  my_game.show_players
  my_game.new_players_in_sight
  my_game.menu
  my_game.menu_choice
  my_game.enemies_attack
end
my_game.end
