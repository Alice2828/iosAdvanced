//
//  DetailsView.swift
//  AlarmApp
//
//  Created by Lebedeva Alice on 22.10.2021.
//

import SwiftUI

typealias MethodToDismiss = ()->Void

struct DetailsView: View {
    @ObservedObject var alarm: Alarm

    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            ContactDetail(alarm: alarm).padding()
            CallButton(action: goBack).padding()
            DeleteButton(alarm: alarm, action: goBack, viewModel: viewModel).padding()
            Spacer()
        }
        .navigationTitle("Alarm Info")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func goBack() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct ContactDetail: View{
    @ObservedObject var alarm: Alarm
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10, content: {
                Text(alarm.name).multilineTextAlignment(.leading).font(.system(size: 20,  weight: .heavy))
                Text(alarm.time).multilineTextAlignment(.leading)
            })
            Spacer()
        }
    }
}

struct CallButton: View{
    let action: MethodToDismiss
    var body: some View {
        Button("Call", action: action)
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 220, height: 60)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .background(Color.green.opacity(0.7))
            .cornerRadius(15.0)
    }
}

struct DeleteButton: View{
    @ObservedObject var alarm: Alarm
    let action: MethodToDismiss
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        Button("Delete", action: {
            let index = viewModel.getIndexOf(alarm: alarm)
            viewModel.removeAlarm(index: index)
            self.action()
        })
        .font(.headline)
        .foregroundColor(.white)
        .frame(width: 220, height: 60)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        .background(Color.red.opacity(0.7))
        .cornerRadius(15.0)
        .padding()
    }
}
//
//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView()
//    }
//}
