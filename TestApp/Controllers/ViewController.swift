//
//  ViewController.swift
//  TestApp
//
//  Created by rento on 05/09/24.
//

import UIKit
import MapplsMap
import MapplsAPIKit
import MapplsAPICore
import MapplsUIWidgets

class ViewController: UIViewController {
    var tableView: UITableView!
    var tblData: [SectionInfo] = []
    
    let indianPlaces: [String: (Double, Double)] = [
        "Delhi": (28.6139, 77.2090),
        "Mumbai": (19.0760, 72.8777),
        "Bangalore": (12.9716, 77.5946),
        "Kolkata": (22.5726, 88.3639),
        "Chennai": (13.0827, 80.2707),
        "Hyderabad": (17.3850, 78.4867),
        "Ahmedabad": (23.0225, 72.5714),
        "Pune": (18.5204, 73.8567),
        "Jaipur": (26.9124, 75.7873),
        "Lucknow": (26.8467, 80.9462),
        "Kanpur": (26.4499, 80.3319),
        "Nagpur": (21.1458, 79.0882),
        "Indore": (22.7196, 75.8577),
        "Bhopal": (23.2599, 77.4126),
        "Patna": (25.5941, 85.1376),
        "Vadodara": (22.3072, 73.1812),
        "Ludhiana": (30.9010, 75.8573),
        "Agra": (27.1767, 78.0081),
        "Nashik": (19.9975, 73.7898),
        "Faridabad": (28.4089, 77.3178),
        "Meerut": (28.9845, 77.7064),
        "Rajkot": (22.3039, 70.8022),
        "Varanasi": (25.3176, 82.9739),
        "Srinagar": (34.0837, 74.7973),
        "Aurangabad": (19.8762, 75.3433),
        "Dhanbad": (23.7957, 86.4304),
        "Amritsar": (31.6340, 74.8723),
        "Jodhpur": (26.2389, 73.0243),
        "Raipur": (21.2514, 81.6296),
        "Kota": (25.2138, 75.8648),
        "Guwahati": (26.1445, 91.7362),
        "Chandigarh": (30.7333, 76.7794),
        "Mysore": (12.2958, 76.6394),
        "Ranchi": (23.3441, 85.3096),
        "Dehradun": (30.3165, 78.0322),
        "Gwalior": (26.2183, 78.1828),
        "Vijayawada": (16.5062, 80.6480),
        "Jalandhar": (31.3260, 75.5762),
        "Madurai": (9.9252, 78.1198),
        "Tiruchirappalli": (10.7905, 78.7047),
        "Udaipur": (24.5854, 73.7125),
        "Salem": (11.6643, 78.1460),
        "Ajmer": (26.4499, 74.6399),
        "Guntur": (16.3067, 80.4365),
        "Solapur": (17.6599, 75.9064),
        "Thiruvananthapuram": (8.5241, 76.9366),
        "Warangal": (17.9784, 79.6010),
        "Hubli": (15.3647, 75.1240),
        "Shimla": (31.1048, 77.1734)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTblData()
        setUpUI()
    }
    
    func setUpTblData() {
        var sec1 = SectionInfo(sectionTitle: "Section 1", cellInfo: [])
        let showPopUpCell = HomeItemCellData(name: Constants.SectionOne.showPopUpOnClick)
        sec1.cellInfo.append(showPopUpCell)
        
        tblData.append(sec1)
        
        var sec2 = SectionInfo(sectionTitle: "Section 2", cellInfo: [])
        let showMapCell = HomeItemCellData(name: Constants.SectionTwo.showMap)
        let zoomCell = HomeItemCellData(name: Constants.SectionTwo.zoomLevelSet)
        let zoomCell2 = HomeItemCellData(name: Constants.SectionTwo.zoomLevelAndCenterWithAnimation)
        let customMarkerPopupCell = HomeItemCellData(name: Constants.SectionTwo.customMarkerPopupWithInfoWindow)
        let fiftyMarkerCell = HomeItemCellData(name: Constants.SectionTwo.fiftyMarker)
        let polylineCell = HomeItemCellData(name: Constants.SectionTwo.polyline)
        let polylineWithColor = HomeItemCellData(name: Constants.SectionTwo.polylineWithColor)
        let polygonCell = HomeItemCellData(name: Constants.SectionTwo.polygon)
        let polygonCustomColorOpacity = HomeItemCellData(name: Constants.SectionTwo.polygonCustomColorOpacity)
        sec2.cellInfo.append(showMapCell)
        sec2.cellInfo.append(zoomCell)
        sec2.cellInfo.append(zoomCell2)
        sec2.cellInfo.append(customMarkerPopupCell)
        sec2.cellInfo.append(fiftyMarkerCell)
        sec2.cellInfo.append(polylineCell)
        sec2.cellInfo.append(polylineWithColor)
        sec2.cellInfo.append(polygonCell)
        sec2.cellInfo.append(polygonCustomColorOpacity)

        tblData.append(sec2)

        let sec3 = SectionInfo(sectionTitle: "Section 3", cellInfo: [
            HomeItemCellData(name: Constants.SectionThree.reverseGeocode), HomeItemCellData(name: Constants.SectionThree.placeDetailsBoxWithSearchedLocMarker), HomeItemCellData(name: Constants.SectionThree.roadDistance), HomeItemCellData(name: Constants.SectionThree.specificCategoryNearby), HomeItemCellData(name: Constants.SectionThree.imageOfMap)
        ])
        
        tblData.append(sec3)
    }
    
