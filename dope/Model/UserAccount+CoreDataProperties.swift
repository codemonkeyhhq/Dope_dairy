//
//  UserAccount+CoreDataProperties.swift
//  dope
//
//  Created by Jiaming Duan on 4/25/19.
//  Copyright © 2019 HaoqiHuang. All rights reserved.
//
//

import Foundation
import CoreData


extension UserAccount {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserAccount> {
        return NSFetchRequest<UserAccount>(entityName: "UserAccount")
    }

    @NSManaged public var password: String?
    @NSManaged public var id: Int16
    @NSManaged public var account: String?

}
