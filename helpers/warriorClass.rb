class Warrior < Hero

  def initialize(hero_exists, hero:nil, sex:"male", rasse:"orc", classe:"warrior", name:"dummy", user_id:"")
    if hero_exists
      super
    else
      super hero_exists, hero:hero, sex:sex, rasse:rasse, classe:classe, name:name, user_id:user_id
      
      @defencive_improvements['rage_update'] = 1
      @defencive_improvements['rage_by_taking_damage'] = 0
      @defencive_improvements['health_per_turn'] = 0
      @defencive_improvements['block_update'] = 0
      @defencive_improvements['armour_update'] = 0
      @defencive_improvements['block_damage_return'] = 0
      @defencive_improvements['defence_mode_damage'] = 0

      
      @defencive_improvements['points']['rage_update'] = 0
      @defencive_improvements['points']['rage_by_taking_damage'] = 0
      @defencive_improvements['points']['health_per_turn'] = 0
      @defencive_improvements['points']['block_update'] = 0
      @defencive_improvements['points']['armour_update'] = 0
      @defencive_improvements['points']['block_damage_return'] = 0
      @defencive_improvements['points']['defence_mode_damage'] = 0

      @offensive_improvements['fast_hit_damage'] = 1
      @offensive_improvements['fast_hit_rage'] = 0
      @offensive_improvements['heavy_hit_rage'] = 0
      @offensive_improvements['heavy_hit_damage'] = 1
      @offensive_improvements['defence_mode_damage'] = 0
      @offensive_improvements['defence_mode_health'] = 0
      @offensive_improvements['execute_critical_chance'] = 5

      
      @offensive_improvements['points']['fast_hit_damage'] = 0
      @offensive_improvements['points']['fast_hit_rage'] = 0
      @offensive_improvements['points']['heavy_hit_rage'] = 0
      @offensive_improvements['points']['heavy_hit_damage'] = 0
      @offensive_improvements['points']['defence_mode_damage'] = 0
      @offensive_improvements['points']['defence_mode_health'] = 0
      @offensive_improvements['points']['execute_critical_chance'] = 0

      
      @properties['strength'] += 5
      @properties['speed'] += 2
      @properties['dexterity'] += 2
      @properties['intelligence'] += 1
      @properties['max_health'] += 150
      @properties['current_health'] = @properties['max_health']
      @properties['max_rage'] = 100
      @properties['current_rage'] = 0
      @properties['armour'] += 5
      @properties['armour'] += @properties['level'] * @defencive_improvements['armour_update']
    end
  end
  def add_magic_points(improvement_type:, improvement_name:, how_many:1)
    
    return if how_many == 0
    
    if improvement_type == 'offensive'
      case improvement_name 
        when 'execute_critical_chance'
          @offensive_improvements['execute_critical_chance'] += 2 * how_many
          @offensive_improvements['points']['execute_critical_chance'] += how_many
        when 'fast_hit_damage'
          @offensive_improvements['fast_hit_damage'] += 0.2 * how_many
          @offensive_improvements['points']['fast_hit_damage'] += how_many
        when 'fast_hit_rage'
          @offensive_improvements['fast_hit_rage'] += 0.1 * how_many
          @offensive_improvements['points']['fast_hit_rage'] += how_many
        when 'heavy_hit_rage'
            @offensive_improvements['heavy_hit_rage'] += 0.2 * how_many
            @offensive_improvements['points']['heavy_hit_rage'] += how_many
        when 'heavy_hit_damage'
          @offensive_improvements['heavy_hit_damage'] += 0.1 * how_many
          @offensive_improvements['points']['heavy_hit_damage'] += how_many
        when 'defence_mode_damage'
          if @offensive_improvements['defence_mode_damage'] == 0
            @offensive_improvements['points']['defence_mode_damage'] = 0.5
            how_many -= 1
            @offensive_improvements['points']['defence_mode_damage'] += 1
          end
          @offensive_improvements['defence_mode_damage'] += 0.1 * how_many
          @offensive_improvements['points']['defence_mode_damage'] += how_many
        when 'defence_mode_health'
          @offensive_improvements['points']['defence_mode_health'] += 0.1 * how_many
          @offensive_improvements['points']['defence_mode_health'] += how_many
      end
    else
      case improvement_name 
        when 'rage_update'
          @defencive_improvements['rage_update'] += 1 * how_many
          @defencive_improvements['points']['rage_update'] += how_many
        when 'rage_by_taking_damage'
          if @defencive_improvements['rage_by_taking_damage'] == 0
            @defencive_improvements['rage_by_taking_damage'] == 0.5
            how_many -= 1
            @defencive_improvements['points']['rage_by_taking_damage'] += 1
           end
          @defencive_improvements['rage_by_taking_damage'] += 0.1 * how_many
          @defencive_improvements['points']['rage_by_taking_damage'] += how_many
        when 'health_per_turn'
          if @defencive_improvements['health_per_turn']
            @defencive_improvements['health_per_turn'] += 0.05
            how_many -=1
            @defencive_improvements['points']['health_per_turn'] += 1
          end
          @defencive_improvements['health_per_turn'] += 0.01 * how_many
          @defencive_improvements['points']['health_per_turn'] += how_many
        when 'block_update'
            @defencive_improvements['block_update'] += 1 * how_many
            @defencive_improvements['points']['block_update'] += how_many
        when 'armour_update'
          @defencive_improvements['armour_update'] += 1 * how_many
          @defencive_improvements['points']['armour_update'] += how_many
        when 'block_damage_return'
          if @defencive_improvements['block_damage_return'] == 0
            @defencive_improvements['block_damage_return'] = 0.5
            how_many -= 1
            @defencive_improvements['points']['block_damage_return'] += 1
          end
          @defencive_improvements['block_damage_return'] += 0.1 * how_many
          @defencive_improvements['points']['block_damage_return'] += how_many
        when 'defence_mode_damage'
            if @defencive_improvements['defence_mode_damage'] == 0
            @defencive_improvements['defence_mode_damage'] = 0.5
            how_many -= 1
            @defencive_improvements['points']['defence_mode_damage'] += 1
          end
          @defencive_improvements['defence_mode_damage'] += 0.1 * how_many
          @defencive_improvements['points']['defence_mode_damage'] += how_many
      end
    end
  end
  def levelup
    super
    @properties['strength'] += 1
    @properties['armour'] += 5
  end
  
  def take_damage(damage:, blocked_positions:[], position:, info:{})
    info['position'] = position
    info['blocked'] = false
    info['damage_taken'] = damage
    info['health_restored'] = 0
    info['rage_restored'] = 0
    info['damage_returned'] = 0
    case position
      when "head"
        damage = damage * 1.1
      when 'body'
        damage = damage * 1
      when 'legs' || 'arms'
        damage = damage * 0.9
    end

    if blocked_positions.include?(position);
      info['damage_returned'] += (@defencive_improvements['block_damage_return'] * fast_hit).floor
      damage -= block
      info['blocked'] = true
    else
      damage -= taken
    end
      damage = 0 if damage < 0
      damage = damage.floor
      @properties['current_health'] -= damage
      generate_rage(damage,info:info);
      info["damage_taken"] = damage
      @properties['current_rage'] += (damage * @defencive_improvements["rage_by_taking_damage"]).floor
      info['rage_restored'] += (damage * @defencive_improvements["rage_by_taking_damage"]).floor
      @properties['current_health'] > 0
  end

  
  def first_spell
    fast_hit
  end

  def second_spell
    if @properties['current_rage'] >= @properties['level'] * 10
      @properties['current_rage'] -= @properties['level'] * 10
      return heavy_hit
    end
    0
  end

  def third_spell
    defence_mode
  end

  def ultimate 
    if @properties['current_rage'] >= @properties['level'] * 20 and @properties['level'] > 2
      @properties['current_rage'] = 0
      return execute
    end
    0
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

  def generate_rage(damage_taken, info:{})
    @properties['current_health'] += (@properties['armour'] * defencive_improvements['health_per_turn']).floor
    info['health_restored'] += (@properties['armour'] * defencive_improvements['health_per_turn']).floor
    @properties['current_rage'] += (@properties['level'] * @defencive_improvements['rage_update']).floor
    info['rage_restored'] +=  (@properties['level'] * @defencive_improvements['rage_update']).floor
    @properties['current_rage'] += (damage_taken / 10).floor
    info['rage_restored'] += (damage_taken / 10).floor
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


