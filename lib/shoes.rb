
class Shoes

    attr_accessor :shoe_name, :price, :shoe_href, :brand, :condition, :colorway, :year, :productid, :sizes_available
                 #{:shoe_name=>'blabla', :price=> '$50', :shoe_href=>"www.shoe.com/profile"}
    @@all = []

    def initialize(hash)
        #@all = []

        hash.each_pair do |key, value|
         send("#{key}=", value)
        end 
        #@all << self 
        @@all.unshift(self)
        
     end 
 

    def self.create_from_collection(array_of_hash) #find or create would be better 
        array_of_hash.each do |hash|
          self.new(hash)
        end 
      end 

    def add_attributes(hash)
        hash.each_pair do |key, value|
            send("#{key}=", value)
           end
        end 

    def self.all
        @@all 
    end 


end 