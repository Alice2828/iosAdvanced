//
//  EditView.swift
//  AlarmApp
//
//  Created by Lebedeva Alice on 22.10.2021.
//

import SwiftUI

struct EditView: View {
    
    private let data: [[String]] = [
        Array(0...23).map { String(format: "%02d",$0) },
           Array(0...60).map { String(format: "%02d",$0) }
       ]

    @State var selections: [Int] = [0,0]
    @ObservedObject var alarm: Alarm
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var newName: String = ""
    
    func convertString(string: String) -> Double {
        guard let doubleString = Double(string) else { return 0 }
        return doubleString
    }
    
    private func goBack() {
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack {
            Spacer()
            PickerView(data: self.data, selections: self.$selections).padding().pickerStyle(WheelPickerStyle())
            EnterEditedName(newName: $newName)
            Spacer()
            DeleteButton(alarm: alarm, action: goBack, viewModel: viewModel)
            ChangeBtn(newName: $newName, selections: $selections, viewModel: viewModel, alarm: alarm, action: goBack)
        }.navigationTitle("Change alarm")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            self.newName = alarm.name
            self.selections = alarm.time.components(separatedBy:":").map{Int($0) ?? 0}
        }
    }
}

struct EnterEditedName: View{
    @Binding var newName: String
    
    var body: some View {
        TextField("Enter name", text: $newName)
            .padding().background(Color(UIColor.white))
            .border(Color.gray)
            .cornerRadius(5.0)
            .padding(20)
    }
}

struct ChangeBtn: View{
    @Binding var newName: String
    @Binding var selections: [Int]
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var alarm: Alarm
    let action: MethodToDismiss
    
    var body: some View{
        Button("Change", action: {
            viewModel.changeAlarm(alarm: alarm, name: newName, time: "\(String(format:"%02d",selections[0])):\(String(format:"%02d",selections[1]))")
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
