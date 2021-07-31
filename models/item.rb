require './db/db_connector'
require_relative 'category'
require_relative 'item_categories'

class Item
  attr_accessor :id, :name, :price, :category

  def initialize(param)
    @id = param[:id]
    @name = param[:name]
    @price = param[:price]
    @category = []
  end

  def self.update(id, name, price)
    client = get_client
    client.query("UPDATE items SET name='#{name}',price=#{price} WHERE id=#{id}")
  end

  def self.delete(id)
    puts "DELETE FROM items WHERE id=#{id}"
    db = get_client
    db.query("DELETE FROM items WHERE id=#{id}")
  end

  def save
    return false unless valid?
    client = get_client
    client.query("INSERT INTO items(name,price) VALUES('#{name}','#{price}')")
  end

  def self.add_item(param)
    item = Item.new({
                      id: param['id'],
                      name: param['name'],
                      price: param['price'],
                      category: self
                    })
    item.save
    item
  end

  def self.find_with_category(id)
    item = find_by_id(id)
    # item.category = Category.find_by_id(id)
    categories = Item_categories.find_categories(id)
    puts categories
    item.category << categories
    item
  end

  def self.find_category(id)
    Item_categories.find_categories(id)
  end

  def self.find_all
    client = get_client
    rawData = client.query("select * from items")
    convert_sql_result_to_array(rawData)
  end

  def self.delete_category(id,cat_id)
    Item_categories.delete(id,cat_id)
  end

  def self.find_by_id(id)
    client = get_client
    rawData = client.query("select * from items WHERE id=#{id}")
    convert_sql_result_to_array(rawData)
  end

  def valid?
    return false if @name.nil?
    return false if @price.nil?
    true
  end

  def self.convert_sql_result_to_array(result)
    items = Array.new
    result.each do |data|
      item = Item.new({
                        id: data['id'],
                        name: data['name'],
                        price: data['price'],
                        category: self
                      })
      items << item
    end
    items
  end

  def self.selected_menus(id)
    client = get_client
    menus = client.query("SELECT items.id as item_id, items.name as item_name,items.price as price,categories.name as category_name,categories.id as category_id FROM items LEFT JOIN item_categories ON items.id=item_categories.item_id LEFT JOIN categories ON item_categories.category_id=categories.id WHERE items.id=#{id}")
  end

end
