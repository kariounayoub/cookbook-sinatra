require 'open-uri'
require 'nokogiri'

class WebRecipe
  attr_reader :recipes_array

  def initialize(ingredient)
    @url = "http://www.marmiton.org/recettes/recherche.aspx?aqt=#{ingredient}"
    @recipes_array = []
  end

  def import_recipes
    html_file = open(@url).read
    html_doc = Nokogiri::HTML(html_file)
    i = 0
    recipes_array_title = []
    recipes_array_url = []
    html_doc.search('.recipe-card__title').each do |element|
      if i < 5
        recipes_array_title << element.text
        i += 1
      end
    end
    i = 0
    html_doc.search('.recipe-card').each do |element|
      if i < 5
        recipes_array_url << element.attribute('href').value
        i += 1
      end
    end
    recipes_array_title.each_with_index do |title, index|
      @recipes_array[index] = [title, recipes_array_url[index]]
    end
  end

  def get_recipe_description(index)
    html_file = open("http://www.marmiton.org#{@recipes_array[index][1]}").read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search('.recipe-preparation__list').each do |element|
      #p element.text.strip.gsub(/\t\t\r\n\t\t\t\r\n\t\t\t/, '\n').gsub(/\t\t\t/, ' : ')
      return element.text.strip.gsub(/\t\t\r\n\t\t\t\r\n\t\t\t/, '\n').gsub(/\t\t\t/, ' : ').gsub('\\n', '\n')
    end
  end

  def get_recipe_prep_time(index)
    html_file = open("http://www.marmiton.org#{@recipes_array[index][1]}").read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search('.recipe-infos__timmings__value').each do |element|
        return element.text.gsub(/\r/, '').gsub(/\n/, '').gsub(/\t/, '')
    end
  end

  def get_recipe_difficulty(index)
    html_file = open("http://www.marmiton.org#{@recipes_array[index][1]}").read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search('.recipe-infos__level .recipe-infos__item-title').each do |element|
        return element.text.gsub(/\r/, '').gsub(/\n/, '').gsub(/\t/, '')
    end
  end
end
