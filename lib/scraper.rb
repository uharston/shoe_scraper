
require 'open-uri'
require 'nokogiri'
 require 'pry'
#URI.open("https://www.indexpdx.com/adidas/?sort=newest&page=1")

class IndexPDX_Scraper

    # #scrape the list of brands => array of hashes - WORKS 
    # def self.brand_list(index_url)
       
    #      doc = Nokogiri::HTML(open(index_url))
    #     
    #     doc.css(".BlockContent .SubCategoryList li").map do |brand|
    #         hash = {}
           
    #         hash[:brand_name] = brand.css("a").first.text
    #         hash[:brand_href] = index_url.gsub("/adidas/", brand.css("a").first['href'])
    #        hash
         
    #     end
    # end 

    def self.brand_list(index_url)
       doc = Nokogiri::HTML(open(index_url))
       doc.css(".BlockContent .SubCategoryList li").map do |brand|
        hash = {}
        hash[:brand_name] = brand.css("a").first.text
        hash[:brand_href] = index_url.gsub("/adidas/", brand.css("a").first['href'])
        unless hash[:brand_name].include?("Jason Markk")
        end
        hash
    end
end 

# def col 
#     [11,12,13,14].map do |b|
#         hash={}
#         hash[:name] = b  
#         unless b == 11
#         end 
#         hash 
#     end
# end 


    def self.scrape_jordans_index_page(index_url)
        doc = Nokogiri::HTML(open(index_url))
        doc.css(".jordans.clearfix a").map do |editions|
            hash = {}
            hash[:name] = editions.css(".jordan-edition p").first.text
            hash[:href] = index_url.gsub("/jordans/", editions.first.last)
            hash
        end 
    end 

    
    #scrape all the shoes available for specific brand => array 
    def self.scrape_brand_index_page_one(index_url) 
        doc = Nokogiri::HTML(open(index_url))
        doc.css(".ProductList li").map do |shoe|
            hash = {}
            hash[:shoe_name] = shoe.css(".ProductDetails a").first.text
            hash[:price] = shoe.css(".ProductPriceRating em").text
            hash[:shoe_href] = shoe.css(".ProductDetails a").first['href']
            hash
        end
    end

    def self.shoe_details(index_url)
        details = Nokogiri::HTML(open(index_url))
        hash = {}
        details.css(".ProductDetailsGrid").each do |detail|
            hash[:shoe_name] = details.css("h1").text 
            hash[:brand] = details.css(".specs span")[0].text 
            hash[:condition] = details.css(".specs span")[1].text 
            hash[:colorway] = details.css(".specs span")[2].text 
            hash[:year] = details.css(".specs span")[3].text 
            hash[:productid] = details.css(".specs span")[4].text 
            hash[:sizes_available] = details.css(".list-horizontal .name").map { |sizes| sizes.text }.join(', ')
        end
        hash
    end


end 









#     #details2 = Nokogiri::HTML(open("https://www.indexpdx.com/pw-human-race-nmd-solar/"))  
#     #page = URI.open("https://www.indexpdx.com/adidas/?sort=newest")
#     # doc = Nokogiri::HTML(open(page))
#      #doc = Nokogiri::HTML(open(https://www.indexpdx.com/adidas/?sort=newest))