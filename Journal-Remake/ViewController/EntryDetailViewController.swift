//
//  EntryDetailViewController.swift
//  Journal-Remake
//
//  Created by Annicha on 4/5/19.
//  Copyright © 2019 Annicha Hanwilai. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var entryTextView: UITextView!
    
    // MARK: - Propertiess
    var entry: Entry?

    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "New Entry"
        setUpLabels()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard !entryTextView.text.isEmpty,
            let title = titleTextField.text,
            let entryText = entryTextView.text else { return }
        
        
        if let entry = entry {
            EntryController.shared.updateEntry(entry: entry, title: title, bodyText: entryText)
        } else {
            // create
            EntryController.shared.addEntry(withTitle: title, bodyText: entryText)
        }
        
        navigationController?.popViewController(animated: true)

    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        entryTextView.text = ""
    }
    
    // MARK: - Functions
    func setUpLabels() {
        guard let entry = entry else { return }
        navigationItem.title = entry.title
        titleTextField.text = entry.title
        entryTextView.text = entry.bodyText
    }

}
