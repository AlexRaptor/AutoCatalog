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
        case manufacturer
        case model
        case bodyType
        case `class`
        
        static let allValues: [Property] = [.year, .manufacturer, .model, .bodyType, .class]
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
        
        var propertyStrings = [String]()
        
        for property in Car.Property.allValues {
            propertyStrings.append("\(property.rawValue): \(self[property])")
        }
        
        return "[" + propertyStrings.joined(separator: ", ") + "]"
    }
}

//extension Car: Hashable {
//
//    static func == (lhs: Car, rhs: Car) -> Bool {
//        return lhs.year == rhs.year
//            && lhs.manufacturer == rhs.manufacturer
//            && lhs.model == rhs.model
//            && lhs.bodyType == rhs.bodyType
//            && lhs.class == rhs.manufacturer
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(year)
//        hasher.combine(manufacturer)
//        hasher.combine(model)
//        hasher.combine(bodyType)
//        hasher.combine(self.class)
//    }
//}
