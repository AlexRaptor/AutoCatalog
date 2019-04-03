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
    case list
    case add
    case remove
    case update
    case exit
    
    static private func helpComand(_: CarsStorage? = nil, _: Int? = nil) {
        
        let sortedCommands = allComands.sorted  {
            switch $0.key {
            case self.help: return true
            case self.exit: return false
            default: return $0.key.rawValue < $1.key.rawValue
            }
        }
        
        for (comand, _) in sortedCommands {
            print(comand.rawValue)
        }
    }
    
    static private func listComand(from carsStorage: CarsStorage?, _: Int? = nil) {
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
        
        let index: Int = index ?? readRightIndex()
        
        if let carsStorage = carsStorage,
            index >= 0 && index < carsStorage.cars.count {
            _ = carsStorage.remove(car: carsStorage.cars[index])
        }
    }
    
    static private func updateComand(from carsStorage: CarsStorage?, for index: Int? = nil) {
        
        let index: Int = index ?? readRightIndex()
        
        if let carsStorage = carsStorage,
            index >= 0 && index < carsStorage.cars.count {
            
            let oldCar = carsStorage.cars[index]
            let newCar = Car()
            
            for property in Car.Property.allValues {
                
                print("\tenter \(property.rawValue) >> ", separator: "", terminator: "")
                
                let str = readLine()
                
                if let str = str, !str.isEmpty {
                    newCar[property] = str
                } else {
                    newCar[property] = oldCar[property]
                }
            }
            
            _ = carsStorage.modify(car: oldCar, with: newCar)
        }
    }
    
    static private func exitComand(_: CarsStorage? = nil, _: Int? = nil) {
        print("\nSee you later!\n")
    }
    
    static private func readRightIndex() -> Int {
        
        while true {
            
            print("\tenter index >> ", separator: "", terminator: "")
            let str = readLine()
            
            if let str = str, let index = Int(str) {
                return index
            }
        }
    }
    
    static let allComands: [Comands: (CarsStorage?, Int?) -> Void] = [
        .help: helpComand,
        .list: listComand,
        .add: addComand,
        .remove: removeComand,
        .update: updateComand,
        .exit: exitComand
    ]
}
