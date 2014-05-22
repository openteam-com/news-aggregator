require 'nokogiri'
require 'open-uri'

class Zg::Header
  def get_main_page
    get_main_page ||= open(Settings['znaigorod.url']).read
  end

  def html
    @html ||= Nokogiri::HTML(get_main_page)
  end

  def parse_header
    html.css('.new_feature, .header_wrapper')
  end

  def tags
    {
      'a'      => 'href',
      'form'   => 'action'
    }
  end

  def update_urls
    parse_header.search(tags.keys.join(',')).each do |node|
      url_param = tags[node.name]
      src       = node[url_param]
      node[url_param] = Settings['znaigorod.url']+src
    end
    parse_header
  end

  def render
    update_urls.to_s.html_safe
  end
end
