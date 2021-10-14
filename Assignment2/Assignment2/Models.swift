//
//  Models.swift
//  Assignment2
//
//  Created by Lebedeva Alice on 22.09.2021.
//

import Foundation
import SwiftUI

struct Person: Identifiable, Equatable, Hashable{
    var id = UUID()
    
    var name: String
    var phone: String
    var gender: String
    var image: Image {
        Image(gender)
    }
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.phone == rhs.phone
    }
}
