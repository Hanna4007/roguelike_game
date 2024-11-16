require_relative '../character'
require_relative '../weapon'
require_relative '../modification'

describe "Sample tests" do
  before do
    @test = Character.new(name: 'Kroker', strength: 15, intelligence: 7)
  end

  def test2
    @test.axe_of_fire(3, 1, 0, 20)
  end

  def test3    
    test2
    @test.staff_of_water(1, 0, 2, 60)
  end

  def test4
    test3
    @test.axe_of_fire(1, 2, 1, 10)
  end

  def test5
    test4
    @test.strange_fruit(-2, 0, 2)
  end

  it "sample test 1: New character" do
    res = "Kroker\nstr 15\ndex 10\nint 7\nlimbs 32 dmg"
    expect(@test.character_info).to eq res
  end

  it "sample test 2: Character finds weapon" do
    test2
    res = "Kroker\nstr 15\ndex 10\nint 7\nAxe of fire 75 dmg"
    expect(@test.character_info).to eq res
  end

  it "sample test 3: Character finds second weapon" do
    test3    
    res = "Kroker\nstr 15\ndex 10\nint 7\nStaff of water 89 dmg"
    expect(@test.character_info).to eq res
  end

  it "sample test 4: Character enchanced weapon" do
    test4
    res = "Kroker\nstr 15\ndex 10\nint 7\nAxe of fire(enhanced) 92 dmg"
    expect(@test.character_info).to eq res
  end

  it "sample test 5: Character stats modifer" do
    test5
    res = "Kroker\nstr 13\ndex 10\nint 9\nStaff of water 91 dmg"
    expect(@test.character_info).to eq res
  end

  it "sample test 6: Show event log" do
    test5
    res = "Kroker finds 'Axe of fire'\nKroker finds 'Staff of water'\nKroker finds 'Axe of fire'\nStrange fruit: strength -2, intelligence +2"
    expect(@test.event_log).to eq res
  end
  
  it "sample test 7: Pick the correct weapon in case of equal damages" do
    ch = Character.new(name: 'Porky', strength: 15, intelligence: 7)
    ch.pillar_of_water(4, 1, 2, 60)
    ch.axe_of_fire(3, 1, 2, 20)
    ch.dunder_of_water(0, 2, 0, 1) 
    ch.axe_of_fire(4, 0, 1, 60)
    ch.staff_of_water(4, 1, 2, 60)
    res = "Porky\nstr 15\ndex 10\nint 7\nAxe of fire(enhanced) 144 dmg"
    expect(ch.character_info).to eq res
  end
end