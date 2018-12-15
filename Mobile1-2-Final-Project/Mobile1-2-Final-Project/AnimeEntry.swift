//
//  AnimeEntry.swift
//  Mobile1-2-Final-Project
//
//  Created by Ricardo Rodriguez on 12/13/18.
//  Copyright © 2018 Ricardo Rodriguez. All rights reserved.
//

import Foundation

struct AnimeEntry {
    var watchStatus: WatchStatus
    var title: String
    var rating: Int
    
    enum WatchStatus: Int {
        case notstarted
        case watching
        case completed

        
        var watchingStatus: String {
            switch self {
            case .notstarted:
                return "Not Started"
            case .watching:
                return "Watching"
            case .completed:
                return "Completed"

            }
        }
        
        
        
    }
}
