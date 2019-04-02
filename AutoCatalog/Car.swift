//
//  Car.swift
//  AutoCatalog
//
//  Created by STUDENT on 02/04/2019.
//  Copyright © 2019 STUDENT. All rights reserved.
//

import Foundation

class Car: Codable {
    
    enum Property: String {
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

extension Car: CustomStringConvertible {
    var description: String {
        return Property.allValues.reduce(into: "") { (acc, property) in
            acc += property.rawValue + ": " + self[property] + ", "
        }
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
