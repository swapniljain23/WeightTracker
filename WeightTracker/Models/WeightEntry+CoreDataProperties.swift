//
//  WeightEntry+CoreDataProperties.swift
//  WeightTracker
//
//  Created by Swapnil Jain on 5/26/19.
//  Copyright © 2019 Swapnil Jain. All rights reserved.
//
//

import Foundation
import CoreData

extension WeightEntry {

  @nonobjc public class func fetchRequest() -> NSFetchRequest<WeightEntry> {
    let request = NSFetchRequest<WeightEntry>(entityName: "WeightEntry")
    request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
    return request
  }

  @NSManaged public var weightInLB: NSNumber
  @NSManaged public var date: NSDate
  
  convenience init(context: NSManagedObjectContext, weightInLB: Double, date: NSDate) {
    self.init(context: context)
    self.weightInLB = NSNumber(value: weightInLB)
    self.date = date
  }
  
  var weightInLbInText: String {
    return String(format: "%.2f LB", weightInLB.doubleValue)
  }
  
  var dateInText: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "en_US")
    return "\(formatter.string(from: date as Date))"
  }
  
  static func randomWeightEntry(with context: NSManagedObjectContext) -> WeightEntry {
    let randomWeight = Double.random(in: 50...200)
    let randomDate = Date.randomWithinDaysBeforeToday(30)
    return WeightEntry(
      context: context,
      weightInLB: randomWeight,
      date: randomDate as NSDate)
  }
}
