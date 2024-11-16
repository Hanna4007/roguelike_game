class Modification

  attr_reader :modification_for_strength, :modification_for_dexterity, :modification_for_intelligence

  def initialize(modification_for_strength: , modification_for_dexterity: , modification_for_intelligence: , name: )
    @modification_for_strength = modification_for_strength
    @modification_for_dexterity = modification_for_dexterity
    @modification_for_intelligence = modification_for_intelligence
    @name = name
  end

  def name_for_event
    modifications = {strength: @modification_for_strength, dexterity: @modification_for_dexterity, intelligence: @modification_for_intelligence}
    str = "#{@name.to_s.capitalize.gsub('_', ' ')}:"
    modifications.each do |key, value|            
      str << " #{key} #{value > 0 ? "+#{value}": value}," unless value.zero?   
    end
    str.chomp(",")
  end


  
end