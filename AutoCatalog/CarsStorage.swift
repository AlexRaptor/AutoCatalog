//
//  CarsStorage.swift
//  AutoCatalog
//
//  Created by STUDENT on 02/04/2019.
//  Copyright © 2019 STUDENT. All rights reserved.
//

import Foundation

class CarsStorage {
    
    internal private(set) var cars = [Car]()
    private lazy var fileURL: URL = {
        let directoryURL = FileManager.default.homeDirectoryForCurrentUser
        return directoryURL.appendingPathComponent("cars.data")
    }()
    
    init() {
        load()
    }
    
    private func save() -> Bool {
        
        do {
            
            let data = try JSONEncoder().encode(cars)
            try data.write(to: fileURL)
            
            return true
            
        } catch {
            return false
        }
    }
    
    @discardableResult
    private func load() -> Bool {
        
        do {
            
            let data = try Data(contentsOf: fileURL)
            cars = try JSONDecoder().decode([Car].self, from: data)
            
            return true
            
        } catch {
            return false
        }
    }
    
    func append(car: Car) -> Bool {
        
        assert(!cars.contains { car === $0 })
        cars.append(car)
        return save()
    }
    
    func remove(car: Car) -> Bool {
        
        assert(cars.contains { car === $0 })
        cars.removeAll { $0 === car }
        return save()
    }
    
    func modify(car: Car, with newCar: Car) -> Bool {
        
        assert(cars.contains { car === $0 })
        
        if let index = cars.firstIndex(where: { car === $0 }) {
            cars[index] = newCar
            return save()
        }
        
        return false
    }
}
