
class Brands

    attr_accessor :brand_name, :brand_href, :editions, :edition_href, :shoe_collection 
    
    @@all = []

    # extend Klass 

    def initialize(hash)
       hash.each do |key, value|
        send("#{key}=", value)
       end 
       @@all << self 
    end 

    def self.create_from_collection(array_of_hash) #find or create would be better 
      array_of_hash.each do |hash|
        self.new(hash)
      end 
    end 

    def self.all 
        @@all 
    end 

    


end 

# Shoes.all #=> [
#   {:brand_name => nike, 
#     :brand_href => www.com, 
#     :shoes => [
#       {:shoe_name => "this shoe", :price => "$50"}, 
#       {:shoe_name => "that shoe", :price => "$60"},
#       {:shoe_name => "that shoe", :price => "$60"}
#       {:shoe_name => "that shoe", :price => "$60"}
#       {:shoe_name => "that shoe", :price => "$60"}
#       {:shoe_name => "that shoe", :price => "$60"}
#       {:shoe_name => "that shoe", :price => "$60"}
#       {:shoe_name => "that shoe", :price => "$60"}
#       {:shoe_name => "that shoe", :price => "$60"}
#     ]
        
        
#         {:brand_name => nike, :brand_href => www.com},{:brand_name => nike, :brand_href => www.com},{:brand_name => nike, :brand_href => www.com}, ]