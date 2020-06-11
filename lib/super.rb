class Super 

    @@all = [] 

    def initialize(hash)
       hash.each do |key, value|
        send("#{key}=", value)
       end 
       @@all << self 
    end 

    def self.create_from_collection(array_of_hash) 
      array_of_hash.each do |hash|
        self.new(hash)
      end 
    end 
    

    def self.all 
        @@all 
    end

end 