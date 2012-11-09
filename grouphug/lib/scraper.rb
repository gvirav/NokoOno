require 'nokogiri'
require 'open-uri'

class GroupHugScraper

  attr_reader :confessions, :user_ids, :labeled_confessions

  def initialize
    @url = "http://web.archive.org/web/20071012214631/http://grouphug.us/page/0/p"
    @page_counter = 0
    @grouphug = nokome(@url)
    @confessions = []
    @user_ids = []
  end

  def nokome(url)
    Nokogiri::HTML(open(url))
  end

  def scrape_and_clean
    10.times do
      scrape_confessions
      scrape_ids
      scrape_next_page
    end
    clean_data(@confessions)
    clean_data(@user_ids)
    to_hash
  end

  def scrape_next_page
     @url = @grouphug.xpath("//*[@id='nav-pages-next']/a").attr('href').value
     @grouphug = nokome(@url)
  end

  def scrape_confessions
    @grouphug.css('td p').each do |parse|
      @confessions << parse.text.strip
    end
  end

  def scrape_ids
    @grouphug.css('h4 a').each do |parse|
      @user_ids << parse.text
    end
  end

  def clean_data(scraped_data)
    scraped_data.each do |element|
      element.strip
    end
  end

  def to_hash
    @user_ids.zip(@confessions)
  end

end