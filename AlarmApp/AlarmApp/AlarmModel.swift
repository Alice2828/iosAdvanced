//
//  AlarmModel.swift
//  AlarmApp
//
//  Created by Lebedeva Alice on 22.10.2021.
//

import Foundation
import SwiftUI

class Alarm: Identifiable, Equatable, Hashable, ObservableObject{
    var id = UUID()
    
    @Published var name: String = ""
    @Published var time: String = ""
    @Published var isSwitchOn: Bool = false
    
    init(name: String, time: String, isSwitchOn: Bool){
        self.name = name
        self.time = time
        self.isSwitchOn = isSwitchOn
    }
    
    static func ==(lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.name == rhs.name && lhs.time == rhs.time
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
