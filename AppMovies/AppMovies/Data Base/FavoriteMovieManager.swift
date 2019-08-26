//
//  CoreDataManager.swift
//  AppMovies
//
//  Created by Vinicius Rodrigues on 26/08/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
import CoreData

class FavoriteMovieManager {
    
    enum Response<T> {
        case success(T?)
        case failure(FavoriteManagerError?)
    }
    
    enum FavoriteManagerError: String {
        case saveError = "Error"
        case loadError = "Error 1"
        case deleteError = "Error 2"
    }
    
    typealias ResponseBlock<T> = (_ reponse: Response<T>) -> Void
    static let shared = FavoriteMovieManager()
    private var favoriteMovies: [FavoriteMovie] = []
    
    fileprivate init(){
    }
    
    func saveFavoriteMovie(with context: NSManagedObjectContext, completion: @escaping FavoriteMovieManager.ResponseBlock<Bool>)  {
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
            completion(.failure(.saveError))
        }
        completion(.success(true))
    }
    
    func loadFavoriteMovie(with context: NSManagedObjectContext, completion: @escaping FavoriteMovieManager.ResponseBlock<[FavoriteMovie]>)  {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "titleFavoriteMovie", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            favoriteMovies = try context.fetch(fetchRequest)
            
        } catch  {
            print(error.localizedDescription)
            completion(.failure(.loadError))
        }
        completion(.success(favoriteMovies))
    }
    
    func deleteFavoriteMovie(index: Int, context: NSManagedObjectContext, completion: @escaping FavoriteMovieManager.ResponseBlock<Bool>)  {
        let movie = favoriteMovies[index]
        context.delete(movie)
        do {
            try context.save()
            print("delete")
        } catch  {
            print(error.localizedDescription)
            completion(.failure(.deleteError))
        }
        completion(.success(true))
    }
    
}
