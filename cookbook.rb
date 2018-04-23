require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    CSV.foreach(csv_file_path) do |row|
      temporary_recipe = Recipe.new(row[0], row[1], row[2], row[3])
      @recipes << temporary_recipe
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each { |r| csv << [r.name, r.description, r.prep_time, r.difficulty] }
    end
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each { |r| csv << [r.name, r.description, r.prep_time, r.difficulty] }
    end
  end

  def mark_as_done(recipe_index)
    @recipes[recipe_index].done = true
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each { |r| csv << [r.name, r.description, r.prep_time, r.difficulty] }
    end
  end
end
