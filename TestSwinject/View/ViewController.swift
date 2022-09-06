//
//  ViewController.swift
//  TestSwinject
//
//  Created by Bruce Chen on 2022/9/4.
//

import UIKit
import Swinject

extension String {
    static func pointer(_ object: AnyObject?) -> String {
        guard let object = object else { return "nil" }
        let opaque: UnsafeMutableRawPointer = Unmanaged.passUnretained(object).toOpaque()
        return String(describing: opaque)
    }
}

class ViewController: UIViewController {

    let container = Container() { container in
        
        container.register(Animal.self, name: "dog") { _ in Dog(name: "Jack") }.inObjectScope(.graph)
        container.register(Animal.self, name: "turtle") { _ in Turtle(name: "R") }.inObjectScope(.graph)
        
        container.register(Person.self, name: "parent") { r in
            Parent(name: "Jeff", child: r.resolve(Person.self, name:"child")! as! PetOwner, pet: r.resolve(Animal.self, name:"dog")!)
        }.inObjectScope(.graph)
        
        container.register(Person.self, name: "child") { r in
            PetOwner(name: "Jeff", pet: r.resolve(Animal.self, name:"dog")!)
        }.inObjectScope(.graph)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let turtle = container.resolve(Animal.self, name:"turtle")!
        
        let person = container.resolve(Person.self, name: "child")!
        let pet = (person as! PetOwner).pet
        
        print(turtle)
        print(person)
        print(pet)
        
        let parent = container.resolve(Person.self, name: "parent")!
        let pet2 = (parent as! Parent).pet
        
        print(parent)
        print(pet2)
        
    }
    
}

