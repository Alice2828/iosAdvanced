//
//  AddNewView.swift
//  Assignment2
//
//  Created by Lebedeva Alice on 22.09.2021.
//

import SwiftUI
import Combine

struct AddNewView: View {
    enum Gender: String, CaseIterable, Identifiable {
        case male
        case female
        
        var id: String { self.rawValue }
    }
    
    @State private var selectedGender = "male"
    @ObservedObject var contactsViewModel: ContactsViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var phone: String = ""
    
    func convertString(string: String) -> Double {
        guard let doubleString = Double(string) else { return 0 }
        return doubleString
    }
    
    private func goBack() {
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack {
            EnterName(name: $name)
            EnterPhone(phone: $phone)
            
            Picker("Please choose gender", selection: $selectedGender) {
                ForEach(Gender.allCases) { option in
                    Text(option.rawValue.capitalized).tag(option)
                }
            }.padding()
            
            Spacer()
            
            AddBtn(name: $name, phone: $phone, contactsViewModel: contactsViewModel, selectedGender: $selectedGender, action: goBack)
        }.navigationTitle("Add contact")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EnterName: View{
    @Binding var name: String
    
    var body: some View {
        TextField("Enter name and surname", text: $name)
            .padding().background(Color(UIColor.white))
            .border(Color.gray)
            .cornerRadius(5.0)
            .padding(20)
    }
}

struct EnterPhone: View{
    @Binding var phone: String
    var body: some View {
        TextField("Enter phone", text: $phone)
            .keyboardType(.numbersAndPunctuation)
            
            .onReceive(Just(phone)) { cleanNum in
                let filtered = cleanNum.filter {"0123456789.-".contains($0)}
                if filtered != cleanNum {
                    self.phone = filtered
                }
            }
            .padding().background(Color(UIColor.white))
            .border(Color.gray)
            .cornerRadius(5.0)
            .keyboardType(.numberPad)
            .padding()
    }
}

struct AddBtn: View{
    @Binding var name: String
    @Binding var phone: String
    @ObservedObject var contactsViewModel: ContactsViewModel
    @Binding var selectedGender: String
    let action: MethodToDismiss
    
    var body: some View{
        Button("Add", action: {
            contactsViewModel.addContact(person: (Person(name: name, phone: phone, gender: selectedGender)))
            self.action()
        })
        .font(.headline)
        .foregroundColor(.white)
        .frame(width: 220, height: 60)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        .background(Color.blue.opacity(0.7))
        .cornerRadius(15.0)
        .padding()
    }
}
//
//struct AddNewView_Previews: PreviewProvider {
//    @Binding private var people: [Person]
//    static var previews: some View {
//        AddNewView(people: $people)
//    }
//}
