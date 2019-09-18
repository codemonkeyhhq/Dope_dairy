//
//  SearchHelper.swift
//  dope
//
//  Created by Jiaming Duan on 4/25/19.
//  Copyright © 2019 HaoqiHuang. All rights reserved.
//

import Foundation
import CoreData
class SearchHelper{
    class func userSearchByAccount(account:String)->UserAccount?{
        let fetchRequest=NSFetchRequest<UserAccount>(entityName: "UserAccount")
        let predicte=NSPredicate(format: "account==%@", account)
        fetchRequest.predicate=predicte
        let users=try!PersistenceService.context.fetch(fetchRequest)
        guard let firstUser=users.first else{return nil}
        return firstUser
    }
    class func userSearchByPassword(password:String)->UserAccount?{
        let fetchRequest=NSFetchRequest<UserAccount>(entityName: "UserAccount")
        let predicte=NSPredicate(format: "password==%@", password)
        fetchRequest.predicate=predicte
        let users=try!PersistenceService.context.fetch(fetchRequest)
        guard let firstUser=users.first else{return nil}
        return firstUser
    }
    class func activitySearchByTitle(title:String)->Activity?{
        let fetchRequest=NSFetchRequest<Activity>(entityName: "Activity")
        let predicte=NSPredicate(format: "title==%@", title)
        fetchRequest.predicate=predicte
        let activities=try!PersistenceService.context.fetch(fetchRequest)
        guard let firstAct=activities.first else{return nil}
        return firstAct
    }
    class func booksSearchByUser(userId:Int16)->[Book]?{
        let fetchRequest=NSFetchRequest<Book>(entityName: "Book")
        let predicte=NSPredicate(format: "userId==%i", userId)
        fetchRequest.predicate=predicte
        let books:[Book]=try!PersistenceService.context.fetch(fetchRequest)
        return books
    }
    class func activitySearchByTitle(activityId:Int16)->Activity?{
        let fetchRequest=NSFetchRequest<Activity>(entityName: "Activity")
        let predicte=NSPredicate(format: "id==%i", activityId)
        fetchRequest.predicate=predicte
        let activities=try!PersistenceService.context.fetch(fetchRequest)
        guard let firstAct=activities.first else{return nil}
        return firstAct
    }
}
