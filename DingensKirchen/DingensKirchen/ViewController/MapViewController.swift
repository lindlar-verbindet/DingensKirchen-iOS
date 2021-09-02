//
//  MapViewController.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 30.08.21.
//

import UIKit
import SwiftUI
import MapboxMaps

class MapViewController: UIViewController {
    var map: MapView?
    
    var annotationsPointManager: PointAnnotationManager?
    var mobilView: MobilView?
    
    private let stopsID = "bus-map-data-250621-b0qi91"
    private let routesID = "routes-map-data-250621-5ep1to"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map = setupMapView()
        map?.mapboxMap.onNext(.mapLoaded) { _ in
//            self.annotationsPointManager = self.map?.annotations.makePointAnnotationManager()
//            self.annotationsPointManager?.delegate = self
            
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
        
        mapView.ornaments.options.compass.visibility = .visible
        mapView.ornaments.options.compass.position = .topRight
        mapView.ornaments.options.scaleBar.visibility = .hidden
        
        mapView.ornaments.options.attributionButton.margins = CGPoint(x: 0.0, y: 30.0)
        mapView.ornaments.options.attributionButton.position = .topRight
        
        
        mapView.ornaments.options.logo.position = .topLeft
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(mapTaped))
        mapView.addGestureRecognizer(recognizer)
        return mapView
    }
    
    fileprivate func queryStop(sender: UITapGestureRecognizer) {
        map?.mapboxMap.queryRenderedFeatures(at: sender.location(in: map), options: RenderedQueryOptions(layerIds: [stopsID], filter: .none)) { result in
            var title = ""
            do {
                try result.get().forEach { feature in
                    print("\(self.stopsID): \(feature.feature.properties)")
                    if let name = feature.feature.properties["name"] {
                        if title == "" {
                            title.append(name as! String)
                        } else {
                            title.append("\n\(name as! String)")
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
                    print("\(self.routesID): \(feature.feature.properties)")
                    if let ref = feature.feature.properties["ref"] as? String {
                        let busLink = self.getDeparturePlan(ref)
                        let from = feature.feature.properties["from"] as! String
                        let to = feature.feature.properties["to"] as! String
                        if desc == "" {
                            desc.append("\(busLink): \(from) -> \(to)")
                        } else {
                            desc.append("<br>\(busLink): \(from) -> \(to)")
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
        print(sender.location(in: map))
        
        mobilView?.contextTitle = "Greetings..."
        mobilView?.contextDesc = "from MapViewController"
                
        queryStop(sender: sender)
        queryLineInfo(sender: sender)
    }
}

extension MapViewController: AnnotationInteractionDelegate {
    
    func annotationManager(_ manager: AnnotationManager, didDetectTappedAnnotations annotations: [Annotation]) {
        
        

        
    }
}