    func setUpUI() {
        view.backgroundColor = .white
        navigationItem.title = "Home View"
        
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.register(HomeItemViewCell.self, forCellReuseIdentifier: HomeItemViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeItemViewCell.identifier) as? HomeItemViewCell else {return UITableViewCell()}
        cell.titleLbl.text = tblData[indexPath.section].cellInfo[indexPath.row].name
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerv = HomeSectionHeaderView(title: tblData[section].sectionTitle)
        return headerv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tblData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tblData[section].cellInfo.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = tblData[indexPath.section].cellInfo[indexPath.row].name
        let vc = CommonMapViewController(title: title)

        switch title {
        case Constants.SectionOne.showPopUpOnClick:
            vc.funcToRunOnMapRender = {
                vc.annotationCanShowCallout = true
                vc.showCustomCallout = true
                let point = MGLPointAnnotation()
                point.coordinate = CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918)
                point.title = "Mapmyindia HO, New Delhi"
                
                vc.mapView.addAnnotation(point)
            }
            
            break
        case Constants.SectionTwo.showMap:
            
            break
        case Constants.SectionTwo.zoomLevelSet:
            vc.funcToRunOnMapRender = {
                vc.mapView.setZoomLevel(15, animated: false)
            }
            break
        case Constants.SectionTwo.zoomLevelAndCenterWithAnimation:
            vc.funcToRunOnMapRender = {
                vc.mapView.setCenter(CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918), zoomLevel: 15, animated: true)
            }
            break
        case Constants.SectionTwo.customMarkerPopupWithInfoWindow:
            vc.annotationCanShowCallout = true
            vc.showCustomMarker = true
            vc.funcToRunOnMapRender = {
                let point = MGLPointAnnotation()
                point.coordinate = CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918)
                point.title = "Mapmyindia HO, New Delhi"
                
