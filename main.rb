require 'sinatra'
require './controllers/item_controller'
require './controllers/category_controller'

get '/' do
  controller = ItemController.new
  controller.index
end

get '/items/new' do
  controller = ItemController.new
  controller.form_add
end

get '/items/delete/:id' do
  id = params['id']
  controller = ItemController.new
  controller.delete_item(id)
  redirect '/'
end
get '/items/list_category/:id' do
  id = params['id']
  controller = ItemController.new
  controller.list_category(id)
end

get '/items/show/:id' do
  id = params['id']
  controller = ItemController.new
  controller.details(id)
end

post '/items/add_category' do
  puts params['id']
  puts params['id_cat']
  controller = ItemController.new
  controller.add_category(params['id'], params['id_cat'])
  redirect "/items/list_category/#{params['id']}"
end

get '/items/add_category/:id' do
  controller = ItemController.new
  controller.form_add_category(params['id'])
end

get '/category/new' do
  controller = CategoryController.new
  controller.form_add
end

get '/category/' do
  controller = CategoryController.new
  controller.index_category
end

post '/category/create' do
  controller = CategoryController.new
  controller.create_catagory(params)
  redirect '/category/'
end

get '/category/edit/:id' do
  controller = CategoryController.new
  controller.edit_category(params['id'])
end

post '/category/update' do
  controller = CategoryController.new
  controller.update_category(params['id'],params['name'])
  redirect '/category/'
end

get '/category/delete/:id/:id_category' do
  controller = ItemController.new
  controller.delete_categories_from_item(params['id'],params['id_category'])
  redirect "/items/list_category/#{params['id']}"
end

get '/category/delete_category/:id' do
  controller = CategoryController.new
  controller.delete_category(params['id'])
  redirect '/category/'
end
#
# get '/items/edit/:id' do
#   id = params['id']
#   data = Item.selected_menus(id)
#   categories = Category.get_all_categories()
#   erb :edit, locals: {
#     data: data,
#     categories: categories
#   }
# end
#
# post '/items/edit' do
#   item_id = params['id']
#   item_name = params['name']
#   item_price = params['price']
#   item_category = params['category']
#   Item_categories.update(item_id,item_category)
#   Item.update(item_id,item_name, item_price)
#   redirect "/items/edit/#{item_id}"
# end
#

#
post '/items/create' do
  controller = ItemController.new
  controller.create_item(params)
  redirect '/'
end
