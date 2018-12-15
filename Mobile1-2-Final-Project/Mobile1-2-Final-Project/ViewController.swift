//
//  ViewController.swift
//  Mobile1-2-Final-Project
//
//  Created by Ricardo Rodriguez on 12/13/18.
//  Copyright © 2018 Ricardo Rodriguez. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var entries: [AnimeEntry] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let onepiece = AnimeEntry(watchStatus: .watching, title: "One Piece", rating: 9)
        let dbs = AnimeEntry(watchStatus: .completed, title: "Dragon Ball Super", rating: 10)
        let seven = AnimeEntry(watchStatus: .completed, title: "Seven Deadly Sins", rating: 8)
        let tokyo = AnimeEntry(watchStatus: .notstarted, title: "Tokyo Ghoul", rating: 5)
        
        entries = [onepiece, dbs, seven, tokyo]
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "anime entry cell", for: indexPath) as! AnimeEntryTableViewCell
        
        let entry = entries[indexPath.row]
        cell.labelAnimeTitle.text = entry.title
        cell.labelAnimeWatchingStatus.text = entry.watchStatus.watchingStatus
        cell.imageAnimeThumbnail.image = UIImage(named: "ComingSoon")

        cell.labelAnimeRating.text = "Rating: \(entry.rating)/10"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            completionHandler(true)
            self.deleteEntry(at: indexPath.row)
        }
        let config = UISwipeActionsConfiguration(actions: [delete])
        config.performsFirstActionWithFullSwipe = false

        return config
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            completionHandler(true)
            self.performSegue(withIdentifier: "show entry details", sender: tableView.cellForRow(at: indexPath))
        }
        edit.backgroundColor = .green
        let config = UISwipeActionsConfiguration(actions: [edit])
        config.performsFirstActionWithFullSwipe = false
        
        return config
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "show new entry":
                guard let entryDetailsViewController = segue.destination as? NewAnimeEntryViewController else {
                    
                    //NOTE: error handling
                    return print("storyboard not set up correctly, 'show entry details' segue needs to segue to a 'NewAnimeEntryViewController'")
                }
                
                entryDetailsViewController.watchStatus = AnimeEntry.WatchStatus.notstarted
                entryDetailsViewController.title = ""
                entryDetailsViewController.rating = 1
                
            case "show entry details":
                guard
                    let selectedCell = sender as? UITableViewCell,
                    let indexPath = tableView.indexPath(for: selectedCell) else {
                        return print("failed to locate index path from sender")
                }
                guard let entryDetailsViewController = segue.destination as? NewAnimeEntryViewController else {
                    return print("storyboard not set up correctly, 'show entry details' segue needs to segue to a 'NewAnimeViewController'")
                }
                let entry = entries[indexPath.row]
                entryDetailsViewController.watchStatus = entry.watchStatus
                entryDetailsViewController.animeTitle = entry.title
                
                entryDetailsViewController.rating = entry.rating
    
                
                print(entry.watchStatus, entry.title, entry.rating)

                entryDetailsViewController.isEditingEntry = true
                entryDetailsViewController.index = indexPath.row
            default: break
            }
        }
    }
    
    @IBAction func unwindToHome(_ segue: UIStoryboardSegue) {
        guard let identifier = segue.identifier else {
            return
        }
        
        guard let NewAnimeEntryViewController = segue.source as? NewAnimeEntryViewController else {
            return print("storyboard unwind segue not set up correctly")
        }
        
        switch identifier {
        case "unwind from save":
            if NewAnimeEntryViewController.isEditingEntry {
                updateEntry(watchStatus: NewAnimeEntryViewController.watchStatus, title: NewAnimeEntryViewController.animeTitle, rating: NewAnimeEntryViewController.rating, at: NewAnimeEntryViewController.index)
                print("from save button and editing an existing entry")
            } else {
               createEntry(watchStatus: NewAnimeEntryViewController.watchStatus, title: NewAnimeEntryViewController.animeTitle, rating: NewAnimeEntryViewController.rating)
            }
            
        case "unwind from cancel":
            print("from cancel button")
        default:
            break
        }
    }
    
    func createEntry(watchStatus: AnimeEntry.WatchStatus, title: String, rating: Int) {
        let newEntry = AnimeEntry(watchStatus: watchStatus, title: title, rating: rating)
        entries.insert(newEntry, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    func updateEntry(watchStatus: AnimeEntry.WatchStatus, title: String, rating: Int, at index: Int) {
        entries[index].watchStatus = watchStatus
        entries[index].title = title
        entries[index].rating = rating

        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    func deleteEntry(at index: Int) {
        entries.remove(at: index)
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
}


