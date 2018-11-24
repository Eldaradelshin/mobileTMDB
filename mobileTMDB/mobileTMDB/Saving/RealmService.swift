//
//  RealmService.swift
//  mobileTMDB
//
//  Created by rushan adelshin on 25.11.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    func saveFilmData(filmToSave: Film) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(filmToSave)
            print("\(filmToSave.title) was saved")
            try realm.cancelWrite()
        } catch {
            print(error)
        }
    }
    func loadFilms() -> [Film]{
        var filmsToReturn = [Film]()
        do {
            let realm = try Realm()
            
            let savedFilms = realm.objects(Film.self)
            
            filmsToReturn = Array(savedFilms)
        } catch {
            print(error)
        }
        return filmsToReturn
    }
    
}
