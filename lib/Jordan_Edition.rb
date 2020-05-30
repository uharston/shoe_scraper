class Jordan_Edition

    attr_accessor :name, :href, :shoe_collection 

    @@all = [] 

    def initialize(hash)
      hash.each_pair do |key, value|
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