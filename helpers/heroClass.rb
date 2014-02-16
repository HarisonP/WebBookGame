class Hero 
  attr_accessor :properties

  def initialize(hero_exists, sex, rasse, classe, name, userId)
    @properties = {}
    if hero_exists
    else
      @properties['strength'] = 0
      @properties['speed'] = 0
      @properties['dexterity'] = 0
      @properties['intelligence']= 0
      @properties['harizma'] = 0

      @properties['max_health'] = 0
      @properties['armour'] = 0
      @properties['level'] = 1
      @properties['expirience'] = 0
      @properties['unused_skill_points'] = 0
      @properties['unused_skiil_update_points'] = 0

      @properties['max_mana']
      @properties['max_energy']
      @properties['max_focus']
      @properties['max_rage']

      @properties['sex'] = sex
      @properties['rasse'] = rasse
      @properties['class'] = classe
      @properties['name'] = name  
      @properties['userId'] = userId
    end

    if rasse == 'human'
      @properties['intelligence'] += 5
      @properties['strength'] += 2
      @properties['harizma'] += 2
      @properties['max_health'] += 20
    elsif rasse == 'elf'
      @properties['dexterity'] += 5
      @properties['intelligence'] += 2
      @properties['harizma'] += 3
      @properties['speed'] += 2
    elsif rasse == 'orc'
      @properties['strength'] += 9
      @properties['max_health'] += 50
      @properties['harizma'] -= 3
    end
  end
  def levelup
    @properties['max_health'] += 10
    @properties['unused_skill_points'] += 10
    @properties['unused_skiil_update_points'] += 1
    @properties['level'] += 1
    @properties['expirience'] -= 50* (2**@properties['level'])

    if rasse == 'human'
      @properties['unused_skill_points'] += 1
      @properties['intelligence'] += 3
      @properties['strength'] += 1
      @properties['max_health'] += 15
    elsif rasse == 'elf'
      @properties['dexterity'] += 4
      @properties['intelligence'] += 1
      @properties['harizma'] += 1
      @properties['speed'] += 1
    elsif rasse == 'orc'
      @properties['strength'] += 5
      @properties['max_health'] += 25
    end
    @properties['current_health'] = @properties['max_health']
  end

end