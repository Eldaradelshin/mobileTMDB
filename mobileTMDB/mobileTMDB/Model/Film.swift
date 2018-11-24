//
//  Film.swift
//  mobileTMDB
//
//  Created by rushan adelshin on 24.11.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import Foundation

struct Film {
    
let id: Int
let title: String
let vote_average: String
let poster_path: String
let release_date: String
let overview: String
let original_language: String
    
  init (json: [String: Any]) {
        id = json["id"] as? Int ?? -1
        title = json["title"] as? String ?? ""
        vote_average = json["vote_average"] as? String  ?? ""
        poster_path = json["poster_path"] as? String ?? ""
        release_date = json["release_date"] as? String ?? ""
        overview = json["overview"] as? String ?? ""
        original_language = json["original_language"] as? String ?? ""
    }
    
}
