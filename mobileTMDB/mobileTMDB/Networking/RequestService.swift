//
//  RequestService.swift
//  mobileTMDB
//
//  Created by rushan adelshin on 24.11.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import Foundation

class RequestService {
    func requestNewFilms(completion: @escaping ([Film]) -> Void) {
        let session = URLSession(configuration: .default)
        
        var dataTask: URLSessionDataTask?
        let url = "https://api.themoviedb.org/3/discover/movie"
        let token = "5af1f0932fb5ebe64532f6670ac06d18"
        var items = [URLQueryItem]()
        var myUrl = URLComponents(string: url)
        let parameters = [                  "api_key" : token,
                           "primary_release_date.gte" : "2018-11-14",
                           "primary_release_date.lte" : "2018-12-10"  ]
        for (key, value) in parameters {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        myUrl?.queryItems = items
        let request = URLRequest(url: (myUrl?.url)!)
        dataTask = session.dataTask(with: request, completionHandler: { data, response, error in
            if error == nil {
                let recievedData = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: Any]
                let innerArray = recievedData!["results"] as! [[String: Any]]
                var films = [Film]()
                for filmDict in innerArray {
                    if let film = Film(json: filmDict) {
                    films.append(film)
                }
             completion(films)
            }
        }
        })
        dataTask?.resume()
}
    
    func requestFilmForQuery(query:String, completion: @escaping ([Film]) -> Void) {
        let session = URLSession(configuration: .default)
        
        var dataTask: URLSessionDataTask?
        let url = "https://api.themoviedb.org/3/search/movie"
        let token = "5af1f0932fb5ebe64532f6670ac06d18"
        var items = [URLQueryItem]()
        var myUrl = URLComponents(string: url)
        let parameters = [ "api_key" : token,
                             "query" : query ]
        for (key, value) in parameters {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        myUrl?.queryItems = items
        let request = URLRequest(url: (myUrl?.url)!)
        dataTask = session.dataTask(with: request, completionHandler: {data, response, error in
            if error == nil {
                let recievedData = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: Any]
                guard let innerArray = recievedData!["results"] as? [[String: Any]]  else { return }
                
                var films = [Film]()
                
                if innerArray.isEmpty != true {
                for filmDict in innerArray {
                    if let film = Film(json: filmDict) {
                    films.append(film)
                    }
                }
            }
                completion(films)
            }
        
        })
        dataTask?.resume()
        
    }
}
