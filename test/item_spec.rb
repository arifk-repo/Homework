require_relative 'test_helper'
require '../models/item'
require '../controllers/item_controller'
require 'erb'

describe ItemController do
  context '#item' do
    before(:each) do
      @item_controller = ItemController.new
    end

    it "get all item" do
      actual_view = @item_controller.index
      item = Item.find_all
      expected_output = ERB.new(File.read("../views/index.erb")).result(binding)
      expect(expected_output).to eq(actual_view)
    end

    it "get all list item" do
      id =1
      actual_view = @item_controller.list_category(id)
      category = Item.find_category(id)
      expected_output = ERB.new(File.read("../views/list_category.erb")).result(binding)
      expect(expected_output).to eq(actual_view)
    end
  end
end