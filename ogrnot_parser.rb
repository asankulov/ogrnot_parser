require 'watir'
require 'nokogiri'
require 'open-uri'

class OgrnotHtml

  def parser
    url = 'ogrnot.html'
    html = open(url)
    doc = Nokogiri::HTML(html, nil, 'utf-8')

    courses = []
    grades = []
    result = []
    keys = {}
    final = {}

    doc.css('div.hucre > table > tbody > tr').each do |tr|
      tr.css('.bgc20').each do |course|
        courses << course.text
      end
      tr.css('.bgc11').each do |grade|
        grades << grade.text
      end
    end

    courses = courses.compact.reverse!
    courses.clone.uniq.each do |x|
      keys[x] = []
    end
    grades = grades.compact
    grades = grades.each_slice(3).to_a
    grades.each do |x|
      result << [courses.pop, x[0], x[1]]
    end
    keys.each_pair do |key, value|
      result.each do |x|
        if key == x[0]
          final[key] = value << x[1..-1].join(': ')
        end
      end
    end
    final
  end

  def save_html(username, password)

    Selenium::WebDriver::Chrome.driver_path = Dir.pwd + '/lib/browsers/chromedriver'

    browser = Watir::Browser.new :chrome, headless: true, disable_gpu: false
    browser.goto('http://ogrnot.manas.edu.kg/')


    browser.input(:name => 'frm_kullanici').to_subtype.clear
    browser.input(:name => 'frm_kullanici').send_keys username
    browser.input(:name => 'frm_sifre').to_subtype.clear
    browser.input(:name => 'frm_sifre').send_keys password
    browser.input(:value => ' Giriş ').click
    browser.button(:name => 'frm_not').click

    open('ogrnot.html', 'w') do |f|
      f.puts browser.html
    end
    browser.button(:name => 'frm_cikis').click
  end
end