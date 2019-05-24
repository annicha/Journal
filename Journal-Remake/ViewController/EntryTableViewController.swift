//
//  EntryTableViewController.swift
//  Journal-Remake
//
//  Created by Annicha on 4/5/19.
//  Copyright © 2019 Annicha Hanwilai. All rights reserved.
//

import UIKit

class EntryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Journal"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        let selectedEntry = EntryController.shared.entries[indexPath.row]
        let dateFormatter = DateFormatter()
        let dateString = dateFormatter.string(from: selectedEntry.timestamp)
        
        cell.textLabel?.text = selectedEntry.title
        cell.detailTextLabel?.text = dateString
        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let selectedEntry = EntryController.shared.entries[indexPath.row]
            EntryController.shared.removeEntry(entry: selectedEntry)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            // Get the new view controller using segue.destination.
            guard let landingPath = segue.destination as? EntryDetailViewController,
            let selectedIndex = tableView.indexPathForSelectedRow?.row else { return }
            // Pass the selected object to the new view controller.
            let entryToPass = EntryController.shared.entries[selectedIndex]
            landingPath.entry = entryToPass
        }
        
    }
    
}
