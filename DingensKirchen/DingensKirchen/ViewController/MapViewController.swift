//
//  MapViewController.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 30.08.21.
//

import UIKit
import SwiftUI
import MapboxMaps

// Create class which conforms to LocationConsumer, update the camera's centerCoordinate when a locationUpdate is received
public class CameraLocationConsumer: LocationConsumer {
    weak var mapView: MapView?
    var firstUpdate: Bool = true
     
    init(mapView: MapView) {
        self.mapView = mapView
    }
     
    public func locationUpdate(newLocation: Location) {
        if firstUpdate {
            mapView?.camera.ease(to: CameraOptions(center: newLocation.coordinate,
                                                   zoom: 13),
                                 duration: 1.3)
            firstUpdate.toggle()
        }
    }
}

class MapViewController: UIViewController {
    var map: MapView?
    
    var annotationsPointManager: PointAnnotationManager?
    var mobilView: MobilView?
    
    internal var cameraLocationConsumer: CameraLocationConsumer!
    
    private let stopsID = "bus-map-data-250621-b0qi91"
    private let routesID = "routes-map-data-250621-5ep1to"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map = setupMapView()
        cameraLocationConsumer = CameraLocationConsumer(mapView: map!)
        self.setupCamera(map!)
        self.setupOrnaments(map!)
        map?.mapboxMap.onNext(.mapLoaded) { _ in
            if let mapView = self.map {
                self.setupLocation(mapView)
            }
        }
        view.addSubview(map!)
    }
    
    private func setupMapView() -> MapView {
        let resourceOptions = ResourceOptions(accessToken: "pk.eyJ1IjoicGl4ZWxza3VsbCIsImEiOiJja3B4dGVjOG0wNjcxMnJvNmkxMjgwNW5uIn0.X4Y1kWyTsmm6Y2yE2a2TUQ")
        
        let styleURL = URL(string: "mapbox://styles/pixelskull/ckqc2n0m10gbv17mztnwa9eou")!
        let styleURI = StyleURI(url: styleURL)
        
        let initOptions = MapInitOptions(resourceOptions: resourceOptions, styleURI: styleURI)
        
        
        let mapView = MapView(frame: view.bounds, mapInitOptions: initOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(mapTaped))
        mapView.addGestureRecognizer(recognizer)
        return mapView
    }
    
    private func setupOrnaments(_ mapView: MapView) {
        mapView.ornaments.options.compass.visibility = .visible
        mapView.ornaments.options.compass.position = .topRight
        mapView.ornaments.options.scaleBar.visibility = .hidden
        
        mapView.ornaments.options.attributionButton.margins = CGPoint(x: 0.0, y: 30.0)
        mapView.ornaments.options.attributionButton.position = .topRight
        
        mapView.ornaments.options.logo.position = .topLeft
    }
    
    private func setupLocation(_ mapView: MapView) {
        mapView.location.requestTemporaryFullAccuracyPermissions(withPurposeKey: "de.lindlarverbindet.dingeskirchen.location")
        mapView.location.options.puckType = .puck2D()
        mapView.location.options.puckBearingSource = .heading
    }
    
    private func setupCamera(_ mapView: MapView) {
        let locationStatus = mapView.location.locationProvider.authorizationStatus
        var cameraOptions = CameraOptions()
        if  locationStatus == .authorizedAlways ||
                locationStatus == .authorizedWhenInUse {
            // focus on current location
            cameraOptions = CameraOptions(center: mapView.location.latestLocation?.coordinate, zoom: 13)
            mapView.location.addLocationConsumer(newConsumer: self.cameraLocationConsumer)
        } else {
            // focus on 51.020210571339675, 7.376733748068474
            cameraOptions = CameraOptions(center: CLLocationCoordinate2D(latitude: 51.020210571339675, longitude: 7.376733748068474), zoom: 13)
        }
        mapView.camera.ease(to: cameraOptions, duration: 2.0)
    }
    
    fileprivate func queryStop(sender: UITapGestureRecognizer) {
        map?.mapboxMap.queryRenderedFeatures(at: sender.location(in: map), options: RenderedQueryOptions(layerIds: [stopsID], filter: .none)) { result in
            var title = ""
            do {
                try result.get().forEach { feature in
//                    print("\(self.stopsID): \(String(describing: feature.feature.properties))")
                    if let name = feature.feature.properties?["name"] {
                        if title == "" {
                            title.append(name?.rawValue as! String)
                        } else {
                            title.append("\n\(name?.rawValue as! String)")
                        }
                    }
                }
                self.mobilView?.contextTitle = title
            } catch {
                print(error)
                self.mobilView?.contextTitle = "DEFAULT VALUE HERE"
            }
        }
    }
    
    private func getDeparturePlan(_ busID: String) -> String {
        return "<a href=https://www.vrs.de/his/minifahrplan/de:vrs:\(busID)>\(busID)</a>"
    }
    
    fileprivate func queryLineInfo(sender: UITapGestureRecognizer) {
        let point = sender.location(in: map)
        map?.mapboxMap.queryRenderedFeatures(in: CGRect(x: point.x-25, y: point.y-25, width: 50, height: 50), options: RenderedQueryOptions(layerIds: [routesID], filter: .none)) { result in
            var desc = ""
            do {
                try result.get().forEach { feature in
//                    print("\(self.routesID): \(String(describing: feature.feature.properties))")
                    if let ref = feature.feature.properties?["ref"] {
                        let busLink = self.getDeparturePlan(ref?.rawValue as! String)
                        let from = feature.feature.properties?["from"]
                        let to = feature.feature.properties?["to"]
                        if desc == "" {
                            desc.append("\(busLink): \(from??.rawValue as! String) -> \(to??.rawValue as! String)")
                        } else {
                            desc.append("<br>\(busLink): \(from??.rawValue as! String) -> \(to??.rawValue as! String)")
                        }
                    }
                    
                }
                self.mobilView?.contextDesc = desc
            } catch {
                print(error)
                self.mobilView?.contextDesc = "DEFAULT VALUE HERE"
            }
        }
    }
    
    @objc func mapTaped(sender: UITapGestureRecognizer) {
//        print(sender.location(in: map))
        queryStop(sender: sender)
        queryLineInfo(sender: sender)
    }
}

extension MapViewController: AnnotationInteractionDelegate {
    
    func annotationManager(_ manager: AnnotationManager, didDetectTappedAnnotations annotations: [Annotation]) {}
}

extension MapViewController: LocationPermissionsDelegate {
    func locationManager(_ locationManager: LocationManager, didChangeAccuracyAuthorization accuracyAuthorization: CLAccuracyAuthorization) {
        if accuracyAuthorization == .reducedAccuracy {
         // Perform an action in response to the new change in accuracy
        }
    }
}
