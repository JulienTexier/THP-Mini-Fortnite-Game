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
ennemies = [Player.new("Josiane"), Player.new("José")] #création du tableau des ennemis


while player.life_points > 0 && (ennemies[0].life_points > 0 || ennemies[1].life_points > 0) #Boucle pour terminer le jeu lorsque le joueur 1 ou les 2 autres ont perdu toutes leurs vies
  puts "\nVoici l'état de #{player.name} : il lui reste #{player.life_points} points de vie"
      puts "\nQuelle action veux-tu effectuer ?", "a - chercher une meilleure arme", "s - chercher à se soigner", "\nAttaquer un joueur en vue :", "0 - #{ennemies[0].show_state}", "1 - #{ennemies[1].show_state}"
      pgm = gets.chomp
      case pgm
          when "a" then player.search_weapon
          when "s" then player.search_health_pack
          when "0" then player.attacks(ennemies[0])
          when "1" then player.attacks(ennemies[1])
      end
  ennemies.each do |ennemy|
    if ennemy.life_points <= 0
      ennemy.life_points = 0
    elsif player.life_points > 0  #boucle if qui permet d'arrêter la boucle while si les ennemies[0] et 1 sont morts avant de jouer leurs tours
      if ennemy.life_points > 0
        puts "Les autres joueurs t'attaquent !"
        ennemy.attacks(player)
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
