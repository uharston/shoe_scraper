class CommandLineInterface

  BASE_PATH = "https://www.indexpdx.com/adidas/"

  @@saved = []
  
  def run
    first_selection 
  end

  def first_selection 
    puts ''
    puts "Welcome to the Sneaky Sneaker Finder! Are you ready to find your next pair of kicks?".colorize(:green)
    puts ''
    puts "Type 'y' or any other key to exit"
    
      input = gets.chomp.downcase
      binding.pry 
      if input == 'y'
        # Saved_shoes.new 
        puts ''
        puts "Great!! Let's get you started with our list of brands".colorize(:green)
        puts ''
        scrape_brands
      else 
        puts "Goodbye!".colorize(:green)
      end 
    end
    
    def scrape_brands 
      Brands.create_from_collection(IndexPDX_Scraper.brand_list(BASE_PATH)) 
      display_brands
    end
    
    def display_brands
      Brands.all.each.with_index(1) { |shoe_object, index| puts "#{index}. #{shoe_object.brand_name.colorize(:light_cyan)}"}
      puts ""
      puts "Alot to choose from! Let me know which one you want to see more of!".colorize(:green)
      puts ""
      select_brand
    end
    
    def select_brand #SELECT BRAND - FIND BRAND
      puts "Enter a number..."
      input = gets.chomp
      # if input.to_i == 0 or use if input.to_i.between?(1, array.size)
      href = Brands.all[input.to_i - 1].brand_href 
      if input == '1'
        if Brands.all[input.to_i - 1].editions == nil
          scrape_jordan_editions(href, input)
        else
          display_jordan_editions
        end
      elsif Brands.all[input.to_i - 1].shoe_collection == nil
        scrape_shoe_collection(href, input)
      else
        display_shoe_collection(Brands.all[input.to_i - 1].shoe_collection)
      end 
    end
    
    #---------------------------------------------------------------------------

    def scrape_shoe_collection(href, input)
      scraper = IndexPDX_Scraper.scrape_brand_index_page_one(href)
      Shoes.create_from_collection(scraper)
        Brands.all[input.to_i - 1].shoe_collection= Shoes.all[0...scraper.size]
        display_shoe_collection(Brands.all[input.to_i - 1].shoe_collection)
      end 

    def display_shoe_collection(brand)
      puts ''
      brand.each.with_index(1) do |shoe_obj, index|
        puts "#{index}. Model: #{shoe_obj.shoe_name.colorize(:light_cyan)} Price: #{shoe_obj.price.colorize(:light_cyan)}"
        puts ""
      end
      select_shoe_collection
    end 

    def scrape_edition_collection(href, input)
      scraper = IndexPDX_Scraper.scrape_brand_index_page_one(href)
      Shoes.create_from_collection(scraper)
      Brands.all[0].editions[input.to_i - 1].shoe_collection= Shoes.all[0...scraper.size]
      display_shoe_collection(Brands.all[0].editions[input.to_i - 1].shoe_collection)
    end
    
    def select_shoe_collection 
      puts "Gotta love some fresh kicks!! Pick a shoe and I can show you more info.".colorize(:green) 
      puts ""
      puts "Type a number or 'b' for back"
      input = gets.chomp.downcase
      if input == "b"
        display_brands
      else
        puts "Good Choice!".colorize(:green)
        puts ''
        scrape_shoe(input)
      end 
    end
    
    def scrape_jordan_editions(href, input) 
      Jordan_Edition.create_from_collection(IndexPDX_Scraper.scrape_jordans_index_page(href))
      Brands.all[input.to_i - 1].editions= Jordan_Edition.all 
      display_jordan_editions
    end
      
    def display_jordan_editions
      puts ''
      Jordan_Edition.all.each.with_index(1) { |edition, index| puts "#{index}." +  "Jordan #{edition.name}".colorize(:light_cyan)}
      #   Brands.all.first.editions.each.with_index(1) do |edition, index|
      #  # #Brands.all[input.to_i - 1].editions.each.with_index(1) do |edition, index|
      #     puts "#{index}. Jordan #{edition.name.colorize(:light_cyan)}"
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
      href = Brands.all[0].editions[input.to_i - 1].href
      if input == "b"
        display_brands
      elsif Brands.all[0].editions[input.to_i - 1].shoe_collection == nil
        scrape_edition_collection(href, input)
        #scrape_shoe_collection(href, input)
      else 
        display_shoe_collection(Brands.all[0].editions[input.to_i - 1].shoe_collection)
      end 
    end
    
    def scrape_shoe(input)
      Shoes.all[input.to_i - 1].add_attributes(IndexPDX_Scraper.shoe_details(Shoes.all[input.to_i - 1].shoe_href)) 
      display_shoe(input)
    end
    
    def display_shoe(input)
      puts "Brand: #{Shoes.all[input.to_i - 1].brand.colorize(:light_cyan)}"
      puts "Name: #{Shoes.all[input.to_i - 1].shoe_name.colorize(:light_cyan)}"
      puts "Colorway: #{Shoes.all[input.to_i - 1].colorway.colorize(:light_cyan)}"
      puts "Condition: #{Shoes.all[input.to_i - 1].condition.colorize(:light_cyan)}"
      puts "Year: #{Shoes.all[input.to_i - 1].year.colorize(:light_cyan)}"
      puts "Price: #{Shoes.all[input.to_i - 1].price.colorize(:light_cyan)}"
      puts "Sizes Available: #{Shoes.all[input.to_i - 1].sizes_available.colorize(:light_cyan)}"
      save(input)
    end
    
    def save(input)
      puts ''
      puts "Would you like to save this shoe?".colorize(:yellow)
      choice = gets.chomp.downcase
      if choice == 'y'
        @@saved << Shoes.all[input.to_i - 1]
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
        display_brands
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
          puts "Brand: #{shoe.brand.colorize(:light_cyan)}"
          puts "Name: #{shoe.shoe_name.colorize(:light_cyan)}"
          puts "Colorway: #{shoe.colorway.colorize(:light_cyan)}"
          puts "Condition: #{shoe.condition.colorize(:light_cyan)}"
          puts "Year: #{shoe.year.colorize(:light_cyan)}"
          puts "Price: #{shoe.price.colorize(:light_cyan)}"
          puts "Sizes Available: #{shoe.sizes_available.colorize(:light_cyan)}"
          puts "Web Link: #{shoe.shoe_href.colorize(:light_cyan)}"
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
