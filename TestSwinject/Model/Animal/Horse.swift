//
//  Horse.swift
//  TestSwinject
//
//  Created by Bruce Chen on 2022/9/4.
//

import Foundation

class Horse: Animal {
    
    let name: String
    let running: Bool

    init(name: String, running: Bool) {
        self.name = name
        self.running = running
    }

    convenience init(name: String) {
        self.init(name: name, running: false)
    }
}
