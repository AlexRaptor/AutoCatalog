//
//  main.swift
//  AutoCatalog
//
//  Created by STUDENT on 30/03/2019.
//  Copyright © 2019 STUDENT. All rights reserved.
//

import Foundation

class Car: Codable {
    enum Property {
        case year
        case model
        case manufacturer
        case `class`
        case bodyType
        
        static let allValues: [Property] = [.year, .model, .manufacturer, .class, .bodyType]
    }
    
    private var data: [String] = []
    
    subscript(property: Property) -> String {
        get {
            if let index = Property.allValues.firstIndex(of: property), index < data.count {
                return data[index]
            }
            return ""
        }
        set {
            if let index = Property.allValues.firstIndex(of: property){
                while data.count <= index {
                    data.append("")
                }
                data[index] = newValue
            }
        }
    }
    
    init() {
        
        data = [String](repeating: "", count: Property.allValues.count)
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        data = try container.decode([String].self)
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        try container.encode(data)
    }
}

//extension Car: Hashable {
//
//    static func == (lhs: Car, rhs: Car) -> Bool {
//        return lhs.year == rhs.year
//            && lhs.model == rhs.model
//            && lhs.manufacturer == rhs.manufacturer
//            && lhs.class == rhs.manufacturer
//            && lhs.bodyType == rhs.bodyType
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(year)
//        hasher.combine(model)
//        hasher.combine(manufacturer)
//        hasher.combine(self.class)
//        hasher.combine(bodyType)
//    }
//}

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

let car = Car()
car[.manufacturer] = "BMW"