                vc.mapView.addAnnotation(point)
            }
            break
        case Constants.SectionTwo.fiftyMarker:
            vc.funcToRunOnMapRender = {
                var markers: [MGLPointAnnotation] = []
                vc.annotationCanShowCallout = true
                vc.showCustomMarkerView = true
                
                self.indianPlaces.forEach { (key: String, value: (Double, Double)) in
                    let point = MGLPointAnnotation()
                    point.coordinate = CLLocationCoordinate2D(latitude: value.0, longitude: value.1)
                    point.title = key
                    markers.append(point)
                }
                vc.mapView.addAnnotations(markers)
                vc.mapView.showAnnotations(markers, animated: true)
            }
            break
        case Constants.SectionTwo.polyline:
            vc.funcToRunOnMapRender = {
                var coordinates = [
                    CLLocationCoordinate2D(latitude: 28.549400, longitude: 77.268750),
                    CLLocationCoordinate2D(latitude: 28.559400, longitude: 77.278750)
                ]
                let polyline = MGLPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
                vc.mapView.addAnnotation(polyline)
                vc.mapView.showAnnotations([polyline], animated: true)
            }
            break
        case Constants.SectionTwo.polylineWithColor:
            vc.funcToRunOnMapRender = {
                var coordinates = [
                    CLLocationCoordinate2D(latitude: 28.549400, longitude: 77.268750),
                    CLLocationCoordinate2D(latitude: 28.559400, longitude: 77.278750)
                ]
                
                if let style = vc.mapView.style {
                    let sourceFeatures = MGLPolylineFeature(coordinates: &coordinates, count: UInt(coordinates.count))
                    let edgePadding = UIEdgeInsets(top: 10, left: 50, bottom: 10, right: 50)
                    let camera = vc.mapView.cameraThatFitsCoordinateBounds(sourceFeatures.overlayBounds, edgePadding: edgePadding)
                    vc.mapView.setCamera(camera, animated: true)
                    
                    let sourceOptions: [MGLShapeSourceOption: Any] = [.lineDistanceMetrics: true]
                    let source = MGLShapeSource(identifier: "lineSourceIdentifier", shape: sourceFeatures, options: sourceOptions)
                    
                    style.addSource(source)
                    let polylineLayer = MGLLineStyleLayer(identifier: "lineLayerIdentifier", source: source)
                    polylineLayer.lineWidth = NSExpression(forConstantValue: 8)
                    polylineLayer.lineColor = NSExpression(forConstantValue: UIColor.green)
                    style.addLayer(polylineLayer)
                }
            }
            break
        case Constants.SectionTwo.polygon:
            vc.funcToRunOnMapRender = {
                var coordinates = [
                CLLocationCoordinate2D(latitude: 28.551334, longitude: 77.268918),
                CLLocationCoordinate2D(latitude: 28.558059, longitude: 77.268890),
                CLLocationCoordinate2D(latitude: 28.555068, longitude: 77.267599),
                CLLocationCoordinate2D(latitude: 28.550068, longitude: 77.267599)
                ]
                let polygon = MGLPolygon(coordinates: &coordinates, count:UInt(coordinates.count))
                vc.mapView.addAnnotation(polygon)
                vc.mapView.showAnnotations([polygon], animated: true)
            }
            break
        case Constants.SectionTwo.polygonCustomColorOpacity:
            vc.funcToRunOnMapRender = {
                var coordinates = [
                    CLLocationCoordinate2D(latitude: 28.551334, longitude: 77.268918),
                    CLLocationCoordinate2D(latitude: 28.558059, longitude: 77.268890),
                    CLLocationCoordinate2D(latitude: 28.555068, longitude: 77.267599),
                    CLLocationCoordinate2D(latitude: 28.550068, longitude: 77.267599)
                ]
                if let style = vc.mapView.style {
                    let polygon = MGLPolygonFeature(coordinates: &coordinates, count:UInt(coordinates.count))
                    
                    let source = MGLShapeSource(identifier: "identifier", shape: polygon, options: nil)
                    style.addSource(source)
                    
                    let polygonLayer = MGLFillStyleLayer(identifier: "layerIdentifier", source: source)
                    polygonLayer.fillColor = NSExpression(forConstantValue: UIColor.green)
                    polygonLayer.fillOpacity = NSExpression(forConstantValue: 0.5)
                    polygonLayer.fillOutlineColor = NSExpression(forConstantValue: UIColor.brown)
                    
                    style.addLayer(polygonLayer)
                    
                    let shapeCam = vc.mapView.cameraThatFitsShape(polygon, direction: CLLocationDirection(0), edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
                    vc.mapView.setCamera(shapeCam, animated: false)
                }
            }
            break
        case Constants.SectionThree.reverseGeocode:
            vc.funcToRunOnMapRender = {
                let addresslbl = UILabel()
                addresslbl.frame = CGRect(x: 0, y: vc.mapView.bounds.height, width: vc.mapView.bounds.width, height: 70)
                addresslbl.backgroundColor = .white
                addresslbl.numberOfLines = 0
                addresslbl.textAlignment = .center
                
                vc.view.addSubview(addresslbl)
                
                let coordinate = CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918)
                
                let geocodeMagager = MapplsReverseGeocodeManager.shared
                
                let revOptions = MapplsReverseGeocodeOptions(coordinate: coordinate)
                
                geocodeMagager.reverseGeocode(revOptions, completionHandler: { placemarks, attribution, error in
                    
                    if let error = error {
                        addresslbl.text = error.localizedDescription
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
                            addresslbl.text = "Some Error Occured"
                        }
                    }
                })
                vc.mapView.setCenter(CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918), zoomLevel: 15, animated: true)
                let point = MGLPointAnnotation()
                point.coordinate = coordinate
                point.title = "point"
                
                vc.mapView.addAnnotation(point)
            }
            break
        case Constants.SectionThree.placeDetailsBoxWithSearchedLocMarker:
            vc.funcToRunOnMapRender = {
                let searchBox = UISearchBar()
                searchBox.frame = CGRect(x: 0, y: 0, width: vc.mapView.bounds.width, height: 50)
                searchBox.placeholder = "Search for a place"
                vc.mapView.addSubview(searchBox)
                searchBox.delegate = vc.self
            }
            
            break
        case Constants.SectionThree.roadDistance:
            vc.funcToRunOnMapRender = {
                let distanceLbl = UILabel()
                distanceLbl.backgroundColor = .white
                distanceLbl.frame = CGRect(x: 0, y: vc.mapView.bounds.height - 50, width: vc.mapView.bounds.width, height: 50)
                distanceLbl.numberOfLines = 0
                distanceLbl.textAlignment = .center
                
                vc.mapView.addSubview(distanceLbl)
                
                let origin = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 22.5744, longitude: 88.3629))
                let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918))
                origin.allowsArrivingOnOppositeSide = false
                destination.allowsArrivingOnOppositeSide = false
                
                let options = RouteOptions(waypoints: [origin, destination])
                options.routeShapeResolution = .full
                options.includesAlternativeRoutes = true

                Directions(restKey: MapplsAccountManager.restAPIKey()).calculate(options) { (waypoints, routes, error) in
                    if let _ = error {
                        distanceLbl.text = error?.localizedDescription
                    }else if let routes = routes, routes.count > 0 {
                        distanceLbl.text = "Road distance between Kolkata and Delhi: \(routes.first?.distance ?? 0.0)m"
                        let firstRoute = routes[0]
                        if let routeCoord = firstRoute.coordinates {
                            let polyline = MGLPolyline(coordinates: routeCoord, count: UInt(routeCoord.count))
                            vc.mapView.addAnnotation(polyline)
                            vc.mapView.showAnnotations([polyline], edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
                        }
                    }
                }
            }
            break
        case Constants.SectionThree.specificCategoryNearby:
            vc.funcToRunOnMapRender = {
                let label = UILabel()
                label.backgroundColor = .white
                label.textAlignment = .center
                label.numberOfLines = 0
                label.frame = CGRect(x: 0, y: vc.mapView.bounds.height-50, width: vc.mapView.bounds.width, height: 50)
                vc.mapView.addSubview(label)
                
                label.text = "Nearby Places for the Restaurants category around lat-22.5744 and lon-88.3629"
                
                let nearByManager = MapplsNearByManager.shared
                let filter = MapplsNearbyKeyValueFilter(filterKey: "brandId", filterValues: ["String","String"])
                let sortBy = MapplsSortByDistanceWithOrder(orderBy: .ascending)
                let nearByOptions = MapplsNearbyAtlasOptions(query: "Restaurants", location: "22.5744,88.3629")
                nearByOptions.sortBy = sortBy
                nearByOptions.searchBy = .distance
                
                nearByManager.getNearBySuggestions(nearByOptions) { (suggestions, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }else if let suggestions = suggestions?.suggestions, !suggestions.isEmpty {
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

            }
            break
        case Constants.SectionThree.imageOfMap:
            vc.mapView.isHidden = true
            let progressRotator = UIActivityIndicatorView(style: .medium)
            vc.view.addSubview(progressRotator)
            progressRotator.center = vc.view.center
            progressRotator.hidesWhenStopped = true
            progressRotator.startAnimating()
            
            var urlComponents = URLComponents(string: "https://apis.mappls.com/advancedmaps/v1/b266d36c46a279bf83f769e3a184d4a3/still_image")
            
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
                    progressRotator.stopAnimating()
                    if let image = UIImage(data: data) {
                        let imageView = UIImageView(image: image)
                        imageView.frame = CGRect(x: 0, y: 0, width: vc.view.bounds.width, height: vc.view.bounds.height)
                        imageView.contentMode = .scaleAspectFit
                        vc.view.addSubview(imageView)
                        return
                    } else {
                        print("Failed to convert data to image.")
                    }
                }
            }else {
                progressRotator.stopAnimating()
            }
            break
        default:
            break
        }
        
        navigationController?.present(vc, animated: true)
    }
}

