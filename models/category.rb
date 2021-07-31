require '../db/db_connector'

class Category
  attr_accessor :id,:name, :item

  def initialize(param)
    @id = param[:id]
    @name = param[:name]
    @item = param[:item]
  end

  def self.get_all_categories
    client = get_client
    categories = client.query("select * from categories")
    convert_sql_result_to_array(categories)
  end

  def self.find_by_id(id)
    client = get_client
    rawData=client.query("select * from categories WHERE id=#{id}")
    convert_sql_result_to_array(rawData)
  end

  def self.find_by_item(id)
    categories = find_by_id(id)
    categories.item = Item.find_by_id(id)
    categories
  end

  def save
    return false unless valid?
    client = get_client
    client.query("INSERT INTO categories(name) VALUES('#{name}')")
  end

  def self.update(id,name)
    client = get_client
    client.query("UPDATE categories SET name='#{name}' WHERE id=#{id}")
  end

  def self.delete(id)
    client = get_client
    client.query("DELETE FROM categories WHERE id=#{id}")
    Item_categories.clear(id)
  end

  def to_s
    @name
  end

  def valid?
    return false if @name.nil?
    true
  end

  def self.convert_sql_result_to_array(result)
    categories = Array.new
    result.each do |data|
      category = Category.new({
                                id: data['id'],
                                name: data['name']
                      })
      categories << category
    end
    categories
  end
end
