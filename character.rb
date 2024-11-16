class Character

  attr_reader :strength, :dexterity, :intelligence, :name

  def initialize(name: "Hero", strength: 10, dexterity: 10, intelligence: 10)
    @name = name
    @strength = strength
    @dexterity = dexterity
    @intelligence = intelligence
    @weapons = []
    @events = []
  end  
  
  def character_info
    info = []
    info << "#{@name}"
    info << "str #{@strength}"
    info << "dex #{@dexterity}"
    info << "int #{@intelligence}"
    if @weapon
      info << "#{@weapon.name} #{@weapon.total_damage} dmg"
    else
      info << "limbs #{limbs} dmg"
    end
    info.join("\n")  
  end

  def event_log
    @events.join("\n")
  end

  private

  def limbs
    @strength + @dexterity + @intelligence
  end

  def method_missing(method_name, *args)
    if method_name.to_s.match(/^(\w+)_of_(\w+)$/)    
      damage_for_strength, damage_for_dexterity, damage_for_intelligence, extra_damage = args
      new_weapon = Weapon.new(damage_for_strength: , damage_for_dexterity: , damage_for_intelligence: , extra_damage: , name: method_name, character: self) 
      weapon_method(new_weapon)
      
    elsif method_name.to_s.match(/^(\w+)$/)
      modification_for_strength, modification_for_dexterity, modification_for_intelligence = args
      modification = Modification.new(modification_for_strength: , modification_for_dexterity: , modification_for_intelligence: , name: method_name)
      modification_method(modification)
    
    else
      super
    end
  end

  def weapon_method(new_weapon)    
    @events << new_weapon.name_for_event
      if @weapon
        add_or_modify_weapon(new_weapon)
        set_current_weapon
      else
        @weapon = new_weapon
        @weapons << new_weapon
      end  
    end  

    def modification_method(modification)
      @events << modification.name_for_event
      @strength += modification.modification_for_strength
      @dexterity += modification.modification_for_dexterity
      @intelligence += modification.modification_for_intelligence
      set_current_weapon
    end

    def add_or_modify_weapon(new_weapon)
      existing_weapon = @weapons.find{ |weapon| weapon.similar?(new_weapon) }
      if existing_weapon
        existing_weapon.merge(new_weapon)
      else
        @weapons << new_weapon
        new_weapon
      end
    end  

    def set_current_weapon
      @weapon = @weapons.sort_by { |weapon| weapon.max_total_damage_weapon}.first
    end
end