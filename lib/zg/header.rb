require 'nokogiri'
require 'open-uri'

class Zg::Header
  attr_accessor :current_city

  def initialize(city)
    @current_city = city
  end

  def header_url_prefix
    current_city == 'tomsk' ? '' : current_city + '.'
  end

  def get_main_page
    get_main_page ||= open("http://#{header_url_prefix}#{(Settings['znaigorod.url']).sub('http://','')}").read
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

  def zg_prefix
    current_city == 'tomsk' ? "http://" : "http://" + current_city + "."
  end

  def entries_to_remove
    ['.search_form', '.dashboard']
  end

  def remove_entries
    entries_to_remove.each do |e|
      parse_header.search(e).remove
    end
  end

  def update_city_selector
    parse_header.at_css('.select_menu ul').children.remove

    (City.all - City.where(:slug => current_city)).each do |city|
      select_option = Nokogiri::XML::Node.new("li", html)
      select_option.parent = parse_header.at_css('.select_menu ul')
      select_link = Nokogiri::XML::Node.new("a", html)
      select_link.set_attribute("href", "#{Settings['app.url']}/#{city.slug}")
      select_link.content = city.title
      select_link.parent = select_option
    end
  end

  def update_urls
    parse_header.search(tags.keys.join(',')).each do |node|
      url_param = tags[node.name]
      src       = node[url_param]
      node[url_param] = zg_prefix + Settings['znaigorod.host']+src unless src.match(/\Ahttp/)
    end
    parse_header
  end

  def render
    remove_entries
    update_city_selector
    update_urls.to_s.html_safe
  end
end
