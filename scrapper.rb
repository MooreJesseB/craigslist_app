# scrapper.rb
require 'nokogiri'
require 'open-uri'
require 'awesome_print'

def filter_links(rows, regex)
  arr = []
  rows.each do |item|
    if item.css("a").text.match(/#{regex}/) != nil && item.text.match(/(house)|(item)|(boots)|(rescue)/) == nil
      if item.css(".p") != nil
        arr.push(item)
      end
    end
  end
  return arr
end

def get_todays_rows(doc, date_str)
  arr = []
  doc.css(".row").each do |item|
    # puts item
    if item.text.match(/(#{date_str})/) != nil && item.text.match(/(house)|(item)|(boots)|(rescue)|/) != nil
      arr.push(item) 
    end
  end
  return arr
end

def get_page_results
  url = "http://sfbay.craigslist.org/sfc/pet/"
  Nokogiri::HTML(open(url))
end

def search(date_str)
  page = get_page_results
  arr = get_todays_rows(page, date_str)
  arr = filter_links(arr, "(puppy)|(Puppy)|(puppies)|(Puppies)|(dog)|(Dog)|(pup)|(Pup)")
  arr.each do |item|
    ap item.css("a").text
    ap item.css("a")[0]["href"]
    ap "*"*60
    
  end
  ap arr.length
end

# want to learn more about 
# Time in ruby??
#   http://www.ruby-doc.org/stdlib-1.9.3/libdoc/date/rdoc/Date.html#strftime-method
today = Time.now.strftime("%b %d")
search(today)