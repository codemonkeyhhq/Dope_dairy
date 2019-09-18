//
//  CreateActivityViewController.swift
//  dope
//
//  Created by Jiaming Duan on 4/25/19.
//  Copyright © 2019 HaoqiHuang. All rights reserved.
//

import UIKit
import MapKit
extension UIImage {
    func toString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
class CreateActivityViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    static var count=0
    @IBOutlet weak var dateText: UITextField!
    @IBAction func addPhoto(_ sender: UIButton) {
        let imageController=UIImagePickerController()
        imageController.delegate=self
        imageController.sourceType=UIImagePickerController.SourceType.photoLibrary
        self.present(imageController,animated: true,completion:nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tmpImage=info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        photoLabel.text=tmpImage.toString()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var photoLabel: UILabel!
    let locationManager=CLLocationManager()
    var x:Float?
    var y:Float?
    
    @IBOutlet weak var detail: UITextField!
    @IBOutlet weak var titleText: UITextField!
    @IBAction func create(_ sender: UIButton) {
        if(validateData()){
            let activity:Activity=Activity(context: PersistenceService.context)
            activity.id=Int16(CreateActivityViewController.count)
        CreateActivityViewController.count=CreateActivityViewController.count+1
            activity.image=photoLabel.text
            activity.detail=detail.text
            activity.title=titleText.text
            activity.locationX=x!
            activity.locationY=y!
            PersistenceService.saveContext()
            Note.note(content: "activity created")
        }
        else{
            Note.note(content: "please type correct information")
        }
    }
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func addPIn(_ sender: UILongPressGestureRecognizer) {
            let location=sender.location(in: self.mapView)
            let locCoord=self.mapView.convert(location, toCoordinateFrom: self.mapView)
            let annoatation=MKPointAnnotation()
            annoatation.coordinate=locCoord
            annoatation.title="Dope"
            annoatation.subtitle="Let's dope here!!!!"
        if(!mapView.annotations.isEmpty){self.mapView.removeAnnotations(mapView!.annotations)}
            self.mapView.addAnnotation(annoatation)
            
            x=Float(location.x)
            y=Float(location.y)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate=self
        locationManager.delegate = self
        checkLocationServices()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkLocationServices()
    }
    
    
    func validateData()->Bool{
        if(dateText.text==nil){return false}
        if(titleText.text==nil){return false}
        if(detail.text==nil){return false}
        if((dateText.text?.count)!<1){return false}
        if(titleText.text!.count<1){return false}
        if((detail.text?.count)!<1){return false}
        if(x==nil){return false}
        if(y==nil){return false}
        return true
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
            let region = MKCoordinateRegion.init(center:location, latitudinalMeters:8000,longitudinalMeters:8000)
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
    func setupLocationManager(){
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
}
