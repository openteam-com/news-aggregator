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
    @parse_header ||= html.css('.header_wrapper')
  end

  def tags
    {
      'a'      => 'href',
      'form'   => 'action'
    }
  end

  def entries_to_remove
    ['.search_form', '.dashboard']
  end

  def remove_entries
    parse_header.search(entries_to_remove).remove
  end

  def update_urls
    parse_header.search(tags.keys.join(',')).each do |node|
      url_param = tags[node.name]
      src       = node[url_param]
      node[url_param] = Settings['znaigorod.url']+src unless src.match(/\Ahttp/)
    end
    parse_header
  end

  def render
    remove_entries
    update_urls.to_s.html_safe
  end
end
