//
//  Comands.swift
//  AutoCatalog
//
//  Created by STUDENT on 02/04/2019.
//  Copyright © 2019 STUDENT. All rights reserved.
//

import Foundation

enum Comands: String {
    
    case help
    case printAll
    case add
    case remove
    case update
    case exit
    
    static private func helpComand(_: CarsStorage? = nil, _: Int? = nil) {
        for (comand, _) in allComands {
            print(comand.rawValue)
        }
    }
    
    static private func printAllComand(from carsStorage: CarsStorage?, _: Int? = nil) {
        guard let cars = carsStorage?.cars else { return }
        
        for (index, car) in cars.enumerated() {
            print("\(index) : \(car)")
        }
    }
    
    static private func addComand(to carsStorage: CarsStorage? = nil, _: Int? = nil) {
        guard let carsStorage = carsStorage else { return }
        
        if carsStorage.append(car: Car()) {
            updateComand(from: carsStorage, for: carsStorage.cars.count - 1)
        }
    }
    
    static private func removeComand(from carsStorage: CarsStorage?, for index: Int? = nil) {
        if let carsStorage = carsStorage, let index = index,
            index >= 0 && index < carsStorage.cars.count {
            _ = carsStorage.remove(car: carsStorage.cars[index])
        }
    }
    
    static private func updateComand(from carsStorage: CarsStorage?, for index: Int? = nil) {
        
        if index == nil {
            
            repeat
            
        }
        
        if let carsStorage = carsStorage, let index = index,
            index >= 0 && index < carsStorage.cars.count {
            
            let car = carsStorage.cars[index]
            
            for property in Car.Property.allValues {
                
                print("\(property.rawValue) >> ", separator: "", terminator: "")
                
                let str = readLine()
                
                if let str = str, !str.isEmpty {
                    car[property] = str
                }
            }
        }
    }
    
    static private func exitComand(_: CarsStorage? = nil, _: Int? = nil) {
    }
        
    static let allComands: [Comands: (CarsStorage?, Int?) -> Void] = [
        .help: helpComand,
        .printAll: printAllComand,
        .add: addComand,
        .remove: removeComand,
        .update: updateComand,
        .exit: exitComand
    ]
}
