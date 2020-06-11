# require 'rainbow/ext/string'
class CommandLineInterface

  BASE_PATH = "https://www.indexpdx.com/adidas/"

  @@saved = []
  
  def run
    first_selection 
  end
  
  def first_selection 
    # a = AsciiArt.new("https://www.indexpdx.com/content/images/logo.jpeg")
    # print "#{a.to_ascii_art(width: 50)}"
    puts ''
    puts "Welcome to The Sneaker Finder! Are you ready to find your next pair of kicks?".colorize(:green)
    puts ''
    puts "Type yes or any other key to exit"
    
      input = gets.chomp.downcase
      if input == 'y'
        # Saved_Shoe.new 
        puts ''
        puts "Great!! Let's get you started with our list of brands".colorize(:green)
        puts ''
        scrape_brand 
      else 
        puts "Goodbye!".colorize(:green)
      end 
    end
    
    def scrape_brand  
  
      Brand.create_from_collection(IndexPDX_Scraper.brand_list(BASE_PATH)) 
      display_brand 
    end
    
    def display_brand 
      Brand.all.each.with_index(1) { |shoe_object, index| puts "#{index}. #{shoe_object.brand_name.colorize(:cyan)}"}
      puts ""
      puts "Alot to choose from! Let me know which one you want to see more of!".colorize(:green)
      puts ""
      select_brand
    end
    
    def select_brand #SELECT BRAND - FIND BRAND
      puts "Enter a number..."
      input = gets.chomp
      
      if !input.to_i.between?(1, Brand.all.size) #1.Repeat select_brand function if input an index in the length of Brand.all
        puts ""
        puts "That is not a valid option."
        puts ""
        select_brand
      else 
      href = Brand.all[input.to_i - 1].brand_href 
      if input == '1' #1.If they are Jordans, check if they have been scraped before 
        if Brand.all[input.to_i - 1].editions == nil
          scrape_jordan_editions(href, input)
        else
          display_jordan_editions
        end
      elsif Brand.all[input.to_i - 1].shoe_collection == nil #1.If they are other shoes, check if they have been scraped before 
        scrape_shoe_collection(href, input)
      else
        display_shoe_collection(Brand.all[input.to_i - 1].shoe_collection)
      end 
    end 
    end
    
    #---------------------------------------------------------------------------

    def scrape_shoe_collection(href, input)
      scraper = IndexPDX_Scraper.scrape_brand_index_page_one(href)
      Shoe.create_from_collection(scraper)
        Brand.all[input.to_i - 1].shoe_collection= Shoe.all[0...scraper.size]
        display_shoe_collection(Brand.all[input.to_i - 1].shoe_collection)
      end 

    def display_shoe_collection(brand)
      puts ''
      brand.each.with_index(1) do |shoe_obj, index|
        puts "#{index}. Model: #{shoe_obj.shoe_name.colorize(:cyan)}" + " Price: #{shoe_obj.price.colorize(:cyan)}".gsub("+", " ")
        puts ""
      end
      select_shoe_collection
    end 

    def scrape_edition_collection(href, input)
      scraper = IndexPDX_Scraper.scrape_brand_index_page_one(href)
      Shoe.create_from_collection(scraper)
      Brand.all[0].editions[input.to_i - 1].shoe_collection = Shoe.all[0...scraper.size]
      display_shoe_collection(Brand.all[0].editions[input.to_i - 1].shoe_collection)
    end
    
    def select_shoe_collection 
      puts "Gotta love some fresh kicks!! Pick a shoe and I can show you more info.".colorize(:green) 
      puts ""
      puts "Type a number or 'b' for back"
      input = gets.chomp.downcase
     
      if input == "b"
        display_brand 
      else
        puts "Good Choice!".colorize(:green)
        puts ''
        scrape_shoe(input)
      end 
    end
    
    def scrape_jordan_editions(href, input) 
      Jordan_Edition.create_from_collection(IndexPDX_Scraper.scrape_jordans_index_page(href))
      Brand.all[input.to_i - 1].editions= Jordan_Edition.all 
      display_jordan_editions
    end
      
    def display_jordan_editions
      # a = AsciiArt.new("https://simg.nicepng.com/png/small/558-5587064_jordan2-air-jordan-logo-blue.png")
      # print "#{a.to_ascii_art(width: 30)}"
      
      puts ''
      Jordan_Edition.all.each.with_index(1) { |edition, index| puts "#{index}." +  "Jordan #{edition.name}".colorize(:cyan)}
      #   Brand.all.first.editions.each.with_index(1) do |edition, index|
      #  # #Brand.all[input.to_i - 1].editions.each.with_index(1) do |edition, index|
      #     puts "#{index}. Jordan #{edition.name.colorize(:green)}"
      #   end
      select_jordan_editions 
    end
      
    def select_jordan_editions 
      puts ''
      puts "You can't go wrong with a pair of Jordans!".colorize(:green)
      puts ""
      puts "Type a number of 'b' for back."
      puts ""
      input = gets.chomp.downcase
      href = Brand.all[0].editions[input.to_i - 1].href
      if input == "b" #1.Go Back to brand menu. 2.Show Jordan edition either by scraping first or just displaying 
        display_brand 
      elsif Brand.all[0].editions[input.to_i - 1].shoe_collection == nil
        scrape_edition_collection(href, input)
      else 
        display_shoe_collection(Brand.all[0].editions[input.to_i - 1].shoe_collection)
      end 
    end
    
    def scrape_shoe(input)
      Shoe.all[input.to_i - 1].add_attributes(IndexPDX_Scraper.shoe_details(Shoe.all[input.to_i - 1].shoe_href)) 
      display_shoe(input)
    end
    
    def display_shoe(input)
      puts "Brand: #{Shoe.all[input.to_i - 1].brand.colorize(:cyan)}"
      puts "Name: #{Shoe.all[input.to_i - 1].shoe_name.colorize(:cyan)}"
      puts "Colorway: #{Shoe.all[input.to_i - 1].colorway.colorize(:cyan)}"
      puts "Condition: #{Shoe.all[input.to_i - 1].condition.colorize(:cyan)}"
      puts "Year: #{Shoe.all[input.to_i - 1].year.colorize(:cyan)}"
      puts "Price: #{Shoe.all[input.to_i - 1].price.colorize(:cyan)}".gsub("+", " ")
     
      puts "Sizes Available: #{Shoe.all[input.to_i - 1].sizes_available.colorize(:cyan)}"
      save(input)
    end
    
    def save(input)
      puts ''
      puts "Would you like to save this shoe?".colorize(:yellow)
      choice = gets.chomp.downcase
      if choice == 'y'
        @@saved << Shoe.all[input.to_i - 1]
        puts ''
        puts "SHOE SAVED!!!!".colorize(:yellow)
        puts ''
        go_back
      else
        go_back
      end 
    end 
    
    def go_back 
        puts ''
        puts "Would you like to check out more? Type yes, cart, or exit".colorize(:green)
        puts ''
        input = gets.chomp.downcase 
      if input == 'y' 
        puts ''
        display_brand 
      elsif input == 'c' 
        view_saved
      elsif input == 'e' 
        puts ''
        puts 'Goodbye!!'.colorize(:green)
        puts ''
      end
    end 

    def view_saved
      if @@saved.size == 0
        puts ''
        puts 'Your cart is empty.'.colorize(:green)
        puts ''
        go_back 
      else
        puts ''
        puts "////////////////////////////////////////////////////////////////////////////////////////////////////////////////".colorize(:yellow)
        puts "////////////////////////////////////////////////////////////////////////////////////////////////////////////////".colorize(:yellow)
        puts ''
        @@saved.each do |shoe|
          puts "Brand: #{shoe.brand.colorize(:cyan)}"
          puts "Name: #{shoe.shoe_name.colorize(:cyan)}"
          puts "Colorway: #{shoe.colorway.colorize(:cyan)}"
          puts "Condition: #{shoe.condition.colorize(:cyan)}"
          puts "Year: #{shoe.year.colorize(:cyan)}"
          puts "Price: #{shoe.price.colorize(:cyan)}".gsub("+", " ")
          puts "Sizes Available: #{shoe.sizes_available.colorize(:cyan)}"
          puts "Web Link: #{shoe.shoe_href.colorize(:cyan)}"
          puts ''
        end
        puts "////////////////////////////////////////////////////////////////////////////////////////////////////////////////".colorize(:yellow)
        puts "////////////////////////////////////////////////////////////////////////////////////////////////////////////////".colorize(:yellow)
        puts ''
        puts "Here is your cart. Copy these for later. ".colorize(:green)
        puts ''
        go_back
      end
    end
  end 
