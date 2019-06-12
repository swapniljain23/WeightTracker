//
//  PersistentManager.swift
//  WeightTracker
//
//  Created by Swapnil Jain on 5/27/19.
//  Copyright © 2019 Swapnil Jain. All rights reserved.
//

import Foundation
import CoreData
import UserNotifications
import UIKit

class PersistentManager {
  
  init() {
    NotificationCenter.default.addObserver(
        self,
        selector: #selector(applicationWillTerminate(notification:)),
        name: UIApplication.willTerminateNotification,
        object: nil)
  }
  
  private lazy var container: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "WeightTracker")
    container.viewContext.automaticallyMergesChangesFromParent = true
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        print("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  lazy var managedContext: NSManagedObjectContext = {
    return container.viewContext
  }()
  
  func saveContext () {
    if managedContext.hasChanges {
      do {
        try managedContext.save()
      } catch {
        let nserror = error as NSError
        print("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  @objc func applicationWillTerminate(notification: Notification) {
    saveContext()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}
