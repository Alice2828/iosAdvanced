//
//  Models.swift
//  Assignment3BigImages
//
//  Created by Lebedeva Alice on 14.10.2021.
//

import Foundation
import SwiftUI

struct Picture: Identifiable, Equatable, Hashable{
    var id = UUID()
    
    var name: String
    var imageString: String
    
    static func ==(lhs: Picture, rhs: Picture) -> Bool {
           return lhs.name == rhs.name && lhs.id == rhs.id  && lhs.imageString == rhs.imageString
       }
}
