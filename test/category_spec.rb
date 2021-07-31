require '../models/category'
require '../controllers/category_controller'
require 'erb'


describe CategoryController do
  context '#category' do
    before(:each) do
      @category_controller = CategoryController.new
    end

    it "get all category from database" do
      actual_view = @category_controller.index_category
      category = Category.get_all_categories
      expected_output = ERB.new(File.read("../views/index_category.erb")).result(binding)
      expect(expected_output).to eq(actual_view)
    end

    it "add category" do
      actual_view = @category_controller.add_category
      expected_output = ERB.new(File.read("../views/create.erb")).result(binding)
      expect(expected_output).to eq(actual_view)
    end

    it "Show form to add" do
      actual_view = @category_controller.form_add
      expected_output = ERB.new(File.read("../views/new_category.erb")).result(binding)
      expect(expected_output).to eq(actual_view)
    end

    it "Edit Category" do
      id=5
      actual_view = @category_controller.edit_category(id)
      category = Category.find_by_id(id)
      expected_output = ERB.new(File.read("../views/edit_category.erb")).result(binding)
      expect(expected_output).to eq(actual_view)
    end

  end
end