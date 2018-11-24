//
//  PopularFilmsTable.swift
//  mobileTMDB
//
//  Created by rushan adelshin on 24.11.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import UIKit

class PopularFilmsTable: UITableViewController {

    let requestService = RequestService()
    var popularFilms = [Film]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestService.requestNewFilms(completion: {[weak self] filmsArray in
            self?.popularFilms = filmsArray
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
            
        })
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return popularFilms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "popularFilmCell", for: indexPath) as! PopularFilmCell

        
        // Configure the cell...
        cell.title.text = popularFilms[indexPath.row].title
        cell.releaseDate.text = popularFilms[indexPath.row].release_date
        
        let imgPath = popularFilms[indexPath.row].poster_path
        let baseUrl = "https://image.tmdb.org/t/p/original"
        let fullUrl = "\(baseUrl)\(imgPath)"
        let imgurl:URL = URL(string: fullUrl)!
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf:imgurl) {
                DispatchQueue.main.async {
                cell.posterView.image = UIImage(data: data)
                }
            }
        }
        return cell
    }
}
