//
//  ContentView.swift
//  Assignment2
//
//  Created by Lebedeva Alice on 17.09.2021.
//

import SwiftUI

struct PeopleList: View {
    @ObservedObject var contactsViewModel: ContactsViewModel
    var body: some View {
        ZStack{
            if contactsViewModel.checkEmpty() {
                Text("No contacts yet...")
                    .font(.headline)
            }
            else{
                List {
                    ForEach(contactsViewModel.people, id: \.self) { person in
                        PersonRow(person: person, contactsViewModel: contactsViewModel)
                    } .onDelete(perform: delete)
                }
            }
        }
    }
    func delete(at offsets: IndexSet) {
        contactsViewModel.removeContact(offsets: offsets)
    }
}

struct PersonRow: View {
    @State var person: Person
    @ObservedObject var contactsViewModel: ContactsViewModel
    
    var body: some View {
        NavigationLink(destination: DetailsView(person: $person, contactsViewModel: contactsViewModel)) {
            HStack {
                person.image
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding()
                
                VStack(alignment: .leading, spacing: 10, content: {
                    Text(person.name).multilineTextAlignment(.leading).font(.system(size: 20,  weight: .heavy))
                    Text(person.phone).multilineTextAlignment(.leading)
                })
                Spacer()
            }
        }
    }
}

struct ToolbarAddContact: ToolbarContent{
    @ObservedObject var contactsViewModel: ContactsViewModel
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            NavigationLink(destination: AddNewView(contactsViewModel: contactsViewModel)) {
                Button(action: {})
                {
                    Label("Add", systemImage: "plus")
                }
            }
        }
    }
}

struct ContentView: View {
    @ObservedObject var contactsViewModel = ContactsViewModel()
    
    var body: some View {
        
        VStack{
            NavigationView {
                PeopleList(contactsViewModel: contactsViewModel)
                    .navigationTitle("Contacts")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarAddContact(contactsViewModel: contactsViewModel)
                    }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
