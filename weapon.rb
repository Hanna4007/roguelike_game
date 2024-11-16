class Weapon

  attr_reader :damage_for_strength, :damage_for_dexterity, :damage_for_intelligence, :extra_damage, :character

  def initialize(damage_for_strength: 0, damage_for_dexterity: 0, damage_for_intelligence: 0, extra_damage: 0, name: , character: )
    @damage_for_strength = damage_for_strength
    @damage_for_dexterity = damage_for_dexterity
    @damage_for_intelligence = damage_for_intelligence
    @extra_damage = extra_damage
    @name = name
    @character = character
  end
  
  def total_damage
    (@damage_for_strength * character.strength) + (@damage_for_dexterity * character.dexterity) + (@damage_for_intelligence * character.intelligence) + @extra_damage
  end

  def name
    @name.to_s.capitalize.gsub('_', ' ')
  end 
  
  def similar?(new_weapon)
    name == new_weapon.name
  end

  def merge(new_weapon)
    @damage_for_strength = [damage_for_strength, new_weapon.damage_for_strength].max
    @damage_for_dexterity = [damage_for_dexterity, new_weapon.damage_for_dexterity].max
    @damage_for_intelligence = [damage_for_intelligence, new_weapon.damage_for_intelligence].max
    @extra_damage = [extra_damage, new_weapon.extra_damage].max
    @name = "#{name}(enhanced)"
    self       
  end

  def max_total_damage_weapon      
    [-total_damage, name]    
  end

  def name_for_event
    "#{character.name} finds '#{name}'" 
  end
end