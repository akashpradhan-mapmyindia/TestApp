//
//  CommonMapViewController.swift
//  TestApp
//
//  Created by rento on 06/09/24.
//

import UIKit
import MapplsMap
import MapplsUIWidgets

class CommonMapViewController: UIViewController {
    var mapView: MapplsMapView!
    var itemTitleLbl: UILabel!
    var itemTitle: String = ""
    var funcToRunOnMapRender: ()->Void = {}
    var popUpFuncOnMarkerClick: ()->Void = {}
    var annotationCanShowCallout: Bool = false
    var showCustomMarker: Bool = false
    var showCustomMarkerView: Bool = false
    var showCustomCallout: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    convenience init(title: String) {
        self.init()
        itemTitle = title
        setUpUI()
    }
    
    func setUpUI() {
        view.backgroundColor = .white
        
        itemTitleLbl = UILabel()
        view.addSubview(itemTitleLbl)
        itemTitleLbl.text = itemTitle
        itemTitleLbl.numberOfLines = 0
        itemTitleLbl.textAlignment = .center
        itemTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemTitleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            itemTitleLbl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            itemTitleLbl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        mapView = MapplsMapView()
        view.addSubview(mapView)
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: itemTitleLbl.bottomAnchor, constant: 20),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension CommonMapViewController: MapplsMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        funcToRunOnMapRender()
    }
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        popUpFuncOnMarkerClick()
    }
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        if showCustomMarker {
            let annotView = MGLAnnotationImage(image: UIImage(named: "custom-loc-icon")!, reuseIdentifier: "annotation\(annotation.title)")
            
            return annotView
        }
        return nil
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        if showCustomMarkerView {
            let view = CustomAnnotationView(reuseIdentifier: annotation.title ?? "", image: UIImage(named: "custom-loc-icon")!)
            view.bounds = CGRect(x: 0, y: 0, width: 15, height: 15)
            return view
        }
            
        return nil
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return annotationCanShowCallout
    }
    
    func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? {
        if showCustomCallout {
            return CustomCalloutView(representedObject: annotation)
        }
        return nil
    }
}

class CustomAnnotationView: MGLAnnotationView {
    var imageView = UIImageView()
  
    init(reuseIdentifier: String?, image: UIImage) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width
        layer.borderWidth = 2
        layer.borderColor = UIColor.clear.cgColor
    }
    
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
    }
}

extension CommonMapViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        let autocompleteController = MapplsAutocompleteViewController(theme: .auto)
        autocompleteController.delegate = self
        
        let filter = MapplsAutocompleteFilter()
        
        autocompleteController.autocompleteFilter = filter

        present(autocompleteController, animated: true, completion: nil)

        return false
    }
}

extension CommonMapViewController: MapplsAutocompleteViewControllerDelegate {
    func didAutocomplete(viewController: MapplsUIWidgets.MapplsAutocompleteViewController, withSuggestion suggestion: MapplsAPIKit.MapplsSearchPrediction) {
        
    }
    
    func didAutocomplete(viewController: MapplsUIWidgets.MapplsAutocompleteViewController, withPlace place: MapplsAPIKit.MapplsAtlasSuggestion, resultType type: MapplsAutosuggestResultType) {
        viewController.dismiss(animated: true)
 
        let point = MapplsPointAnnotation(mapplsPin: place.mapplsPin ?? "")
        
        mapView.addMapplsAnnotation(point) { isSuccess, error in
            self.mapView.showMapplsPins([place.mapplsPin ?? ""], animated: true)
        }
    }
    
    func didAutocomplete(viewController: MapplsUIWidgets.MapplsAutocompleteViewController, withFavouritePlace place: MapplsUIWidgets.MapplsUIWidgetAutosuggestFavouritePlace) {
        
    }
    
    func didFailAutocomplete(viewController: MapplsUIWidgets.MapplsAutocompleteViewController, withError error: NSError) {
        
    }
    
    func wasCancelled(viewController: MapplsUIWidgets.MapplsAutocompleteViewController) {
        
    }
    
    
}