struct SectionInfo {
    var sectionTitle: String
    var cellInfo: [HomeItemCellData]
}

struct HomeItemCellData {
    var name: String
}


struct Constants {
    struct SectionOne {
        static let showPopUpOnClick = "Show custom pop up on click of marker with lat lon"
    }
    
    struct SectionTwo {
        static let showMap = "Show map"
        static let zoomLevelSet = "Map zoom level set to 15"
        static let zoomLevelAndCenterWithAnimation = "Map zoom level and centre with animation"
        static let customMarkerPopupWithInfoWindow = "Custom marker with infoWindow popup when clicked"
        static let fiftyMarker = "50 custom marker annotations, highlighted when clicked"
        static let polyline = "Map with plotted polyline"
        static let polylineWithColor = "Map with plotted polyline with custom color"
        static let polygon = "Map with plotted polygon"
        static let polygonCustomColorOpacity = "Map with plotted polygon with custom colour and opacity"
    }
    
    struct SectionThree {
        static let reverseGeocode = "Reverse geocode to get human readable address from lat Lon"
        static let placeDetailsBoxWithSearchedLocMarker = "Place details search box with marker on searched location"
        static let roadDistance = "Road distance between two location"
        static let specificCategoryNearby = "Specific category nearby places information of a location"
        static let imageOfMap = "Image of a map with markers"
    }
}

