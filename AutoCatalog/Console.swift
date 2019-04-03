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
        
        print("\nHello!")
        
        var exitComand = Comands.exit
        
        repeat {
        
            print("\nenter comand ('help' for list) >> ", separator: "", terminator: "")
            let str = readLine()
            
            guard var strCmd = str else { continue }
            
            let components = strCmd.components(separatedBy: " ")
            
            strCmd = components[0]
            
            guard let comand = Comands.init(rawValue: strCmd) else { continue }
            
            var index: Int? = nil
            if components.count > 1 {
                index = Int(components[1])
            }
            
            Comands.allComands[comand]?(storage, index)
            
            exitComand = comand
            
        } while exitComand != .exit
    }
}
