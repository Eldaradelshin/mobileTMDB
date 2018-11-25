//
//  SavingService.swift
//  mobileTMDB
//
//  Created by rushan adelshin on 25.11.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class SavingService {
    
    func saveMovieData(filmToSave: Film) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FilmData", in: managedContext)!
        let filmData = NSManagedObject(entity: entity, insertInto: managedContext)
        filmData.setValue(filmToSave.id, forKey: "id")
        filmData.setValue(filmToSave.title, forKey: "title")
        filmData.setValue(filmToSave.original_language, forKey: "original_language")
        filmData.setValue(filmToSave.overview, forKey: "overview")
        filmData.setValue(filmToSave.poster_path, forKey: "poster_path")
        filmData.setValue(filmToSave.release_date, forKey: "release_datw")
        filmData.setValue(filmToSave.vote_average, forKey: "vote_average")
        
        do {
            try managedContext.save()
        } catch let err as NSError {
          print(err.localizedDescription)
        }
    }
    
    func fetchMovieData() -> [NSManagedObject] {
        var filmsToReturn = [NSManagedObject]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FilmData")
        do {
            let savedFilms = try managedContext.fetch(fetchRequest)
            filmsToReturn = savedFilms
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return filmsToReturn
    }
}
