//
//  MapViewController.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 30.08.21.
//

import UIKit
import MapboxMaps

class MapViewController: UIViewController {
    var map: MapView?
    
    var annotationsPointManager: PointAnnotationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map = setupMapView()
        map?.mapboxMap.onNext(.mapLoaded) { _ in
            self.annotationsPointManager = self.map?.annotations.makePointAnnotationManager()
            self.annotationsPointManager?.delegate = self
            
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
        
        return mapView
    }
}

extension MapViewController: AnnotationInteractionDelegate {
    
    func annotationManager(_ manager: AnnotationManager, didDetectTappedAnnotations annotations: [Annotation]) {
        print("annotations tapped: \(annotations)")
    }
    
    
}
