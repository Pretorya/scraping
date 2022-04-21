require 'nokogiri'
require 'open-uri'

#initialisation de  l'objet page contenant le code HTML de l'url ciblé
page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))

$crypto_name = page.xpath('/html/body/div[1]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[*]/td[3]/div') 

$crypto_flux = page.xpath('/html/body/div[1]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[*]/td[5]/div/a/span')
 
# déclaration de 2 arrays vides
$crypto_name_array = []
$crypto_flux_array = []

# stockage du text du code scrapé dans les arrays déclarés préalablement
def stock
  $crypto_name.each do |crypto_n|
    $crypto_name_array << crypto_n.text
  end
  puts "noms en array"

  $crypto_flux.each do |crypto_f|
    $crypto_flux_array << crypto_f.text
  end
  puts "cours en array"
end
# création d'un hash à l'aide des 2 arrays
def zipping
    puts "début du zip des array"
    crypto_hash = $crypto_name_array.zip($crypto_flux_array).to_h
    puts "fin du zip des array"
    puts crypto_hash
end
# éxecution des méthodes, point d'entrée du programme
def perform
    stock
    zipping
end

perform


