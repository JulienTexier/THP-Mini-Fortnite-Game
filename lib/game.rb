class Game
  attr_accessor :human_player, :enemies, :enemies_left

  def initialize(name)
    @human_player = HumanPlayer.new(name)
    @enemies = [Player.new("Sam"), Player.new("Julien"), Player.new("Sarah"), Player.new("Paul")] #création du tableau des ennemis
    @enemies_left = 4
  end

  def kill_player(enemy)
    @enemies.delete(enemy)
    @enemies_left -= 1
  end

  def is_still_ongoing?
    return human_player.life_points > 0 && @enemies_left > 0
  end

  def show_players
    puts "\nVoici l'état de #{@human_player.name} : il lui reste #{@human_player.life_points} points de vie"
    if @enemies_left == 1 
      puts "\nIl ne reste qu'#{@enemies_left} ennemi à combattre !"
    else
      puts "\nIl reste encore #{@enemies_left} ennemies à combattre !"
    end
  end

  def menu
    puts "\nQuelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme" 
    puts "s - chercher à se soigner" 
    puts "\nAttaquer un joueur en vue :"
    0.upto(@enemies.size - 1) do |index|
      puts "#{index} - #{@enemies[index].show_state}\n"
    end
  end
      
  def menu_choice
    choice = gets.chomp
    case choice
      when "a" then @human_player.search_weapon
      when "s" then @human_player.search_health_pack
      else 
        if choice.to_i <= @enemies.size - 1
          @human_player.attacks(@enemies[choice.to_i])
          kill_player(@enemies[choice.to_i]) if @enemies[choice.to_i].life_points <= 0
        end
    end
  end

  def enemies_attack
    if @enemies_left > 0 
      puts "\nLes autres joueurs t'attaquent !"
      @enemies.each do |enemy|
        if enemy.life_points > 0
          enemy.attacks(@human_player)
        end
      end
    end
  end

  def end
    if @human_player.life_points > 0
      puts "BRAVO ! TU AS GAGNE !"
    else
      puts "Loser ! Tu as perdu !"
    end
  end
end