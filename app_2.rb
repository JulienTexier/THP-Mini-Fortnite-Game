require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "------------------------------------------------"
puts "|   Bienvenue sur 'ILS VEULENT TOUS MA POO' !   |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"

puts "Quel est le nom de ton joueur?"
print "> "
player = HumanPlayer.new(gets.chomp) #création de l'instance player qui est défini par l'utilisateur
enemies = [Player.new("Josiane"), Player.new("José")] #création du tableau des ennemis


while player.life_points > 0 && (enemies[0].life_points > 0 || enemies[1].life_points > 0) #Boucle pour terminer le jeu lorsque le joueur 1 ou les 2 autres ont perdu toutes leurs vies
  puts "\nVoici l'état de #{player.name} : il lui reste #{player.life_points} points de vie"
      puts "\nQuelle action veux-tu effectuer ?" 
      puts "a - chercher une meilleure arme"
      puts "s - chercher à se soigner"
      puts "\nAttaquer un joueur en vue :"
      print "0 - " 
      enemies[0].show_state
      print "1 - " 
      enemies[1].show_state

      pgm = gets.chomp.downcase
      case pgm
          when "a" then player.search_weapon
          when "s" then player.search_health_pack
          when "0" then player.attacks(enemies[0])
          when "1" then player.attacks(enemies[1])
      end
  enemies.each do |enemy|
    if enemy.life_points <= 0
      enemy.life_points = 0
    elsif player.life_points > 0  
      if enemy.life_points > 0
        puts "Les autres joueurs t'attaquent !"
        enemy.attacks(player)
      else
        break
      end
    end
  end
end
if player.life_points > 0
  puts "BRAVO ! TU AS GAGNE !"
else
  puts "Loser ! Tu as perdu !"
end
