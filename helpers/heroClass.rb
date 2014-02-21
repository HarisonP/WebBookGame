class Hero 
  attr_accessor :properties
  attr_accessor :offensive_improvements
  attr_accessor :defencive_improvements
  def initialize(hero_exists, hero: , sex:, rasse:, classe:, name:, user_id:)
    @properties = {}
    if hero_exists
      @defencive_improvements = hero['defencive_improvements']
      @offensive_improvements = hero['offensive_improvements']
      @properties = hero['properties']
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
      @properties['unused_skill_points'] = 10
      @properties['unused_magic_points'] = 1

      @properties['max_mana']
      @properties['max_energy']
      @properties['max_focus']
      @properties['max_rage']

      @properties['sex'] = sex
      @properties['rasse'] = rasse
      @properties['class'] = classe
      @properties['name'] = name  
      @properties['user_id'] = user_id
      @properties['current_health'] = @properties['max_health']

      @defencive_improvements = {}
      @defencive_improvements['points'] = {}

      @offensive_improvements = {}
      @offensive_improvements['points'] = {}

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

  end
  def levelup
    @properties['max_health'] += 10
    @properties['unused_skill_points'] += 10
    @properties['unused_magic_points'] += 1
    @properties['expirience'] -= 50* (2**@properties['level'])
    @properties['level'] += 1
    

    if @properties['rasse'] == 'human'
      @properties['unused_skill_points'] += 1
      @properties['intelligence'] += 3
      @properties['strength'] += 1
      @properties['max_health'] += 15
    elsif @properties['rasse'] == 'elf'
      @properties['dexterity'] += 4
      @properties['intelligence'] += 1
      @properties['harizma'] += 1
      @properties['speed'] += 1
    elsif @properties['rasse'] == 'orc'
      @properties['strength'] += 5
      @properties['max_health'] += 25
    end
  end
  def save_hero db:, collection:"heroes"
    @properties['image'] = @properties["rasse"].capitalize + @properties["sex"].capitalize + @properties["class"].capitalize + ".jpg"
    Models::Heroes.save_hero db:db, hero:self, collection:collection
  end

  def update_hero db:, user_id: ,hero_id: , hero:, collection: "heroes"
    p collection
    Models::Heroes.update_hero(db: db, collection: collection,user_id:user_id, hero_id: hero_id, update_obj: hero)
  end

end