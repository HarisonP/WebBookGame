class Mage < Hero
  attr_accessor :defencive_improvements
  attr_accessor :offensive_improvements
  attr_accessor :damage_reduce
  def initialize(hero_exists,  sex:"mage", rasse:"human", classe:"mage", name:"dummy", user_id:"")
    super hero_exists, sex, rasse, classe, name, user_id 
    @defencive_improvements = {}
    @defencive_improvements['mana_per_turn'] = 0
    @defencive_improvements['chance_mana_per_turn'] = 10
    @defencive_improvements['block_damage_return'] = 0
    @defencive_improvements['block_update'] = 0
    @defencive_improvements['healt_per_turn'] = 0
    @defencive_improvements['damage_reduce_per_turn'] = 0
   

    @defencive_improvements['block_restore_update'] = 0

    
    @defencive_improvements['points'] = {}
    @defencive_improvements['points']['mana_per_turn'] = 0
    @defencive_improvements['points']['chance_mana_per_turn'] = 0
    @defencive_improvements['points']['block_damage_return'] = 0
    @defencive_improvements['points']['block_update'] = 0
    @defencive_improvements['points']['healt_per_turn'] = 0
    @defencive_improvements['points']['damage_reduce_per_turn'] = 0
   
    @defencive_improvements['points']['block_restore_update'] = 0




    @offensive_improvements = {}
    @offensive_improvements['frost_bolt_mana_reduce'] = 0
    @offensive_improvements['frost_bolt_damage_reduce'] = 0
    @offensive_improvements['arcane_blast_damage'] = 0
    @offensive_improvements['arcane_blast_restore_improvment'] = 0
    @offensive_improvements['rest_damage'] = 0
    @offensive_improvements['rest_health_restored'] = 0

    @offensive_improvements['piro_blast_frost_callback'] = 0

    @offensive_improvements['points'] = {}
    @offensive_improvements['points']['frost_bolt_mana_reduce'] = 0
    @offensive_improvements['points']['frost_bolt_damage_reduce'] = 0
    @offensive_improvements['points']['arcane_blast_damage'] = 0
    @offensive_improvements['points']['arcane_blast_restore_improvment'] = 0
    @offensive_improvements['points']['rest_damage'] = 0
    @offensive_improvements['points']['rest_health_restored'] = 0

    @offensive_improvements['points']['piro_blast_frost_callback'] = 0

    @damage_reduce = 0    
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
        when 'frost_bolt_mana_reduce'
          @offensive_improvements['frost_bolt_mana_reduce'] += 1 * how_many
          @offensive_improvements['points']['frost_bolt_mana_reduce'] += how_many
        when 'frost_bold_damage_reduce'
          if @offensive_improvements['frost_bolt_damage_reduce'] == 0
            @offensive_improvements['frost_bolt_damage_reduce'] = 20
            how_many -= 1
            @offensive_improvements['points']['frost_bolt_damage_reduce'] += 1
          end
          @offensive_improvements['frost_bolt_damage_reduce'] += 5 * how_many
          @offensive_improvements['points']['frost_bolt_damage_reduce'] += how_many
        when 'arcane_blast_damage'
          @offensive_improvements['arcane_blast_damage'] += 1 * how_many
          @offensive_improvements['points']['arcane_blast_damage'] += how_many
        when 'arcane_blast_restore_improvment'
            @offensive_improvements['arcane_blast_restore_improvment'] += 0.3 * how_many
            @offensive_improvements['points']['arcane_blast_restore_improvment'] += how_many
        when 'rest_damage'
          if @offensive_improvements['rest_damage'] == 0
            @offensive_improvements['rest_damage'] = 0.5
            @offensive_improvements['points']['rest_damage'] += 1
            how_many -= 1
          end
          @offensive_improvements['rest_damage'] += 0.2 * how_many
          @offensive_improvements['points']['rest_damage'] += how_many
        when 'rest_health_restored'
          if @offensive_improvements['rest_health_restored'] == 0
            @offensive_improvements['rest_health_restored'] = 0.5
            how_many -= 1
            @offensive_improvements['points']['rest_damage'] += 1
          end
          @offensive_improvements['rest_health_restored'] += 0.2 * how_many
          @offensive_improvements['points']['rest_damage'] += how_many
        when 'piro_blast_frost_callback'
          if @offensive_improvements['piro_blast_frost_callback'] == 0
            @offensive_improvements['piro_blast_frost_callback'] = 50
            how_many -= 1
            @offensive_improvements['points']['rest_damage'] += 1
          end
          @offensive_improvements['piro_blast_frost_callback'] += 10 * how_many
          @offensive_improvements['points']['piro_blast_frost_callback'] += how_many
      end
    else
      case improvement_name 
        when 'mana_per_turn'
          if @defencive_improvements['mana_per_turn'] == 0
            @defencive_improvements['mana_per_turn'] = 10
            how_many -= 1
            @defencive_improvements['points']['mana_per_turn'] += 1  
           end
          @defencive_improvements['mana_per_turn'] += 5 * how_many
          @defencive_improvements['points']['mana_per_turn'] += how_many
        when 'chance_mana_per_turn'
          if @defencive_improvements['chance_mana_per_turn'] == 0
            @defencive_improvements['chance_mana_per_turn'] = 20
            how_many -= 1
            @defencive_improvements['points']['chance_mana_per_turn'] += 1
           end
          @defencive_improvements['chance_mana_per_turn'] += 10 * how_many
          @defencive_improvements['points']['chance_mana_per_turn'] += how_many
        when 'block_update'
          @defencive_improvements['block_update'] += 1 * how_many
          @defencive_improvements['points']['block_update'] += how_many
        when 'healt_per_turn'
            @defencive_improvements['healt_per_turn'] += 0.1 * how_many
            @defencive_improvements['points']['healt_per_turn'] += how_many
        when 'damage_reduce_per_turn'
          @defencive_improvements['damage_reduce_per_turn'] += 0.1 * how_many
          @defencive_improvements['points']['damage_reduce_per_turn'] += how_many
        when 'block_damage_return'
          @defencive_improvements['block_damage_return'] += 0.5 * how_many
          @defencive_improvements['points']['block_damage_return'] += how_many
        when 'block_restore_update'
          @defencive_improvements['block_restore_update'] += 0.1 * how_many
      end
    end
  end
  def levelup
    super
    @properties['intelligence'] += 1
    @properties['max_health'] += 5
    @properties['max_mana'] += @properties['intelligence']/10.floor
  end
  #not implemented
  def take_damage(damage:, blocked_positions:[], position:, info:{})
    info['position'] = position
    info['blocked'] = false
    info['damage_taken'] = damage
    info['health_restored'] = 0
    info['mana_restored'] = 0
    info['damage_returned'] = 0
    info['damage_reduce_generated'] = 0
    case position
      when "head"
        damage = damage * 1.1
      when 'body'
        damage = damage * 1
      when 'legs' || 'arms'
        damage = damage * 0.9
    end

    if blocked_positions.include?(position);
      damage -= block
      @properties['current_health'] += (@defencive_improvements['block_restore_update'] * damage).floor
      info['health_restored'] += (@defencive_improvements['block_restore_update'] * damage).floor

      @properties['current_mana'] += @defencive_improvements['block_restore_update'] * damage
      info['mana_restored'] += (@defencive_improvements['block_restore_update'] * damage).floor

      info['damage_returned'] = @defencive_improvements['block_damage_return'] * @damage_reduce
      info['blocked'] = true
    else
      damage -= taken
      if(damage <= @damage_reduce)
        damage = 0
        @damage_reduce -=damage
      else
        damage -= @damage_reduce
        @damage_reduce = 0
      end
    end

      damage = 0 if damage < 0
      damage = damage.floor
      @properties['current_health'] -= damage
      generate_mana(info:info);
      info["damage_taken"] = damage
      @properties['current_health'] > 0
  end

  def first_spell
    if @properties['current_mana'] >= @properties['level'] * (20 - @offensive_improvements['frost_bolt_mana_reduce'])
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
    20 * @properties['level'] + 3 * @properties['speed'] + @properties['intelligence'] + @defencive_improvements['block_update']*(@properties['intelligence'] + @properties['strength'])
  end

  def generate_mana(info:{})
    @properties['current_mana'] += (@properties['level'] * @defencive_improvements['mana_per_turn']).floor
    info['mana_restored'] += (@properties['level'] * @defencive_improvements['mana_per_turn']).floor
    randomer = Random.new
    chance = randomer.rand(100) + 1
    if(chance <= 40)
      @properties['current_mana'] += @defencive_improvements['chance_mana_per_turn']
      info['mana_restored'] +=  @defencive_improvements['chance_mana_per_turn']
    end
    @properties['current_health'] += @properties['level']*10 + @defencive_improvements['healt_per_turn'] * @properties['intelligence']
    info['health_restored'] += @properties['level']*10 + @defencive_improvements['healt_per_turn'] * @properties['intelligence']
    p @damage_reduce
    @damage_reduce += (@defencive_improvements['damage_reduce_per_turn'] * @properties['intelligence']).floor
    info['damage_reduce_generated'] += (@defencive_improvements['damage_reduce_per_turn'] * @properties['intelligence']).floor
  end

  def frost_bolt
    damage + @properties['intelligence']
    @damage_reduce += @properties['strength'] + @properties['dexterity']
    randomer = Random.new
    frost_bolt_dr_double_chance = @offensive_improvements['frost_bolt_damage_reduce']
    while( frost_bolt_dr_double_chance > 0)
      chance = randomer.rand(100) + 1
      @damage_reduce *= 2 if(chance <= frost_bolt_dr_double_chance)
      frost_bolt_dr_double_chance -= 100
    end

  end

  def arcane_blast
    3 * damage + 2 * @properties['dexterity']  + @offensive_improvements['arcane_blast_damage'] * @properties['intelligence']
    @properties['current_health'] += @offensive_improvements['arcane_blast_restore_improvment'] * properties['strength']
    @properties['current_mana'] += @offensive_improvements['arcane_blast_restore_improvment'] * properties['intelligence']
  end

  def rest
   @properties['mana'] += 3 * @properties['intelligence'] + @properties['speed']
   @damage_reduce += 2 * @properties['speed'] + @properties['strength']
   @offensive_improvements['rest_damage'] * damage
  end
  def piro_blast
    damage = 5 * @properties['intelligence'] + 3 * damage + @damage_reduce
    randomer = Random.new
    frost_bolt_callback = @offensive_improvements['piro_blast_frost_callback']
    while( frost_bolt_callback > 0)
      chance = randomer.rand(100) + 1
      damage += frost_bolt 2 if(chance <= frost_bolt_callback)
      frost_bolt_callback -= 100
    end
    @damage_reduce = 0
    damage
  end

end


