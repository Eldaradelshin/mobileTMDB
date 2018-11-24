//
//  PopularFilmCell.swift
//  mobileTMDB
//
//  Created by rushan adelshin on 24.11.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import UIKit

class PopularFilmCell: UITableViewCell {
    var filmId: Int = 0
    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
}
