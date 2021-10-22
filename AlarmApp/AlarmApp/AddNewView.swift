//
//  AddNewView.swift
//  AlarmApp
//
//  Created by Lebedeva Alice on 22.10.2021.
//

import SwiftUI
import Combine

struct AddNewView: View {
    @Binding var isPresented: Bool
    private let data: [[String]] = [
        Array(0...23).map { String(format: "%02d",$0) },
        Array(0...60).map { String(format: "%02d",$0) }
    ]
    
    @State private var selections: [Int] = [10, 10]
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    
    var btnBack : some View {
        Button(action: {
            goBack()
        }) {
            HStack {
                Image("ic_back") // set image here
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                Text("Cancel")
            }
        }
    }
    
    func convertString(string: String) -> Double {
        guard let doubleString = Double(string) else { return 0 }
        return doubleString
    }
    
    private func goBack() {
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                PickerView(data: self.data, selections: self.$selections).padding().pickerStyle(WheelPickerStyle())
                EnterName(name: $name)
                Spacer()
                
                AddBtn(name: $name, selections: $selections, isPresented: $isPresented, viewModel: viewModel, action: goBack)
            } .navigationTitle("New alarm")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: btnBack)
        }
    }
    
    struct EnterName: View{
        @Binding var name: String
        
        var body: some View {
            TextField("Enter name", text: $name)
                .padding().background(Color(UIColor.white))
                .border(Color.gray)
                .cornerRadius(5.0)
                .padding(20)
        }
    }
    
    struct AddBtn: View{
        @Binding var name: String
        @Binding var selections: [Int]
        @Binding var isPresented: Bool
        @ObservedObject var viewModel: ViewModel
        let action: MethodToDismiss
        
        var body: some View{
            Button("Save", action: {
                viewModel.addAlarm(alarm: (Alarm(name: name, time: "\(String(format:"%02d",selections[0])):\(String(format:"%02d",selections[1]))", isSwitchOn: true)))
                
                isPresented = false
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
}
//
//struct AddNewView_Previews: PreviewProvider {
//    @Binding private var people: [Person]
//    static var previews: some View {
//        AddNewView(people: $people)
//    }
//}
