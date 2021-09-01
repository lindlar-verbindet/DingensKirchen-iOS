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
    
    @objc func mapTaped(sender: UITapGestureRecognizer) {
        print(sender.location(in: map))
        
        mobilView?.contextTitle = "Greetings..."
        mobilView?.contextDesc = "from MapViewController"
        
        let point = sender.location(in: map)
        map?.mapboxMap.queryRenderedFeatures(at: sender.location(in: map)) { result in
            do {
                guard let name = try result.get().first?.feature.properties["name"] else {
                    self.mobilView?.contextTitle = "Nicht das richtige gefunden?"
                    return
                }
                print(name as! String)
                self.mobilView?.contextTitle = name as! String
            } catch {
                self.mobilView?.contextTitle = "Nicht das richtige gefunden?"
                print(error)
            }
        }
        map?.mapboxMap.queryRenderedFeatures(in: CGRect(x: point.x-5, y: point.y-5, width: 10, height: 10)) { result in
            try! result.get().forEach { feature in
                print(feature.feature.properties)
            }
        }
        
        map?.mapboxMap.queryRenderedFeatures(in: CGRect(x: point.x-25, y: point.y-25, width: 50, height: 50), options: RenderedQueryOptions(layerIds: [routesID], filter: .none)) { result in
            do {
                var desc = ""
                try result.get().forEach { feature in
                    print("\(self.stopsID): \(feature.feature.properties)")
                    if let name = feature.feature.properties["name"] {
                        if desc == "" {
                            desc.append(name as! String)
                        } else {
                            desc.append("\n\(name as! String)")
                        }
                    }
                }
                self.mobilView?.contextDesc = desc
            } catch {
                print(error)
            }
        }
    }
}

extension MapViewController: AnnotationInteractionDelegate {
    
    func annotationManager(_ manager: AnnotationManager, didDetectTappedAnnotations annotations: [Annotation]) {
        
        

        
    }
}
