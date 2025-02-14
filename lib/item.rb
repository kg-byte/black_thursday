require 'time'
require 'bigdecimal'

class Item
  attr_accessor :info

  def initialize(info)
    @info = info
    if @info[:unit_price].class != "BigDecimal"
      price_alt = @info[:unit_price].to_f/100
      @info[:unit_price] = price_alt
    end
  end

  def id
    @info[:id].to_i
  end

  def name
    @info[:name]
  end

  def description
    @info[:description]
  end

  def unit_price
    BigDecimal(@info[:unit_price], 5)
  end

  def merchant_id
    @info[:merchant_id].to_i
  end

  def created_at
    Time.parse(@info[:created_at]).utc
  end

  def updated_at
    Time.parse(@info[:updated_at]).utc
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
