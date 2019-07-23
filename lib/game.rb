require 'pry'
class Game
  attr_accessor :human_player, :enemies_in_sight, :players_left

  def initialize(name)
    @human_player = HumanPlayer.new(name)
    @enemies_in_sight = [] 
    @players_left = 10
    @players_total = @players_left
  end

  def kill_player(enemy)
    @enemies_in_sight.delete(enemy)
    @players_left -= 1
  end

  def is_still_ongoing?
    return @human_player.life_points > 0 && @players_left > 0
  end

  def new_players_in_sight
    if @enemies_in_sight.size == @players_left
      puts "Tous les joeurs sont déjà en vue"
    elsif @new_player = rand(1..6)
      if @new_player == 1
        puts "Aucun nouveau joueur adverse n'arrive"
      elsif @new_player == 5 || @new_player == 6
        @enemies_in_sight << Player.new("player_0#{@players_total - @players_left + @enemies_in_sight.length}")
        @enemies_in_sight << Player.new("player_0#{@players_total - @players_left + @enemies_in_sight.length}")
        puts "Deux nouveaux adversaires arrivent en vue !"
      else 
        @enemies_in_sight << Player.new("player_0#{@players_total - @players_left + @enemies_in_sight.length}")
        puts "Un nouvel adversaire arrive en vue !"
      end
    end
  end

  def show_players
    puts "\nVoici l'état de #{@human_player.name} : il lui reste #{@human_player.life_points} points de vie"
    if @players_left == 1 
      puts "\nIl ne reste qu'#{@players_left} ennemi à combattre !"
    else
      puts "\nIl reste encore #{@players_left} ennemies à combattre !"
    end
  end

  def menu
    puts "\nQuelle action veux-tu effectuer ?"
    puts "A - chercher une meilleure arme" 
    puts "S - chercher à se soigner" 
    puts "\nAttaquer un joueur en vue :"
    0.upto(@enemies_in_sight.size - 1) do |index|
      print "#{index} - "
      enemies_in_sight[index].show_state
    end
    puts ""
  end
      
  def menu_choice
    choice = gets.chomp.upcase
    case choice
      when "A" then @human_player.search_weapon
      when "S" then @human_player.search_health_pack
      else 
        if choice.to_i <= @enemies_in_sight.size - 1
          @human_player.attacks(@enemies_in_sight[choice.to_i])
          kill_player(@enemies_in_sight[choice.to_i]) if @enemies_in_sight[choice.to_i].life_points <= 0
        end
    end
  end

  def enemies_attack
    if @enemies_in_sight.size > 0
      puts "\nLes autres joueurs t'attaquent !"
      @enemies_in_sight.each do |enemy|
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