require "./scrapper"

describe "scrapper" do 

  before(:each) do
    # use @doc in your tests to avoid hitting the
    #   craigslist url, which would be slow and 
    #   problematic if you were blocked
    @doc = Nokogiri::HTML(open("today.html"))
    @today = "Aug 12"
  end

  describe "filter_links" do
    arr = []
    it "should return the correct number of rows" do
      rows = @doc.css(".row")
      rows.each do |row|
        # puts row.content
        arr.push(row)
      end
      expect(arr.length).to eql(100)
    end

    it "should return the correct number of filtered dog rows" do
      # rowsString is contains one valid row
      newArr = []
      arr.each do |row|
        if row.text.match(/(dog)|(Dog)/) != nil
          newArr.push(row)
        end
       end
      expect(newArr.length).to eql(48)
    end
  end
end