class CustomCalloutView: UIView, MGLCalloutView {
    var representedObject: MGLAnnotation
    
    let dismissesAutomatically: Bool = false
    let isAnchoredToAnnotation: Bool = true
        
    override var center: CGPoint {
        set {
            var newCenter = newValue
            newCenter.y = newCenter.y - bounds.midY
            super.center = newCenter
        }
        get {
            return super.center
        }
    }
    
    lazy var leftAccessoryView = UIView()
    lazy var rightAccessoryView = UIView()
    
    weak var delegate: MGLCalloutViewDelegate?
    
    let tipHeight: CGFloat = 10.0
    let tipWidth: CGFloat = 20.0
    
    let mainBody: UIButton
    
    required init(representedObject: MGLAnnotation) {
        self.representedObject = representedObject
        self.mainBody = UIButton(type: .system)
        
        super.init(frame: .zero)
        
        backgroundColor = .clear
        
        mainBody.backgroundColor = .darkGray
        mainBody.tintColor = .white
        mainBody.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        mainBody.layer.cornerRadius = 4.0
        
        addSubview(mainBody)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentCallout(from rect: CGRect, in view: UIView, constrainedTo constrainedRect: CGRect, animated: Bool) {
        view.addSubview(self)
        
        // Prepare title label.
        mainBody.setTitle(representedObject.title!, for: .normal)
        mainBody.sizeToFit()
        
        if isCalloutTappable() {
            // Handle taps and eventually try to send them to the delegate (usually the map view).
            mainBody.addTarget(self, action: #selector(CustomCalloutView.calloutTapped), for: .touchUpInside)
        } else {
            // Disable tapping and highlighting.
            mainBody.isUserInteractionEnabled = false
        }
        
        // Prepare our frame, adding extra space at the bottom for the tip.
        let frameWidth = mainBody.bounds.size.width
        let frameHeight = mainBody.bounds.size.height + tipHeight
        let frameOriginX = rect.origin.x + (rect.size.width/2.0) - (frameWidth/2.0)
        let frameOriginY = rect.origin.y - frameHeight
        frame = CGRect(x: frameOriginX, y: frameOriginY, width: frameWidth, height: frameHeight)
        
        if animated {
            alpha = 0
            
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.alpha = 1
            }
        }
    }
    
    func dismissCallout(animated: Bool) {
        if (superview != nil) {
            if animated {
                UIView.animate(withDuration: 0.2, animations: { [weak self] in
                    self?.alpha = 0
                    }, completion: { [weak self] _ in
                        self?.removeFromSuperview()
                })
            } else {
                removeFromSuperview()
            }
        }
    }
    
    // MARK: - Callout interaction handlers
    
    func isCalloutTappable() -> Bool {
        if let delegate = delegate {
            if delegate.responds(to: #selector(MGLCalloutViewDelegate.calloutViewShouldHighlight)) {
                return delegate.calloutViewShouldHighlight!(self)
            }
        }
        return false
    }
    
    @objc func calloutTapped() {
        if isCalloutTappable() && delegate!.responds(to: #selector(MGLCalloutViewDelegate.calloutViewTapped)) {
            delegate!.calloutViewTapped!(self)
        }
    }
    
    // MARK: - Custom view styling
    
    override func draw(_ rect: CGRect) {
        // Draw the pointed tip at the bottom.
        let fillColor : UIColor = .darkGray
        
        let tipLeft = rect.origin.x + (rect.size.width / 2.0) - (tipWidth / 2.0)
        let tipBottom = CGPoint(x: rect.origin.x + (rect.size.width / 2.0), y: rect.origin.y + rect.size.height)
        let heightWithoutTip = rect.size.height - tipHeight - 1
        
        let currentContext = UIGraphicsGetCurrentContext()!
        
        let tipPath = CGMutablePath()
        tipPath.move(to: CGPoint(x: tipLeft, y: heightWithoutTip))
        tipPath.addLine(to: CGPoint(x: tipBottom.x, y: tipBottom.y))
        tipPath.addLine(to: CGPoint(x: tipLeft + tipWidth, y: heightWithoutTip))
        tipPath.closeSubpath()
        
        fillColor.setFill()
        currentContext.addPath(tipPath)
        currentContext.fillPath()
    }
}

