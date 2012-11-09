require_relative 'scraper'
require_relative '../app/models/confession'
require_relative '../app/models/user'
module GroupHugImporter

  def self.import
    Confession.transaction do
      myscraper = GroupHugScraper.new
      myscraper.scrape_and_clean.each do |element|
        u = User.create!()
        u.confessions.create!({:post_id => element[0], :text => element[1]})
      end
    end
  end

end