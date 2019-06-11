# This documentation describes what patterns, architecture and third party code we are using and for what.  

### Navigation
There are two pages in the app, the `CityList` page and the `WeatherDetails` page. The navigation its root view will be the `CityList`. With the city list the user is able to select a city. This will take you to the `WeatherDetails` page with the given city. The navigation will be managed by the `CitiesWeatherInfoFlow`

### Layout
For the details page in the app we will be using a simple `StackLayout`. The `StackLayout` will layout the component on top of each other and will support sticky header and footer. We will need to implement one layout drivers for the screen. The `WeatherDetails` `LayoutDriver`


### UI Component

##### `CityList`
The city list is a simple list that has two sections. One for your location and the other for predefined cities. The your location should be optional. If we cannot retrieve your location it should not be there.

##### `WindInfo`
The wind info component does it the name says it does, it display wind info. The component will show the wind directions and the wind strength.

##### `CloudInfo`
The cloud info will show the cloudiness of the city in percentage. 

### Factories
Every UI Component, will be costructed with a Factory function. Reason being that this simplefies the contruction of these higly modular components. 

### LocationService
We will be building a location service class that you can observe to get the latest location of the user. 

### Models
Models will all be struct we should not be able to change the valuees the source of truth will be the api. 

List of models:
- WeatherInfo
- Weather
- City
- Wind
- Cloud
- Sys

### ApiServices
The are two remote service calls we will need to make, one is to get the weather info, and the other is to get the icon. We will be defining a endpoint protocol that will have an extension to make the service call for the weather info. 

For the image we will be using `sd_webimge` library.

### Third Part Libraries
- ReactiveKit (reactive programming library)
- Quick & Nimble (Unit testing library)
- Alamofire (Networking Library)
- Cocoapods (Dependency Manager)
- Git/Github (Version control)
- SDWebImage (to retrieve images)


