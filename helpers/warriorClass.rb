class Warrior < Hero
  def initialize(hero_exists, sex, rasse, classe, name, userId)
    super 
    @properties['strength'] += 5
    @properties['speed'] += 2
    @properties['dexterity'] += 2
    @properties['intelligence'] + = 1
    @properties['max_health'] += 150
    @properties['max_rage'] += 100
    @properties['current_rage'] = 0
    @properties['armour'] += 5
    @properties['execute_critical_chance'] = 5
  end
  def levelup
    super
    @properties['strength'] += 1
    @properties['armour'] += 5
  end
  def first_spell
  
  end


  private

  def damage
    10 * @properties['level'] + @properties['strength']
  end

  def taken
    2 * @properties['armour']
  end

  def block
    50 * @properties['level'] + 5 * @properties['armour']
  end

  def generateRage(damage_taken)
    @properties['current_rage'] += damage_taken / 10
  end

  def fast_hitd
    damage + @properties['speed'] + @properties['dexterity']
  end

  def heavy_hit
    3 * damage + 2 * dexterity
  end

  def defence_mode
    @properties['current_health'] += 10 * @properties['intelligence']
    0
  end
  def execute
    randomer = Random.new
    var chance = randomer.rand(100);
    if chance < @properties['execute_critical_chance']
      @properties['current_rage'] = 0
      15 * damage + dexterity + @properties['current_rage']
    elsif chance % 2 == 0
      5 * damage + dexterity + rage
    else
      5 * damage + rage
    end
  end
  
end


# @properties['strength'] = 0
#       @properties['speed'] = 0
#       @properties['dexterity'] = 0
#       @properties['intelligence']= 0
#       @properties['harizma'] = 0

#       @properties['healt'] = 100
#       @properties['armour'] = 0
#       @properties['level'] = 1
#       @properties['expirience'] = 0
#       @properties['unused_skill_points'] = 0
#       @properties['unused_skiil_update_points'] = 0
#       @properties['mana']
#       @properties['energy']
#       @properties['focus']
#       @properties['rage']

#       @properties['sex'] = sex
#       @properties['rasse'] = rasse
#       @properties['class'] = classe
#       @properties['name'] = name  
#       @properties['userId'] = userId