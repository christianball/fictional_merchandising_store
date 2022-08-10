require 'rails_helper'

RSpec.describe Item, :type => :model do

  it 'is valid with valid attributes' do
    expect(Item.new(code: 'HAT', name: 'Reedsy Hat', price: 8.0)).to be_valid
  end

  describe 'code' do
    it 'is not valid when code is nil or an empty string' do
      expect(Item.new(code: nil, name: 'Reedsy Hat', price: 8.0)).to_not be_valid
      expect(Item.new(code: ' ', name: 'Reedsy Hat', price: 8.0)).to_not be_valid
    end

    it 'is not valid when code is too short or too long' do
      too_long_code = 'ABCDEFGHIJKLMNOPQRSTU'
      expect(Item.new(code: 'A', name: 'Reedsy Hat', price: 8.0)).to_not be_valid
      expect(Item.new(code: too_long_code, name: 'Reedsy Hat', price: 8.0)).to_not be_valid
    end
  end

  describe 'name' do
    it 'is not valid when name is nil or an empty string' do
      expect(Item.new(code: 'HAT', name: nil, price: 8.0)).to_not be_valid
      expect(Item.new(code: 'HAT', name: ' ', price: 8.0)).to_not be_valid
    end

    it 'is not valid when name is too short or too long' do
      too_long_name = 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXY'
      expect(Item.new(code: 'HAT', name: 'A', price: 8.0)).to_not be_valid
      expect(Item.new(code: 'HAT', name: too_long_name, price: 8.0)).to_not be_valid
    end
  end

  describe 'price' do
    it 'is not valid when price is nil' do
      expect(Item.new(code: 'HAT', name: 'Reedsy Hat', price: nil)).to_not be_valid
    end

    it 'is not valid when price is not numerical' do
      expect(Item.new(code: 'HAT', name: 'Reedsy Hat', price: 'A')).to_not be_valid
    end

    it 'is not valid when price is too low or too high' do
      expect(Item.new(code: 'HAT', name: 'Reedsy Hat', price: 0.1)).to_not be_valid
      expect(Item.new(code: 'HAT', name: 'Reedsy Hat', price: 19999999)).to_not be_valid
    end
  end

end
