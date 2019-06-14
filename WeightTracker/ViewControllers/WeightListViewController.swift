//
//  ViewController.swift
//  WeightTracker
//
//  Created by Swapnil Jain on 5/26/19.
//  Copyright © 2019 Swapnil Jain. All rights reserved.
//

import UIKit
import CoreData

fileprivate let CELL_IDENTIFIER = "WeightEntry"

class WeightListViewController: UIViewController, NSFetchedResultsControllerDelegate {

  var fetchedResultsController: NSFetchedResultsController<WeightEntry>!
  var persistentManager: PersistentManager!
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Weight Tracker"
    persistentManager = PersistentManager()
    fetchedResultsController = NSFetchedResultsController(
      fetchRequest: WeightEntry.fetchRequest(),
      managedObjectContext: persistentManager.managedContext,
      sectionNameKeyPath: nil,
      cacheName: "WeightEntries")
    fetchedResultsController.delegate = self
    do {
      try fetchedResultsController.performFetch()
    } catch {
      print("Failed to fetch weight entries from persistent store.")
    }
  }
  
  @IBAction func addWeightEntry() {
    persistentManager.managedContext.insert(
      WeightEntry.randomWeightEntry(with: persistentManager.managedContext))
    persistentManager.saveContext()
  }
}

// MARK:- Table view data source, delegate.

extension WeightListViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return fetchedResultsController.sections?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fetchedResultsController.sections?[section].numberOfObjects ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER)
    if cell == nil {
      cell = UITableViewCell(style: .default, reuseIdentifier: CELL_IDENTIFIER)
    }
    let weightEntry = fetchedResultsController.object(at: indexPath)
    cell?.textLabel?.text = weightEntry.dateInText
    cell?.detailTextLabel?.text = weightEntry.weightInLbInText
    return cell!
  }
  
  func tableView(_ tableView: UITableView,
                 commit editingStyle: UITableViewCell.EditingStyle,
                 forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let object = fetchedResultsController.object(at: indexPath)
      persistentManager.managedContext.delete(object)
      persistentManager.saveContext()
    }
  }
  
  // MARK:- NSFetchedResultsControllerDelegate
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                  didChange anObject: Any,
                  at indexPath: IndexPath?,
                  for type: NSFetchedResultsChangeType,
                  newIndexPath: IndexPath?) {
    switch type {
    case .insert:
      tableView.insertRows(at: [newIndexPath!], with: .fade)
    case .delete:
      tableView.deleteRows(at: [indexPath!], with: .fade)
    case .move, .update:
      print("Unsupported type!")
    }
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }

}


