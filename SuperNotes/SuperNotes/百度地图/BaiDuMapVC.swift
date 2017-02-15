//
//  BaiDuMapVC.swift
//  SuperNotes
//
//  Created by ld on 16/7/16.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class BaiDuMapVC: UIViewController {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        mapView.delegate = self
        locService.delegate = self
        locService.startUserLocationService()
        mapView.addAnnotation(annotation)
    }
    //MARK: - 懒加载
    var mapView:BMKMapView = {
        let mapView = BMKMapView(frame: UIScreen.mainScreen().bounds)
        mapView.showsUserLocation = true
        mapView.rotateEnabled = false
        return mapView
    }()
    var locService:BMKLocationService = BMKLocationService()
    var annotation:BMKPointAnnotation = {
       let anno = BMKPointAnnotation()
        anno.coordinate = CLLocationCoordinate2D(latitude: -1, longitude: -1)
        anno.title = "我的位置"
        return anno
    }()
}

extension BaiDuMapVC:BMKLocationServiceDelegate,BMKMapViewDelegate
{
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        let span = BMKCoordinateSpanMake(0.005, 0.005)
        let region = BMKCoordinateRegionMake(userLocation.location.coordinate, span)
        annotation.coordinate = userLocation.location.coordinate
        mapView.setRegion(region, animated: true)
    }
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if annotation.isKindOfClass(BMKPointAnnotation.self) {
            let newAnnotationView = BMKPinAnnotationView.init(annotation: annotation, reuseIdentifier: "myAnnotation")
            newAnnotationView.animatesDrop = true
            return newAnnotationView
        }
        return nil
    }
}
