//
//  FavFilmDetailsViewController.swift
//  mobileTMDB
//
//  Created by rushan adelshin on 25.11.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import UIKit
import CoreData

class FavFilmDetailsViewController: UIViewController {
    
    var favFilmForDetails = [NSManagedObject]()

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var textOverview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = (favFilmForDetails[0].value(forKey: "title") as! String)
        self.textOverview.text = (favFilmForDetails[0].value(forKey: "overview") as! String)
        let imgPath = (favFilmForDetails[0].value(forKey: "poster_path") as! String)
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
