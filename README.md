# Geographic
The app should use local notification if the user enters the region of one of the locations provided in the JSON file within 100 meter, it should trigger the local notification and tell the user: “Welcome to [name of this location]”

# Language

Swift 4.0

# Notification

1- Foreground

![Alt text](https://s9.postimg.org/eqahttu2n/Whats_App_Image_2018-02-11_at_3.14.47_AM_1.jpg?raw=true "Foreground")

2- Background or Terminated

![Alt text](https://s9.postimg.org/4g82ulbwv/Whats_App_Image_2018-02-11_at_3.14.47_AM.jpg?raw=true "Terminated")

3- Tap to open google map navigation

![Alt text](https://s13.postimg.org/xe2x49us7/Whats_App_Image_2018-02-11_at_7.16.36_AM.jpg?raw=true "Terminated")

# Test 

1- By traveling to places ooooh!

2- Don't worry also you can test from your place

a- add .gpx file

![Alt text](https://s13.postimg.org/kiuxhi03b/Screen_Shot_2018-02-11_at_8.40.56_AM.png?raw=true "In Rang")

b- In range (.gpx file)

![Alt text](https://s9.postimg.org/pnbtilw9r/Screen_Shot_2018-02-11_at_1.23.55_AM.png?raw=true "In Rang")

c- Out range (.gpx file)

![Alt text](https://s9.postimg.org/b44oh6vf3/Screen_Shot_2018-02-11_at_1.25.47_AM.png?raw=true "Out Rang")


# UnitTest samples

![Alt text](https://s9.postimg.org/yv41z9t1b/Screen_Shot_2018-02-11_at_1.21.30_AM.png?raw=true "Out Rang")

# UITest Samples

![Alt text](https://s13.postimg.org/etg2jiyif/Screen_Shot_2018-02-13_at_11.02.45_AM.png?raw=true "Out Rang")


# App support english and arabic language

Note: Restart the app recommended by Apple and is implemented in global applications such as Booking and Careem.


1- English

![Alt text](https://s9.postimg.org/a4edliy9r/Whats_App_Image_2018-02-11_at_3.19.03_AM.jpg?raw=true "Terminated")

2- Arabic

![Alt text](https://s9.postimg.org/knedamo27/Whats_App_Image_2018-02-11_at_2.14.42_AM_2.jpg?raw=true "Terminated")


# Challenges

When add small map view on the right side of the cell which shows the real location of the DM location
Note: In large data of locations take map snapshot instead of use GMSMapView


func takeMapSnapshot(latitude: String, longitude: String)  {
        let Width = 100
        let Height = 200
        
        let mapImageUrl = "https://maps.googleapis.com/maps/api/staticmap?center="
        let latlong = "\(latitude), \(longitude)"
        
        let mapUrl  = mapImageUrl + latlong
        
        let size = "&size=" +  "\(Int(Width))" + "x" +  "\(Int(Height))"
        let positionOnMap = "&markers=size:mid|color:red|" + latlong
        let staticImageUrl = mapUrl + size + positionOnMap
        
        APIManager.sharedInstance.downloadImg(imgView: mapSnapshot, with: staticImageUrl, placeholderImage:  placeHolderSnapshot)
    }


