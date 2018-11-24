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
    var searchedFilms = [Film]()
    let filmsSearchController = UISearchController(searchResultsController: nil)
    
    
    func searchBarIsEmpty() -> Bool {
        //returns true if the text is empty or nil
        return filmsSearchController.searchBar.text?.isEmpty ?? true
    }
    func isFiltering() -> Bool {
        return filmsSearchController.isActive && !searchBarIsEmpty()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmsSearchController.searchResultsUpdater = self
        filmsSearchController.hidesNavigationBarDuringPresentation = false
        filmsSearchController.dimsBackgroundDuringPresentation = true
        let searchBar = filmsSearchController.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Looking for movie?"
        definesPresentationContext = true
        self.tableView.tableHeaderView = searchBar
        
        requestService.requestNewFilms(completion: {[weak self] filmsArray in
            self?.popularFilms = filmsArray
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
            
        })
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() || searchedFilms.count != 0 {
            return searchedFilms.count
        } else {
            return popularFilms.count
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "popularFilmCell", for: indexPath) as! PopularFilmCell
        var selectedFilm: Film
        
        if isFiltering() || searchedFilms.count != 0 {
            selectedFilm = searchedFilms[indexPath.row]
        } else {
            selectedFilm = popularFilms[indexPath.row]
        }
        // Configure the cell...
        cell.title.text = selectedFilm.title
        cell.releaseDate.text = selectedFilm.release_date
        cell.filmId = selectedFilm.id
        
        let imgPath = selectedFilm.poster_path
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "show" {
            let cell = sender as! PopularFilmCell
            let selectedFilmForDetails: [Film]
            if isFiltering() || searchedFilms.count != 0 {
            selectedFilmForDetails = searchedFilms.filter({$0.id == cell.filmId})
            } else {
              selectedFilmForDetails = popularFilms.filter({$0.id == cell.filmId})
            }
            
            if selectedFilmForDetails.count == 0 {
                fatalError()
            }
            
            let filmDetailVC = segue.destination as! FilmDetailsVC
            filmDetailVC.selectedDetailedFilm = selectedFilmForDetails
            //print(filmDetailVC.selectedDetailedFilm[0].title)
            self.searchedFilms.removeAll()
            self.tableView.reloadData()
        }
    }
}

extension PopularFilmsTable: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchBarText = searchController.searchBar.text else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
          
            self.requestService.requestFilmForQuery(query: searchBarText, completion: {[weak self] matchingMovies in
                if matchingMovies.count != 0 {
                    self?.searchedFilms = matchingMovies
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                    
                }
            })
            self.tableView.reloadData()
        })
    }
}

