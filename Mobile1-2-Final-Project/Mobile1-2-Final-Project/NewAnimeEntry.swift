//
//  NewAnimeEntry.swift
//  Mobile1-2-Final-Project
//
//  Created by Ricardo Rodriguez on 12/13/18.
//  Copyright © 2018 Ricardo Rodriguez. All rights reserved.
//


import UIKit


class NewAnimeEntryViewController: UIViewController {
    
    var watchStatus = AnimeEntry.WatchStatus.notstarted
    var animeTitle: String = ""
    var rating: Int = 1
    var isEditingEntry = false
    var index = 0


    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelTitle: UITextField!
    @IBOutlet weak var ratingIncrement: UIStepper!
    @IBOutlet weak var watchStatusControl: UISegmentedControl!
    
    
    
    @IBAction func inputAnimeTitle(_ sender: UITextField) {
        guard let title = sender.text else {return}
        animeTitle = title
    }
    

    
    @IBAction func watchStatus(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            watchStatus = .notstarted
        case 1:
            watchStatus = .watching
        case 2:
            watchStatus = .completed
        default:
            watchStatus = .notstarted
        }
    }
    
    
    @IBAction func ratingStepper(_ sender: UIStepper) {
        labelRating.text = "Rating: \(Int(sender.value))/10"
        rating = Int(sender.value)
    }
    
    
    @IBAction func pressSave(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwind from save", sender: nil)

    }
    
    @IBAction func pressCancel(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwind from cancel", sender: nil)
        
    }
    
    func updateUI(){
        if isEditingEntry == true {
            self.title = "Edit Entry"
        } else {
            self.title = "New Anime"
        }
        labelTitle.text = animeTitle
        labelRating.text = "Rating: \(Int(rating))/10"
        ratingIncrement.value = Double(rating)
        
        if watchStatus == AnimeEntry.WatchStatus.notstarted {
            watchStatusControl.selectedSegmentIndex = 0
        }else if watchStatus == AnimeEntry.WatchStatus.watching {
            watchStatusControl.selectedSegmentIndex = 1
        }else if watchStatus == AnimeEntry.WatchStatus.completed {
            watchStatusControl.selectedSegmentIndex = 2
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
}
