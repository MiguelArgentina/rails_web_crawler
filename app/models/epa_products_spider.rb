class EpaProductsSpider < Kimurai::Base
  @name = 'epa_propducts_spider'
  @engine = :selenium_chrome

  def self.process(url)
    puts url
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    counter = 0
    item = {}
    item['name'] = response.css("h1.page-title").children.first.text.strip
    item['price'] = response.css("span.precio").text
    item['epa_code'] = response.at('span:contains("Código EPA:")').next_element.text.strip
    response.xpath("//div[@class='table-responsive col-sm-6']").each do |product_data|
      product_data.css('table tbody tr').each do |item_data|
        id = item_data.at_css('td:nth-child(1)').content
        name = item_data.at_css('td:nth-child(2)').content
        item[id] = name
      end
      EpaProduct.where(epa_code: item['epa_code']).first_or_create.update(
        name: item['name'],
        epa_code: item['epa_code'],
        price: item['price'].gsub(/[\s,.]/,""),
        product_info: item
      )
    end
  end
end