class Warrior < Hero
  attr_accessor :defencive_improvements
  attr_accessor :offensive_improvements
  def initialize(hero_exists, sex, rasse, classe, name, userId)
    super 
    @defencive_improvements = {}
    @defencive_improvements['rage_update'] = 1
    # not impelementet
    @defencive_improvements['rage_by_taking_damage'] = 0
    # ---
    @defencive_improvements['health_per_turn'] = 0
    @defencive_improvements['block_update'] = 0
    @defencive_improvements['armour_update'] = 0
    # not impelementet
    @defencive_improvements['block_damage_return'] = 0
    # ---
    @defencive_improvements['defence_mode_damage'] = 0

    @offensive_improvements = {}
    @offensive_improvements['execute_critical_chance'] = 5
    @offensive_improvements['fast_hit_damage'] = 1
    @offensive_improvements['fast_hit_rage'] = 0
    @offensive_improvements['heavy_hit_rage'] = 0
    @offensive_improvements['heavy_hit_damage'] = 1
    @offensive_improvements['defence_mode_damage'] = 0
    @offensive_improvements['defence_mode_health'] = 0

    
    @properties['strength'] += 5
    @properties['speed'] += 2
    @properties['dexterity'] += 2
    @properties['intelligence'] += 1
    @properties['max_health'] += 150
    @properties['max_rage'] = 100
    @properties['current_rage'] = 0
    @properties['armour'] += 5
    @properties['armour'] += @properties['level'] * @defencive_improvements['armour_update']
  end
  def add_magic_point(improvement_type:, improvement_name:, how_many:1)
    

    if improvement_type == 'offensive'
      case improvement_name 
        when 'execute_critical_chance'
          @offensive_improvements['execute_critical_chance'] += 2 * how_many
        when 'fast_hit_damage'
          @offensive_improvements['fast_hit_damage'] += 0.2 * how_many
        when 'fast_hit_rage'
          @offensive_improvements['fast_hit_rage'] += 0.1 * how_many
        when 'heavy_hit_rage'
            @offensive_improvements['heavy_hit_rage'] += 0.2 * how_many
        when 'heavy_hit_damage'
          @offensive_improvements['heavy_hit_damage'] += 0.1 * how_many
        when 'defence_mode_damage'
          if @offensive_improvements['defence_mode_damage'] == 0
            @offensive_improvements['defence_mode_damage'] = 0.5
            how_many -= 1
          end
          @offensive_improvements['defence_mode_damage'] += 0.1 * how_many
        when 'defence_mode_health'
          @offensive_improvements['defence_mode_health'] += 0.1 * how_many
      end
    else
      case improvement_name 
        when 'rage_update'
          @defencive_improvements['rage_update'] += 1 * how_many
        when 'rage_by_taking_damage'
          if @defencive_improvements['rage_by_taking_damage'] == 0
            @defencive_improvements['rage_by_taking_damage'] == 0.5
            how_many -= 1
           end
          @defencive_improvements['rage_by_taking_damage'] += 0.1 * how_many
        when 'health_per_turn'
          if @defencive_improvements['health_per_turn']
            @defencive_improvements['health_per_turn'] += 0.05
            how_many -=1
          end
          @defencive_improvements['health_per_turn'] += 0.01 * how_many
        when 'block_update'
            @defencive_improvements['block_update'] += 1 * how_many
        when 'armour_update'
          @defencive_improvements['armour_update'] += 1 * how_many
        when 'block_damage_return'
          if @defencive_improvements['block_damage_return'] == 0
            @defencive_improvements['block_damage_return'] = 0.5
            how_many -= 1
          end
          @defencive_improvements['block_damage_return'] += 0.1 * how_many
        when 'defence_mode_damage'
            if @defencive_improvements['defence_mode_damage'] == 0
            @defencive_improvements['defence_mode_damage'] = 0.5
            how_many -= 1
          end
          @defencive_improvements['defence_mode_damage'] += 0.1 * how_many
      end
    end
  end
  def levelup
    super
    @properties['strength'] += 1
    @properties['armour'] += 5
  end

  def first_spell
    fast_hit
  end

  def second_spell
    # if @properties['current_rage'] >= @properties['level'] * 10
      heavy_hit
    # end
  end

  def third_spell
    defence_mode
  end

  def ultimate 
    # if @properties['current_rage'] >= @properties['level'] * 20 $$ @properties['level'] > 2
      execute
    # end
  end
  def saveHero
    Models::Heroes.saveHero(self)
  end

  private

  def damage
      randomer = Random.new
      chance = randomer.rand(10) + 1;
      chance* @properties['level'] + @properties['strength']
  end

  def taken
    2 * @properties['armour']
  end

  def block
    50 * @properties['level'] + 5 * @properties['armour'] + @defencive_improvements['block_update'] * @properties['armour']
  end

  def generateRage(damage_taken)
    @properties['current_health'] += @properties['armour'] * defencive_improvements['health_per_turn']
    @properties['current_rage'] += @properties['level'] * @defencive_improvements['rage_update']
    @properties['current_rage'] += damage_taken / 10
  end

  def fast_hit
    @offensive_improvements['fast_hit_damage'] * (damage + @properties['speed'] + @properties['dexterity']) + @offensive_improvements['fast_hit_rage'] * @properties['current_rage']
  end

  def heavy_hit
   @offensive_improvements['heavy_hit_damage']  * (3 * damage + 2 * @properties['dexterity']) + @offensive_improvements['heavy_hit_rage'] * @properties['current_rage']
  end

  def defence_mode
    @properties['current_health'] += 10 * @properties['intelligence']
    @properties['current_health'] += @offensive_improvements['defence_mode_health'] * @properties['armour']
    @offensive_improvements['defence_mode_damage'] * damage + defencive_improvements['defence_mode_damage'] * fast_hit
  end
  def execute
    randomer = Random.new
    chance = randomer.rand(100);
    if chance < @offensive_improvements['execute_critical_chance']
      @properties['current_rage'] = 0
      15 * damage + @properties['dexterity'] + @properties['current_rage']
    elsif chance % 2 == 0
      5 * damage + @properties['dexterity'] + @properties['current_rage']
    else
      5 * damage + @properties['current_rage']
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