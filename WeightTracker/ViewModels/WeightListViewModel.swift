//
//  WeightListViewModel.swift
//  WeightTracker
//
//  Created by Swapnil Jain on 5/26/19.
//  Copyright © 2019 Swapnil Jain. All rights reserved.
//

import Foundation

protocol WeightListProvider {
  var items: [WeightEntry] { get }
  func addWeightEntry(entry: WeightEntry)
  func removeWeightEntry(at index: Int)
  func randomWeightEntry() -> WeightEntry
}

class WeightListViewModel {
  
  private var persistentManager: PersistentManager
  var items = [WeightEntry]()
  
  init(persistentManager: PersistentManager) {
    self.persistentManager = persistentManager
    loadPersistentWeightData()
  }
  
  func loadPersistentWeightData() {
    do {
      items = try persistentManager.managedContext.fetch(WeightEntry.fetchRequest())
    } catch {
      print("Error fetching weight list from persistent store.")
    }
  }
}

extension WeightListViewModel: WeightListProvider {
  
  func addWeightEntry(entry: WeightEntry) {
    items.append(entry)
    persistentManager.saveContext()
  }
  
  func removeWeightEntry(at index: Int) {
    if index < 0 || index >= items.count {
      return
    }
    let object = items.remove(at: index)
    persistentManager.managedContext.delete(object)
    persistentManager.saveContext()
  }
  
  func randomWeightEntry() -> WeightEntry {
    let randomWeight = Double.random(in: 50...200)
    let randomDate = Date.randomWithinDaysBeforeToday(30)
    return WeightEntry(
        context: persistentManager.managedContext,
        weightInLB: randomWeight,
        date: randomDate as NSDate)
  }
  
}
