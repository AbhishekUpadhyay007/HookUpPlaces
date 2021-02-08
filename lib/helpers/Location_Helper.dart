const GOOGLE_API_KEY = "AIzaSyCXjEgFCUTt5vsxu1uaGRKsYDkh7VqrYEc";
const BING_API_KEY = "Aokc596TbHO_xjGc-jvPmxnvbnBhqoDHeKi-B418A25BNMMsYf8cxwW6DypbPJvU";

class LocationHelper{

  static String generateLocationPreviewImage({double latitude, double longitude}){
    return "https://dev.virtualearth.net/REST/V1/Imagery/Map/Road/$latitude%2C$longitude/16?mapSize=600,300&format=png&pushpin=$latitude,$longitude;66;A&key=Aokc596TbHO_xjGc-jvPmxnvbnBhqoDHeKi-B418A25BNMMsYf8cxwW6DypbPJvU";
  }

}
