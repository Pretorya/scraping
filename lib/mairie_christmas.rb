require 'nokogiri'
require 'open-uri'

#initialisation de  l'objet page contenant le code HTML de l'url ciblé
page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))

# scraping du nom des villes et mise en tableau de ces dernières
def cities
    page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))   
    puts "scraping des noms des mairies ..."
    name_cities = page.xpath('//a[@class="lientxt"]')
    puts "Fin duscraping"
    return name_cities
  end
  
  def to_text(name_cities)
    puts "Mise en array des noms ..."
    name_cities_text = []
    name_cities.each do |cities_i|
        name_cities_text << cities_i.text.downcase.gsub(/ /, '-')
    end
    puts "fin de la mise en array"
    return name_cities_text
  end

 #scraping des emails et mise en tableau de ces derniers puis fusion des array en hash
def findmail (name_cities_text)
  begin
    i = name_cities_text.length
    j = 0
    listmail = []
    puts"scraping des emails"
    while i > 0
        page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/95/#{name_cities_text[j]}.html"))
        mail = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
        listmail << mail.text.gsub((/<td>/), '').gsub(/<\/td>/, '')
        i -= 1
        j += 1
    end
    
 
  rescue OpenURI::HTTPError
    listmail << "mail non existant"
  end 

    puts "fin du scraping et de la mise en array"
    puts "fusion des array en hash"
    mail_hash = name_cities_text.zip(listmail).to_h
    puts mail_hash
end

#execution des methodes, point d'entrée du programme
def perform
  findmail(to_text(cities))
end

perform

