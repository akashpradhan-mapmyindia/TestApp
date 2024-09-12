# Documentation

## How to Integrate Mappls SDKs

To integrate Mappls SDK, follow these steps:

1. **Get API Keys**:  
   Go to the [Mappls API Console](https://apis.mappls.com) and retrieve the required API keys.

2. **Install the SDKs**:  
   In your iOS project, use `CocoaPods` to install the necessary SDKs. At a minimum, you need to include `MapplsAPICore` for authentication.  
   Add the following to your `Podfile`:
```
pod 'MapplsAPICore'
```
   Then, run:
```
pod install
```
3. Then, add the keys in the way shown below when the app launches:
```
MapplsAccountManager.setMapSDKKey("")
MapplsAccountManager.setRestAPIKey("")
MapplsAccountManager.setClientId("")
MapplsAccountManager.setClientSecret("")
```

## How does it initialize Mappls SDKs

To initialize Mappls SDKs, we need to
```
MapplsMapAuthenticator.sharedManager().initializeSDKSession { isSucess, error in
    if let error = error {
       print("error:\(error.localizedDescription)")
    }
}
```

## Show custom pop up on click of marker with lat lon

We first add the annotation:
```
let point = MGLPointAnnotation()
point.coordinate = CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918)
point.title = "lat- 28.550834, lon- 77.268918"
mapView.addAnnotation(point)
```

Then we return true frmo this function: 
```
func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool 
```

To show a custom pop up view on the click of a marker we can create our own class which extends `UIView` and `MGLCalloutView`. And return that view from this delegate:
```
func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView?
```

For example: 
```
return CustomCalloutView(representedObject: annotation)
```

## How to show Mappls Map
Show a map is as simple as creating a MapplsMapView object (which is available in the MapplsMap SDK) and adding it to the view, like this: 
```
mapView = MapplsMapView()
view.addSubview(mapView)
mapView.delegate = self
mapView.frame = view.bounds
```

## How to set zoom level and center of Map?
To set a zoom level of, lets say, 15, without animation
```
mapView.setZoomLevel(15, animated: false)
```

## How to set zoom level and center of Map with Animation
```
mapView.setCenter(CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918), zoomLevel: 15, animated: true)
```

## Add a custom marker and when we click on the marker then display an InfoWindow/pop-up.

To show a custom marker we can use this function:
```
func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage?
```
For example:
```
let annotView = MGLAnnotationImage(image: UIImage(named: "custom-loc-icon")!, reuseIdentifier: "annotation\(annotation.title)")
return annotView
```

And to show the InfoWindow/pop up, we need to return true for this function, and the InfoWindow will show the title of the annotation.
```
func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool
```

## Add 50 custom markers and when we click on a particular marker, the marker should be highlighted

We first show the 50 custom markers
```
var markers: [MGLPointAnnotation] = []

self.coordinates.forEach { location in
    let point = MGLPointAnnotation()
    point.coordinate = location
    point.title = "\(location.latitude), \(location.longitude)"
    markers.append(point)
}
mapView.addAnnotations(markers)
mapView.showAnnotations(markers, animated: true)
```
And to show the custom annotation view and highlight the particular one clicked on:
We need to return the custom annotation view from this function
```
func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? 
```

For example, like this 
```
let view = CustomAnnotationView(reuseIdentifier: annotation.title ?? "", image: UIImage(named: "custom-loc-icon")!)
```

Here the custom created class `CustomAnnotationView` extends `MGLAnnotationView`. And this this the logic inside the `CustomAnnotationView` class to highlight it by enlarging the marker.
```
override func setSelected(_ selected: Bool, animated: Bool) {
super.setSelected(selected, animated: animated)
if selected == true
{
    let animation = CABasicAnimation(keyPath: "borderWidth")
    animation.duration = 0.1
    layer.add(animation, forKey: "borderWidth")
    let selectedImg = self.imageView.image
    let myImage = selectedImg?.cgImage
    layer.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
    layer.contents = myImage
    layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    layer.setNeedsLayout()
}
else
{
     let nonSelectedImg = self.imageView.image
     let myImage =   nonSelectedImg?.cgImage
     layer.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
     layer.contents = myImage
     layer.setNeedsLayout()
}
```

## How to plot a polyline on Mappls Map

We can use the `MGLPolyline` class, we can use `MGLPolylineFeature` to add optional attributes and identifiers.
```
var coordinates = [
    CLLocationCoordinate2D(latitude: 28.549400, longitude: 77.268750),
    CLLocationCoordinate2D(latitude: 28.559400, longitude: 77.278750)
]
let polyline = MGLPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
mapView.addAnnotation(polyline)
mapView.showAnnotations([polyline], animated: true)
```

## How to plot a polyline with custom color on Mappls Map

```
var coordinates = [
    CLLocationCoordinate2D(latitude: 28.549400, longitude: 77.268750),
    CLLocationCoordinate2D(latitude: 28.559400, longitude: 77.278750)
]

if let style = mapView.style {
    let sourceFeatures = MGLPolylineFeature(coordinates: &coordinates, count: UInt(coordinates.count))
    let edgePadding = UIEdgeInsets(top: 10, left: 50, bottom: 10, right: 50)
    let camera = mapView.cameraThatFitsCoordinateBounds(sourceFeatures.overlayBounds, edgePadding: edgePadding)
    mapView.setCamera(camera, animated: true)
    
    let sourceOptions: [MGLShapeSourceOption: Any] = [.lineDistanceMetrics: true]
    let source = MGLShapeSource(identifier: "lineSourceIdentifier", shape: sourceFeatures, options: sourceOptions)
    
    style.addSource(source)
    let polylineLayer = MGLLineStyleLayer(identifier: "lineLayerIdentifier", source: source)
    polylineLayer.lineWidth = NSExpression(forConstantValue: 8)
    polylineLayer.lineColor = NSExpression(forConstantValue: UIColor.green)
    style.addLayer(polylineLayer)
}
```

## How to plot a polygon on Mappls Map

Similar to MGLPolyline we can use MGLPolygon for this task
```
var coordinates = [
  CLLocationCoordinate2D(latitude: 28.551334, longitude: 77.268918),
  CLLocationCoordinate2D(latitude: 28.558059, longitude: 77.268890),
  CLLocationCoordinate2D(latitude: 28.555068, longitude: 77.267599),
  CLLocationCoordinate2D(latitude: 28.550068, longitude: 77.267599)
]
let polygon = MGLPolygon(coordinates: &coordinates, count:UInt(coordinates.count))
mapView.addAnnotation(polygon)
mapView.showAnnotations([polygon], animated: true)
```

## How to plot a polygon with custom color? And How to plot a polygon with opacity

Similar to what we did in polyline with custom color:
```
var coordinates = [
    CLLocationCoordinate2D(latitude: 28.551334, longitude: 77.268918),
    CLLocationCoordinate2D(latitude: 28.558059, longitude: 77.268890),
    CLLocationCoordinate2D(latitude: 28.555068, longitude: 77.267599),
    CLLocationCoordinate2D(latitude: 28.550068, longitude: 77.267599)
]
if let style = mapView.style {
    let polygon = MGLPolygonFeature(coordinates: &coordinates, count:UInt(coordinates.count))
    
    let source = MGLShapeSource(identifier: "identifier", shape: polygon, options: nil)
    style.addSource(source)
    
    let polygonLayer = MGLFillStyleLayer(identifier: "layerIdentifier", source: source)
    polygonLayer.fillColor = NSExpression(forConstantValue: UIColor.green)
    polygonLayer.fillOpacity = NSExpression(forConstantValue: 0.5)
    polygonLayer.fillOutlineColor = NSExpression(forConstantValue: UIColor.brown)
    
    style.addLayer(polygonLayer)
    
    let shapeCam = mapView.cameraThatFitsShape(polygon, direction: CLLocationDirection(0), edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    mapView.setCamera(shapeCam, animated: false)
}
```

## How to get human readable address information at a location/coordinate

To get the place details and other information like formated address, we can use `MapplsReverseGeocodeManager`.
```
let coordinate = CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918)

let geocodeMagager = MapplsReverseGeocodeManager.shared

let revOptions = MapplsReverseGeocodeOptions(coordinate: coordinate)

geocodeMagager.reverseGeocode(revOptions, completionHandler: { placemarks, attribution, error in
    
    if let error = error {
       //handle error here
    }else if let placemarks = placemarks {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(placemarks)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let dictionary = json as? [[String : Any]] {
                if let dict = dictionary.first {
                    addresslbl.text = dict["formatted_address"] as? String ?? ""
                }
            }
        } catch {
           //handle error here
        }
    }
})
```

## How to get details of a place by its name

Add a search input box, and when the input box is clicked, open the search widget.
When you search for a place, it should display a marker on that location.

To do this we can use the `MapplsAutocompleteViewController`.
```
let autocompleteController = MapplsAutocompleteViewController(theme: .auto)
autocompleteController.delegate = self

let filter = MapplsAutocompleteFilter()

autocompleteController.autocompleteFilter = filter
present(autocompleteController, animated: true, completion: nil)
```

And then in the `MapplsAutocompleteViewControllerDelegate` we get a callback when a place is selected in this delegate: 
```
func didAutocomplete(viewController: MapplsUIWidgets.MapplsAutocompleteViewController, withPlace place: MapplsAPIKit.MapplsAtlasSuggestion, resultType type: MapplsAutosuggestResultType)
```

Now we can use the place picked to, for example, add annotation:
```
let point = MapplsPointAnnotation(mapplsPin: place.mapplsPin ?? "")
mapView.addMapplsAnnotation(point) { isSuccess, error in
    self.mapView.showMapplsPins([place.mapplsPin ?? ""], animated: true)
}
```

## How to get road distance between two locations

To get the road distance between two places we can use the Directions API.
```
let origin = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 22.5744, longitude: 88.3629))
let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918))
origin.allowsArrivingOnOppositeSide = false
destination.allowsArrivingOnOppositeSide = false

let options = RouteOptions(waypoints: [origin, destination])
options.routeShapeResolution = .full
options.includesAlternativeRoutes = true
Directions(restKey: MapplsAccountManager.restAPIKey()).calculate(options) { (waypoints, routes, error) in
    if let _ = error {
       //handle error here
    }else if let routes = routes, routes.count > 0 {
        distanceLbl.text = "Road distance between Kolkata and Delhi: \(routes.first?.distance ?? 0.0)m"

        //now you can do other things like adding a polyline
        let firstRoute = routes[0]
        if let routeCoord = firstRoute.coordinates {
            let polyline = MGLPolyline(coordinates: routeCoord, count: UInt(routeCoord.count))
            vc.mapView.addAnnotation(polyline)
            vc.mapView.showAnnotations([polyline], edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
        }
    }
}
```

## How to get nearby places from a location of some specific category

To get the nearby places info for a specific category we can use the `MapplsNearByManager`.
```
let nearByManager = MapplsNearByManager.shared
let filter = MapplsNearbyKeyValueFilter(filterKey: "brandId", filterValues: ["String","String"])
let sortBy = MapplsSortByDistanceWithOrder(orderBy: .ascending)
let nearByOptions = MapplsNearbyAtlasOptions(query: "Restaurants", location: "22.5744,88.3629")
nearByOptions.sortBy = sortBy
nearByOptions.searchBy = .distance

nearByManager.getNearBySuggestions(nearByOptions) { (suggestions, error) in
    if let error = error {
      //handle error here
    }else if let suggestions = suggestions?.suggestions, !suggestions.isEmpty {
      // now with the nearby places info we can do things such as adding point annotations.
      var annotations: [MapplsPointAnnotation] = []
      for i in 0..<suggestions.count {
          let point = MapplsPointAnnotation(mapplsPin: suggestions[i].mapplsPin ?? "")
          point.title = "nearByAnnotations"
          annotations.append(point)
      }
      vc.mapView.addMapplsAnnotations(annotations) { isSuccess, error in
          vc.mapView.showMapplsPins(suggestions.map { $0.mapplsPin ?? ""} , animated: true)
      }
   }
}
```

## How to get an image of a map with markers

To get the image of a map at a particular lat lon and with markers we can use Still Map Image API. 
Here is an example, how to do it in swift ios.           
```
var urlComponents = URLComponents(string: "https://apis.mappls.com/advancedmaps/v1/insert-you-rest-api-key-here/still_image")

let queryItems = [
    URLQueryItem(name: "center", value: "28.550834,77.268918"),
    URLQueryItem(name: "zoom", value: "13"),
    URLQueryItem(name: "size", value: "400x400"),
    URLQueryItem(name: "ssf", value: "1"),
    URLQueryItem(name: "markers", value: "28.550834,77.268918"),
    URLQueryItem(name: "markers_icon", value: "https://cdn0.iconfinder.com/data/icons/essentials-solid-glyphs-vol-1/100/Location-Pin-Map-80.png")
]

urlComponents?.queryItems = queryItems

let url = urlComponents?.url

if let url = url {
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
                
    NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
        guard let data = data else { return }
        if let image = UIImage(data: data) {
            let imageView = UIImageView(image: image)
           // now you can do various things with the image data 
            return
        } else {
            //handle error here
        }
    }
}
```

Here:

`ssf` - scale factor indicating retina or non-retina

`center`- center coordinate of the map 

`zoom` - zoom level of the map to be rendered

`size`- size of the map

`markers`- markers we want to add to the map 

`markers_icon`- the icon that the markers needs to have
