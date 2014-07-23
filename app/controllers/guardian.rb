# [           {
#	              "id":"sport/2012/jul/26/london-2012-gareth-bale-sepp-blatter",
#	            "sectionId":"sport",
#  	          "sectionName":"Sport",
#	        "webPublicationDate":"2012-07-26T10:05:29Z",
#	      "webTitle":"London 2012: Sepp Blatter criticised for Gareth Bale comments",
#            "webUrl":"http://www.guardian.co.uk/sport/2012/jul/26/london-2012-gareth-bale-sepp-blatter",
#          "apiUrl":"http://content.guardianapis.com/sport/2012/jul/26/london-2012-gareth-bale-sepp-blatter"}, ... ]
	
require 'net/http'
require 'uri'

class Guardian
  
  def Guardian.results
        url = "http://beta.content.guardianapis.com/search?q=Tottenham&page-size=#{PAGE_SIZE}&format=json&api-key=" +
         ApplicationController::GUARDIAN_API_KEY

	uri = URI.parse(url)
	res = Net::HTTP.get_response(uri)

	bod = res.body
	json = JSON.parse( bod )
        results = []
	json['response']['results'].each do |result|

 	     title = result['webTitle']
             url =   result['webUrl']
             str = '    <a href="' + url + '">' + title + '</a>' 
             results << str

	end
        results
  end

end


