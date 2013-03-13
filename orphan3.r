require(XML); require(RCurl); require(RJSONIO)

getForm(url = "http://api.giscloud.com/1/maps/1",
        .params = list(),
        curl = getCurlHandle())

temp <- getURL("https://api.giscloud.com/1/maps/4623?api_key=b3d6ae2e1f321dd9f099b7cb5da05ae3")
temp <- getURL("https://api.giscloud.com/1/maps/4623/render.png?width=64&height=64?api_key=b3d6ae2e1f321dd9f099b7cb5da05ae3")
temp <- getForm("https://api.giscloud.com/1/maps/4623/render.png",
                .params = list(width = 64,
                               height = 64,
                               api_key = "b3d6ae2e1f321dd9f099b7cb5da05ae3")
                )
readPNG("http://api.giscloud.com/1/maps/4623/render.jpg?width=64&height=64")
read.jpeg("http://api.giscloud.com/1/maps/4623/render.jpg?width=64&height=64")

temp <- getURL("http://api.giscloud.com/1/maps/4623.json")
xmlParse(temp)
fromJSON(temp)