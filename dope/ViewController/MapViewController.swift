//
//  MapViewController.swift
//  dope
//
//  Created by Jiaming Duan on 4/24/19.
//  Copyright © 2019 HaoqiHuang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData
extension MapViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        //add location track
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        //add location track
    }
}
extension MapViewController:MKMapViewDelegate{
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
//        var pinAnnotation=mapView.dequeueReusableAnnotationView(withIdentifier:"AnnotationView" )
//        if pinAnnotation == nil {
//            pinAnnotation=MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
//        }
//        if   annotation === mapView.userLocation{
//            pinAnnotation?.image=UIImage(named:"user")
//        }else{
//            pinAnnotation?.image=UIImage(named: "activity")
//        }
//
//        pinAnnotation?.canShowCallout=true
//        return pinAnnotation
//
//    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
      
        actTitle=(view.annotation?.title)!
        performSegue(withIdentifier: "activityDetail", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "activityDetail" {
            if let destinationVC = segue.destination as? ActivityDetail {
                destinationVC.actTitle = actTitle
            }
        }
    }

}
class MapViewController: UIViewController {
      var status:Bool=false
    let locationManager=CLLocationManager()
    var actTitle:String!
    @IBOutlet weak var mapView: MKMapView!
    override func viewWillAppear(_ animated: Bool) {
        if status{
            status=false}
            
        else{setUpView()}
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        status=true
        self.mapView.delegate=self
        locationManager.delegate = self
        setUpView()
    }
    func setUpView(){
        let allAnnotations=self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        checkLocationServices()
        // Do any additional setup after loading the view.
        addPinList()
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    func addPinList(){
        let fetchRequest:NSFetchRequest<Activity>=Activity.fetchRequest()
        let list:[Activity]
        do{list=try PersistenceService.context.fetch(fetchRequest)
         
            for a in list{
                let x=Double(a.locationX+23)
        
                let y=Double(a.locationY+157)

                let location:CGPoint=CGPoint(x:x,y:y)
                 let locCoord=self.mapView.convert(location, toCoordinateFrom: self.mapView)
                let pin=customPin(pinTitle: a.title!, pinSubTitle: a.detail!, location: locCoord)
                self.mapView.addAnnotation(pin)
          
            }
        }
        catch{Note.note(content: "Something wrong in pinning")}
        self.mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    
    func setupLocationManager(){

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            Note.note(content:"please turn on your location service in general-setting")
            break
        case .denied:
            Note.note(content:"please turn on your location service in general-setting")
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation=true
            centerViewOnUserLocation()
            break
        }
    }
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center:location, latitudinalMeters:10000,longitudinalMeters:10000)
            mapView.setRegion(region, animated: true)
        }
  
    }
    func checkLocationServices()->Bool{
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthorization()
            return true
        }
        else{
            Note.note(content:"please turn on your location service")
            return false
        }
 
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
