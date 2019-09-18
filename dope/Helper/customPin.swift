//
//  customPin.swift
//  dope
//
//  Created by Jiaming Duan on 4/24/19.
//  Copyright © 2019 HaoqiHuang. All rights reserved.
//

import Foundation
import MapKit


class customPin:NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var activity:Activity!
    init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
        self.coordinate=location
        self.title=pinTitle
            self.subtitle=pinSubTitle
    }
    func setActivity(activity:Activity){
        self.activity=activity
    }
}
