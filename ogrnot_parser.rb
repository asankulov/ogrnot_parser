require 'watir'
require 'nokogiri'
# require 'open-uri'

Selenium::WebDriver::Chrome.driver_path = Dir.pwd + '/lib/browsers/chromedriver'

# username = '1404.01016'
# password = '1'

# browser = Watir::Browser.new :chrome, headless: true, 'disable-gpu': false
# browser.goto('http://ogrnot.manas.edu.kg/')
#
# browser.input(:name => 'frm_kullanici').to_subtype.clear
# browser.input(:name => 'frm_kullanici').send_keys '1404.01016'
# browser.input(:name => 'frm_sifre').to_subtype.clear
# browser.input(:name => 'frm_sifre').send_keys '1'
# browser.input(:value => ' Giriş ').click
# browser.button(:name => 'frm_not').click
#
#
# open('ogrnot.html', 'w') do |f|
# f.puts browser.html
#   end

# browser.button(:name => 'frm_cikis').click

