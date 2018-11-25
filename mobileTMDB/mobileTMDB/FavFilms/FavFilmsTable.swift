//
//  FavFilmsTable.swift
//  mobileTMDB
//
//  Created by rushan adelshin on 24.11.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import UIKit
import CoreData

class FavFilmsTable: UITableViewController {

    var favFilms = [NSManagedObject]()
    let savingService = SavingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    favFilms = savingService.fetchMovieData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favFilms = savingService.fetchMovieData()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favFilms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favFilmCell", for: indexPath) as! FavFilmCell
        let favFilm = favFilms[indexPath.row]
        cell.titleLabel.text = (favFilm.value(forKey: "title") as! String)
        cell.dateLabel.text = (favFilm.value(forKey: "release_datw") as! String)
        cell.filmId = (favFilm.value(forKey: "id") as! Int)
        let imgPath = (favFilm.value(forKey: "poster_path") as! String)
        let baseUrl = "https://image.tmdb.org/t/p/original"
        let fullUrl = "\(baseUrl)\(imgPath)"
        let imgurl:URL = URL(string: fullUrl)!
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf:imgurl) {
                DispatchQueue.main.async {
                    cell.posterImage.image = UIImage(data: data)
                }
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            let cell = sender as! FavFilmCell
            let favFilmForDetails = favFilms.filter({($0.value(forKey: "id") as! Int) == cell.filmId})
            if favFilmForDetails.count == 0 {
                fatalError()
            }
            let favFilmDetailVC = segue.destination as! FavFilmDetailsViewController
            favFilmDetailVC.favFilmForDetails = favFilmForDetails
            
        }
       
    }
    
}
