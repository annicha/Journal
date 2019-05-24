//
//  ModelController.swift
//  Journal-Remake
//
//  Created by Annicha on 3/5/19.
//  Copyright © 2019 Annicha Hanwilai. All rights reserved.
//

import Foundation

class EntryController {
    // MARK: - Singleton
    static let shared = EntryController()
    
    // Source of truth
    var entries: [Entry] = []
    
    // private initialization
    private init(){
        entries = loadFromPersistence()
    }
    
    
    // MARK: - CRUD
    
    // CREATE
    func addEntry(withTitle title: String, bodyText: String){
        let entry = Entry(title: title, bodyText: bodyText)
        entries.append(entry)
        saveToPersistenceStore()
    }
    
    // UPDATE
    func updateEntry(entry: Entry, title: String, bodyText: String){
        entry.title = title
        entry.bodyText = bodyText
        print(entry.bodyText)
        saveToPersistenceStore()
        print(entry.bodyText)
    }
    
    // DELETE
    func removeEntry(entry: Entry){
        guard let indexOfEntry = entries.firstIndex(of: entry) else {return}
        entries.remove(at: indexOfEntry)
        saveToPersistenceStore()
    }
    
    // MARK: - Persistent Data
    
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls.first!.appendingPathComponent("entries.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        // Set up JSON encoder
        
        let jsonEncoder = JSONEncoder()
        
        do {
            
            let encodedData = try jsonEncoder.encode(entries)
            try encodedData.write(to: fileURL())
            
        } catch {
            print("There was some error during saving to persistent: \(error)")
        }
    }
    
    func loadFromPersistence() -> [Entry] {
        // Set up JSON encoder
        
        let jsonDecoder = JSONDecoder()

        do {
            let rawData = try Data(contentsOf: fileURL())
            let data = try jsonDecoder.decode([Entry].self, from: rawData)
            return data
            
        } catch  {
            print("There was an error during reading from file: \(error)")
        }
        
        return []
    }
}

