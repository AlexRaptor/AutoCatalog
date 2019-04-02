//
//  Console.swift
//  AutoCatalog
//
//  Created by STUDENT on 02/04/2019.
//  Copyright © 2019 STUDENT. All rights reserved.
//

import Foundation

class Console {
    
    private let storage = CarsStorage()
    
    func run() {
        
        var exit = false
        
        repeat {
        
            print(">> ", separator: "", terminator: "")
            let str = readLine()
            
            guard let strCmd = str, let comand = Comands.init(rawValue: strCmd) else { continue }
            
            Comands.allComands[comand](storage, nil)
            
        } while !exit
    }
}
