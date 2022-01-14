class EpaLinksSpider < Kimurai::Base
  @name = 'epa_links_spider'
  @engine = :selenium_chrome

  def self.process(url)
    puts url
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    response.css("//div[@class='product photo product-item-photo']").each do |product_photo|
      product_link = product_photo.next_element.text.strip
      l = product_photo.css('a').map { |link| link['href'] }
      response = EpaProductsSpider.process(l.to_s.delete('["]'))
    end
  end
end