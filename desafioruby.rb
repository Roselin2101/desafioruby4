#Crear el método request que reciba una url y retorne el hash con los resultados.

require "uri"
require "net/http"
require 'json'

# "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=dxC7cC1zC7LsXbWlLUEDlBnX9boCxNNam3xbDOzL"

def request(url_requested)

url = URI(url_requested)

https = Net::HTTP.new(url.host, url.port)

https.use_ssl = true

request = Net::HTTP::Get.new(url)

request["cache-control"] = 'no-cache'

request["postman-token"] = 'dxC7cC1zC7LsXbWlLUEDlBnX9boCxNNam3xbDOzL'

response = https.request(request)

results =  JSON.parse(response.body)

end

#Crear un método llamado buid_web_page que reciba el hash de respuesta con todos los datos y construya una página web. Se evaluará la página creada y tiene que tener este formato: 

#<html>
# <head>
# </head>
# <body>
# <ul>
# <li><img src='.../398380645PRCLF0030000CC AM04010L1.PNG'></li>
# <li><img src='.../398381687EDR_F0030000CCAM05010M_.JPG'></li>
# </ul>
# </body>
# </html>

data = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=dxC7cC1zC7LsXbWlLUEDlBnX9boCxNNam3xbDOzL")

def buid_web_page(data)
    
imagens = data['photos'].map{|
argumento| argumento['img_src']}
html ="<html>\n<head>\n</head>\n<body>\<ul>\n"

imagens.each do |imagen|
    html += "\t<li> <img src=\"#{imagen}\" width=400px height=400px > </li>\n"
end

html += "\n</ul>\n</body>\n</html>"
    
    File.write('index.html', html)
end

buid_web_page(data)


# Crear un método photos_count que reciba el hash de respuesta y devuelva un nuevo
# hash con el nombre de la cámara y la cantidad de fotos.

def photos_count(data)
    fotografia = data['photos'].map{|argumento| argumento['camera']['name']}.group_by {|argumento| argumento}.map{|k,v|  [k, v.count]}
   
end 

puts (photos_count(data))
# puts response.read_body
