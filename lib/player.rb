class Player
  attr_accessor :name, :life_points, :damage_received

  def initialize(name, life_points = 10)
    @name = name
    @life_points = life_points
  end

  def show_state
    return "#{@name} a #{@life_points} points de vie."
  end

  def gets_damage(damage_received)
      @life_points -= damage_received #le total des points de vies est égal à la vie moins les dégats reçus
    if @life_points <= 0 #si le joueur n'a plus de vie, alors il est mort
      puts "Le joeur #{name} a été tué !"
    end
  end

  def attacks(target)
    puts "Le joueur #{name} attaque le joueur #{target.name}" #utiliser target permet de dissocier les deux joeurs
    @damage_received = compute_damage #dommage reçu est égal au retour de la méthode compute_damage, soit le chiffre entre 1 et 6
    puts "Il lui inflige #{@damage_received} points de dommages"
    target.gets_damage(@damage_received) #on envoie le player attaqué dans la méthode gets_damage pour que les vies perdues soient comptées
  end

  def compute_damage
    return rand(1..6) #Retourne un chiffre aléatoire entre 1 et 6
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name, life_points = 100)
    @weapon_level = weapon_level = 1

    super(name, life_points)
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}."
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    @new_weapon_level = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{@new_weapon_level}"
    if @new_weapon_level > @weapon_level
      @weapon_level = @new_weapon_level
      puts "Youhou ! Elle est meilleure que ton arme actuelle : tu la prends."
    else
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end
  end

    def search_health_pack
      @health_pack = rand(1..6)
      if @health_pack == 1
        puts "Tu n'as rien trouvé..."
      elsif @health_pack == 6
        @life_points += 80 
        if @life_points > 100
          @life_points = 100
        end
        puts "Waow, tu as trouvé un pack de +80 points de vie !"
      else
        @life_points += 50 
        if @life_points > 100
          @life_points = 100
        end
        puts "Bravo, tu as trouvé un pack de +50 points de vie !"
      end
    end
end
