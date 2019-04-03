//
//  Commands.swift
//  AutoCatalog
//
//  Created by STUDENT on 02/04/2019.
//  Copyright © 2019 STUDENT. All rights reserved.
//

import Foundation

enum Commands: String {
    
    case help
    case list
    case add
    case remove
    case update
    case exit
    
    static private func helpCommand(_: CarsStorage? = nil, _: Int? = nil) {
        
        let sortedCommands = allCommands.sorted  {
            switch $0.key {
            case self.help: return true
            case self.exit: return false
            default: return $0.key.rawValue < $1.key.rawValue
            }
        }
        
        for (command, value) in sortedCommands {
            print("\(command.rawValue) - \(value.description)")
        }
    }
    
    static private func listCommand(from carsStorage: CarsStorage?, _: Int? = nil) {
        guard let cars = carsStorage?.cars else { return }
        
        for (index, car) in cars.enumerated() {
            print("\(index) : \(car)")
        }
    }
    
    static private func addCommand(to carsStorage: CarsStorage? = nil, _: Int? = nil) {
        guard let carsStorage = carsStorage else { return }
        
        if carsStorage.append(car: Car()) {
            updateCommand(from: carsStorage, for: carsStorage.cars.count - 1)
        }
    }
    
    static private func removeCommand(from carsStorage: CarsStorage?, for index: Int? = nil) {
        
        guard let carsStorage = carsStorage else { return }
        
        let index: Int = index ?? readRightIndex(for: carsStorage)
        
        if index >= 0 && index < carsStorage.cars.count {
            _ = carsStorage.remove(car: carsStorage.cars[index])
        }
    }
    
    static private func updateCommand(from carsStorage: CarsStorage?, for index: Int? = nil) {
        
        guard let carsStorage = carsStorage else { return }
        
        let index: Int = index ?? readRightIndex(for: carsStorage)
        
        if index >= 0 && index < carsStorage.cars.count {
            
            let oldCar = carsStorage.cars[index]
            let newCar = Car()
            
            for property in Car.Property.allValues {
                
                print("\tenter \(property.rawValue) ('\(oldCar[property])') >> ", separator: "", terminator: "")
                
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
    
    static private func exitCommand(_: CarsStorage? = nil, _: Int? = nil) {
        print("\nI'll be miss you! 😢\n")
    }
    
    static private func readRightIndex(for carsStorage: CarsStorage) -> Int {
        
        while true {
            
            print("\tenter index >> ", separator: "", terminator: "")
            let str = readLine()
            
            if let str = str, let index = Int(str) {
                return index
            } else {
                listCommand(from: carsStorage)
            }
        }
    }
    
    static let allCommands: [Commands: (description: String, command: (CarsStorage?, Int?) -> Void)] = [
        .help: ("print list of commands", helpCommand),
        .list: ("print list of cars from storage", listCommand),
        .add: ("add a new car into storage", addCommand),
        .remove: ("remove a car from storage by index (optional allows index as a second parameter)", removeCommand),
        .update: ("update a car in storage by index (optional allows index as a second parameter)", updateCommand),
        .exit: ("exit from application", exitCommand)
    ]
}
