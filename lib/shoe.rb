
class Shoe 

    attr_accessor :shoe_name, :price, :shoe_href, :brand, :condition, :colorway, :year, :productid, :sizes_available
                
     @@all = []

    def initialize(hash)
        hash.each do |key, value|
         send("#{key}=", value)
        end 
        @@all.unshift(self)
    end 
 

    def self.create_from_collection(array_of_hash) 
        array_of_hash.each do |hash|
          self.new(hash)
        end 
      end
      
    def self.all
        @@all 
    end 

    def add_attributes(hash)
        hash.each do |key, value|
            send("#{key}=", value)
        end
    end 


end 