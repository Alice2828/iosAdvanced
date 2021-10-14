//
//  ContactsViewModel.swift
//  Assignment2
//
//  Created by Lebedeva Alice on 23.09.2021.
//

import SwiftUI

final class ContactsViewModel: ObservableObject {
    @Published var people: [Person] = [Person(name: "Alice", phone: "877733333",gender:"female"), Person(name: "Jack", phone: "877733377575", gender:"male")]
    
    func removeContact(offsets: IndexSet){
        people.remove(atOffsets: offsets)
    }
    
    func removeContact(index: Int){
        people.remove(at: index)
    }
    
    func checkEmpty() -> Bool{
        return people.isEmpty
    }
    
    func getIndexOf(person: Person) -> Int{
        return people.firstIndex{ $0 == person } ?? 0
    }
    
    func addContact(person: Person){
        people.append(person)
    }
}
