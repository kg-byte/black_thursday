require_relative '../lib/merchant_repository'
require_relative 'spec_helper'
require 'pry'

RSpec.describe MerchantRepository do

  before(:each) do
    data = SalesEngine.from_csv({:items=> "./data/items.csv", :merchants => "./data/merchants.csv",})
    se = SalesEngine.new(data)
    @merchants_i =se.merchants
  end



  it "exist" do
    expect(@merchants_i).to be_a(MerchantRepository)
  end

  it "holds #all merchant data" do
    expect(@merchants_i.all.count).to eq(476)
  end

  it "can find by id or return nil" do
    expected = @merchants_i.find_by_id(12334155)
    expect(expected.id).to eq(12334155)
    expect(expected.name).to eq('DesignerEstore')
    expect(@merchants_i.find_by_id('1')).to be nil
  end

  it "can find first matching merchant by case-insensitive name or nil" do
      name = "leaburrot"
      expected = @merchants_i.find_by_name(name)
      expect(expected.id).to eq 12334411
      expect(expected.name).to eq name
      name_up = "LEABURROT"
      expected_up =@merchants_i.find_by_name(name_up)
      expect(expected_up.id).to eq 12334411
      expect(expected_up.name).to eq name
      expect(@merchants_i.find_by_name("kk")).to be nil
  end

  it "can find all merchants matching a fragment or return nil" do
      fragment = "style"
      expected = @merchants_i.find_all_by_name(fragment)
      expect(expected.length).to eq 3
      expect(expected.map(&:name).include?("justMstyle")).to eq true
      expect(expected.map(&:id).include?(12337211)).to eq true
      expect(@merchants_i.find_all_by_name('Turing School')).to eq []
    end

end
