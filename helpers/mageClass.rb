class Mage < Hero
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

    
    @properties['strength'] += 2
    @properties['speed'] += 0
    @properties['dexterity'] += 2
    @properties['intelligence'] += 6
    @properties['max_health'] += 100
    @properties['max_mana'] = 150
    @properties['current_mana'] = 150
    @properties['armour'] += 0
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
    @properties['intelligence'] += 1
    @properties['max_health'] += 5
    @properties['max_mana'] += @properties['intelligence']/10.floor
  end

  def first_spell
    if @properties['current_mana'] >= @properties['level'] * 20
      fast_hit
    end
  end

  def second_spell
    if @properties['current_mana'] >= @properties['level'] * 30
      heavy_hit
    end
  end

  def third_spell
    defence_mode
  end

  def ultimate 
    if @properties['current_mana'] >= @properties['level'] * 40 and @properties['level'] > 2
      execute
    end
  end

  private

  def damage
      randomer = Random.new
      chance = randomer.rand(12) + 1;
      chance* @properties['level'] + @properties['intelligence']
  end

  def taken
    @properties['armour']
  end

  def block
    20 * @properties['level'] + 3 * @properties['speed'] + @properties['intelligence']
  end

  # def generateRage(damage_taken)
  #   @properties['current_health'] += @properties['armour'] * defencive_improvements['health_per_turn']
  #   @properties['current_rage'] += @properties['level'] * @defencive_improvements['rage_update']
  #   @properties['current_rage'] += damage_taken / 10
  # end

  def frost_bolt
    damage + @properties['intelligence']
  end

  def arcane_blast
    3 * damage + 2 * @properties['dexterity']
  end

  def rest
   @properties['mana'] += 3 * @properties['intelligence'] + @properties['speed']
  end
  def piro_blast
    5 * @properties['intelligence'] + 3 * damage
  end

end


