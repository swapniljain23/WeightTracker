//
//  ViewController.swift
//  WeightTracker
//
//  Created by Swapnil Jain on 5/26/19.
//  Copyright © 2019 Swapnil Jain. All rights reserved.
//

import UIKit

fileprivate let CELL_IDENTIFIER = "WeightEntry"

class WeightListViewController: UIViewController {

  var viewModel: WeightListViewModel!
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Weight Tracker"
    viewModel = WeightListViewModel(persistentManager: PersistentManager())
  }
  
  @IBAction func addWeightEntry() {
    viewModel.addWeightEntry(entry: viewModel.randomWeightEntry())
    tableView.insertRows(at: [IndexPath(row: viewModel.items.count-1, section: 0)],
                         with: UITableView.RowAnimation.automatic)
  }
}

// MARK:- Table view data source, delegate.
extension WeightListViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER)
    if cell == nil {
      cell = UITableViewCell(style: .default, reuseIdentifier: CELL_IDENTIFIER)
    }
    let weightEntry = viewModel.items[indexPath.row]
    cell?.textLabel?.text = weightEntry.dateInText
    cell?.detailTextLabel?.text = weightEntry.weightInLbInText
    return cell!
  }
  
  func tableView(_ tableView: UITableView,
                 commit editingStyle: UITableViewCell.EditingStyle,
                 forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      viewModel.removeWeightEntry(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
}


