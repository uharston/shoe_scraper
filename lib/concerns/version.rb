# module FreshStart
#   VERSION = "0.1.0"
# end

     # def select_brand #SELECT BRAND - FIND BRAND
      #   puts "Enter a number..."
      #   input = gets.chomp
      #   href = Brands.all[input.to_i - 1].brand_href 
      #   if input == '1'
      #     if Brands.all[input.to_i - 1].editions == nil #if jordans has not been scraped 
      #       scrape_jordan_editions(href, input)
      #       else
      #       display_jordan_editions
      #     end
      #   elsif Brands.all[input.to_i - 1].shoe_collection == nil 
      #     scrape_shoe_collection(href, input)
      #   else  
      #     display_shoe_collection(Brands.all[input.to_i - 1].shoe_collection)
      #   end 
      # end

            # else  
      #   display_shoe_collection(Brands.all[input.to_i - 1].shoe_collection)

          #     href = Brands.all[0].editions[input.to_i - 1][1]
    #     
    #     if Brands.all[0].editions[input.to_i - 1] == nil 
          
    #       scrape_shoe_collection(href, input) 
    #     else
    #       display_shoe_collection(Brands.all[input.to_i - 1].shoe_collection)
    #     end
    #   end
    # end

  # else
  #   href = Brands.all[0].editions[input.to_i - 1][1]
  #   if Brands.all[0].editions[input.to_i - 1] == nil 
  #     scrape_jordan_editions
   
  #   scrape_shoe_collection(href)
  #   end 

  
        # def select_brand
    #   input.gets.chomp 
    #   href = Brands.all[input.to_i - 1].brand_href
    #   Brands.all[input.to_i - 1].brand_name
      
    #   if input == "1" 
    #     scrape_jordan_editions(href)
    #   else
    #     #  if Shoes.all
    #     scrape_shoe_collection(href, brand) 
    #   end
    # end

 






































































    
#       display_shoe_details(shoe_name, profile_href)
#     end 
#   end 

#   #--------------------------------------------------------------------------------------------------------------------------------


#   def display_shoe_details(shoe, href) # DISPLAY SHOE SELECTION 
#   #scrape shoe page 
#     shoe_attr_array = IndexPDX_Scraper.shoe_details(href)
#     shoe = SingleShoe.create_from_collection(shoe_attr_array)

#     puts "Brand: #{shoe.brand}"
#     puts "Condition: #{shoe.condition}"
#     puts "Colorway: #{shoe.colorway}"
#     puts "Year: #{shoe.year}"
#     puts "Product Id: #{shoe.productid}"
#     puts "Sizes Available: #{shoe.sizes_available.join(', ')}"
#     puts "                                                    "
#     puts "I could see this in your collection already!"
#   end 
# #-------------------------------------------------------------------------------------------








































































































































    


#  #require "fresh_start/version"
# #  require_relative "lib\scraper.rb"
# #  require "lib\shoes.rb"
# # require 'pry'

# # # module FreshStart
# # #   class Error < StandardError; end
# # #   # Your code goes here...
# # # end
# CommandLineInterface.new

# Brands.all.each.with_index(1) do |brand_object, index| #retrieves the href of matching shoe brand 
#   
#   if input == index
#     href = brand_object[:brand_href]
#      brand = brand_object[:brand_name]
#   end
# end 

   # def scrape_edition_collections(href, input)
    #   scraper = IndexPDX_Scraper.scrape_brand_index_page_one(href)
    #   Shoes.create_from_collection(scraper)
    #   if Brands.all[input.to_i - 1].editions == nil 
    #     Brands.all[input.to_i - 1].shoe_collection= Shoes.all[0..scraper.size] 
    #     display_shoe_collection(Brands.all[input.to_i - 1].shoe_collection)
    #   else 
    #     Brands.all[0].editions[input.to_i - 1].shoe_collection= Shoes.all[0..scraper.size]
    #     display_shoe_collection(Brands.all[0].editions[input.to_i - 1].shoe_collection)
    #   end 
    # end 

    
      
      #  if Brands.all[0].editions#[input.to_i - 1]
      # 
      #    Brands.all[0].editions[input.to_i - 1].shoe_collection= Shoes.all[0...scraper.size]
      # #   # Brands.all[input.to_i - 1].shoe_collection= Shoes.all[0...scraper.size] 
      #
      #   display_shoe_collection(Brands.all[0].editions[input.to_i - 1].shoe_collection)
      #  else 
    
