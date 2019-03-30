//
//  main.swift
//  AutoCatalog
//
//  Created by STUDENT on 30/03/2019.
//  Copyright © 2019 STUDENT. All rights reserved.
//

import Foundation

class Car: Codable {
    
    let year: Int
    let model: String
    let manufacturer: String
    let `class`: String
    let bodyType: String
}

extension Car: Hashable {
    
    static func == (lhs: Car, rhs: Car) -> Bool {
        return lhs.year == rhs.year
            && lhs.model == rhs.model
            && lhs.manufacturer == rhs.manufacturer
            && lhs.class == rhs.manufacturer
            && lhs.bodyType == rhs.bodyType
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(year)
        hasher.combine(model)
        hasher.combine(manufacturer)
        hasher.combine(self.class)
        hasher.combine(bodyType)
    }
}

class CarsStorage {
    
    private var cars = [Car]()
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
        return true
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
