require 'erb'
require './models/item'

class ItemController
  def create_item(param)
    item = Item.new({
                      name: param['name'],
                      price: param['price']
                    })
    item.save
    renderer = ERB.new(File.read('./views/create.erb'))
    renderer.result(binding)
  end

  def index
    item = Item.find_all
    puts item
    renderer = ERB.new(File.read('./views/index.erb'))
    renderer.result(binding)
  end

  def delete_categories_from_item(id,cat_id)
    item = Item_categories.delete(id,cat_id)
  end

  def list_category(id)
    id = id
    category = Item.find_category(id)
    renderer = ERB.new(File.read('./views/list_category.erb'))
    renderer.result(binding)
  end

  def form_add_category(id)
    id = id
    categories = Category.get_all_categories
    renderer = ERB.new(File.new('./views/add_category.erb').read)
    renderer.result(binding)
  end

  def add_category(id, category_id)
    puts id
    puts category_id
    category = Item_categories.save(id, category_id)
  end

  def form_add
    renderer = ERB.new(File.new('./views/create.erb').read)
    renderer.result()
  end

  def delete_item(id)
    Item.delete(id)
  end

  def details(id)
    item = Item.find_with_category(id)
  end

  def add_item(param)
    item = Item.find_by_id(param[:ref_no])
    item.add_item(params)
    renderer = ERB.new(File.read('./views/create.erb'))
    renderer.result(binding)
  end

  def list_item_by_categories(id)
    Item.find_with_category(id)
  end
end