require_relative 'cookbook'

require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
set :bind, '0.0.0.0'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  @menu = [
    ["1 - List all recipes", "list"],
    ["2 - Create a new recipe", "create"],
    ["3 - Destroy a recipe", "destroy"],
    ["4 - Import recipes from Marmiton", "import"],
    ["5 - Mark a recipe as done", "mark"]
  ]
  erb :index
end


get '/list' do
  @cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  erb :list
end

get '/list/:idx' do
  @cookbook = Cookbook.new(File.join(__dir__, 'recipes.csv'))
  @idx = params[:idx]
  erb :recette
end
