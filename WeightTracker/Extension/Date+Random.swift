//
//  Date+Random.swift
//  WeightTracker
//
//  Created by Swapnil Jain on 5/27/19.
//  Copyright © 2019 Swapnil Jain. All rights reserved.
//

import Foundation

extension Date {
  
  static func random(between initial: Date, and final: Date) -> Date {
    let interval = final.timeIntervalSince(initial)
    let randomInterval = TimeInterval(arc4random_uniform(UInt32(interval)))
    return initial.addingTimeInterval(randomInterval)
  }
  
  static func randomWithinDaysBeforeToday(_ days: Int) -> Date {
    let today = Date()
    let daysBeforeToday = today.addingTimeInterval(TimeInterval(-days*24*60*60))
    return Date.random(between: daysBeforeToday, and: today)
  }
}
