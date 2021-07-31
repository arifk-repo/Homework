require './db/db_connector'

class Item_categories
  attr_accessor :id, :item_id, :category_id

  def initialize(id, item_id, category_id)
    @id = id
    @item_id = item_id
    @category_id = category_id
  end

  def self.find_categories(id)
    client = get_client
    rawData = client.query("SELECT DISTINCT categories.id as id, categories.name as name FROM categories INNER JOIN item_categories ON categories.id=item_categories.category_id WHERE item_categories.item_id=#{id}")
    categories =Array.new
    rawData.each do |data|
      category = Category.new({
                                id: data['id'],
                                name: data['name']
                              })
      categories << category
    end
    categories
  end

  def self.save(item_id, category_id)
    puts item_id
    puts category_id
    client = get_client
    client.query("INSERT INTO item_categories(item_id,category_id) VALUE(#{item_id},#{category_id})")
  end

  def self.update(item_id, category_id)
    client = get_client
    client.query("UPDATE item_categories SET item_id=#{item_id},category_id=#{category_id} WHERE item_id=#{item_id}")
  end

  def self.delete(id,cat_id)
    puts id
    puts cat_id
    client = get_client
    client.query("DELETE FROM item_categories WHERE item_id=#{id} AND category_id=#{cat_id}")
  end

  def self.clear(id)
    client = get_client
    client.query("SET FOREIGN_KEY_CHECKS=0")
    client.query("DELETE FROM item_categories WHERE category_id=#{cat_id}")
    client.query("SET FOREIGN_KEY_CHECKS=1")
  end

  def self.get_all_menus
    client = get_client
    client.query('SELECT * FROM item_categories')
  end

  def self.selected_menus(id)
    client = get_client
    client.query("SELECT * FROM item_categories WHERE id=#{id}")
  end

  def self.valid?
    return false if @id.nil?
    return false if @item_id.nil?
    return false if @category_id.nil?
    true
  end
end