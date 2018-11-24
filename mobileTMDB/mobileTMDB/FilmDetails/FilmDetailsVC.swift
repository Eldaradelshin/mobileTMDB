//
//  FilmDetailsVC.swift
//  mobileTMDB
//
//  Created by rushan adelshin on 24.11.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import UIKit

class FilmDetailsVC: UIViewController {
    
    
    var selectedDetailedFilm = [Film]()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var filmRate: UILabel!
    @IBOutlet weak var filmOverview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.text = selectedDetailedFilm[0].title
        filmOverview.text = selectedDetailedFilm[0].overview
        releaseDate.text = "Release: \(selectedDetailedFilm[0].release_date)"
        filmRate.text = "Rate: \(selectedDetailedFilm[0].vote_average)"
        
        let imgPath = selectedDetailedFilm[0].poster_path
        let baseUrl = "https://image.tmdb.org/t/p/original"
        let fullUrl = "\(baseUrl)\(imgPath)"
        let imgurl:URL = URL(string: fullUrl)!
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf:imgurl) {
                DispatchQueue.main.async {
                    self.posterImage.image = UIImage(data: data)
                }
            }
        }
    }

}
