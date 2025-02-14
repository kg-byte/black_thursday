require 'csv'
require_relative 'repository'
require_relative 'invoice_item'

class InvoiceItemRepository < Repository
  attr_reader :invoice_items

  def initialize(data)
    @invoice_items =[]
    CSV.foreach(data, headers: true, header_converters: :symbol) do |row| header ||= row.headers
      @invoice_items << InvoiceItem.new(row)
    end
    super(@invoice_items)
  end

  def create(attributes)
    attributes[:id] = @invoice_items.last.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    new_item = InvoiceItem.new(attributes)
    @invoice_items << new_item
    new_item
  end

  def update(id, attributes)
    item_to_update = find_by_id(id)
    if item_to_update != nil
      attributes.each do |key, value|
        if ![:id, :item_id, :invoice_id, :created_at].include?(key)
          item_to_update.info[key.to_sym] = value
          item_to_update.info[:updated_at] = (Time.now + 1).to_s
        end
      end
    end
    item_to_update
  end
end
