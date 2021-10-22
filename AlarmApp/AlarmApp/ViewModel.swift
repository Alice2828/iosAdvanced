//
//  ViewModel.swift
//  AlarmApp
//
//  Created by Lebedeva Alice on 22.10.2021.
//

import Foundation

final class ViewModel: ObservableObject {
    @Published var alarms: [Alarm] = [Alarm(name: "Lunch", time: "13:00", isSwitchOn: true), Alarm(name: "Lecture", time: "14:00", isSwitchOn: false)]
    
    func removeAlarm(offsets: IndexSet){
        alarms.remove(atOffsets: offsets)
    }
    
    func removeAlarm(index: Int){
        alarms.remove(at: index)
    }
    
    func checkEmpty() -> Bool{
        return alarms.isEmpty
    }
    
    func getIndexOf(alarm: Alarm) -> Int{
        return alarms.firstIndex{ $0 == alarm } ?? 0
    }
    
    func addAlarm(alarm: Alarm){
        alarms.append(alarm)
    }
    
    func changeAlarm(alarm: Alarm, name: String, time: String){
        let old = alarms.first{$0 == alarm}
        old?.name = name
        old?.time = time
    }
}
