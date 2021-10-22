//
//  ContentView.swift
//  AlarmApp
//
//  Created by Lebedeva Alice on 22.10.2021.
//

import SwiftUI

struct AlarmsList: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        ZStack{
            if viewModel.checkEmpty() {
                Text("No alarms yet...")
                    .font(.headline)
            }
            else{
                List {
                    ForEach(viewModel.alarms, id: \.self) { alarm in
                        AlarmRow(alarm: alarm, viewModel: viewModel)
                    } .onDelete(perform: delete)
                }
            }
        }
    }
    func delete(at offsets: IndexSet) {
        viewModel.removeAlarm(offsets: offsets)
    }
}

struct AlarmRow: View {
    @ObservedObject var alarm: Alarm
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationLink(destination: EditView(alarm: alarm, viewModel:viewModel)) {
            HStack {
                VStack(alignment: .center, spacing: 10, content: {
                    Text(alarm.time).multilineTextAlignment(.leading).font(.system(size: 30,  weight: .heavy))
                    Text(alarm.name).multilineTextAlignment(.leading)
                }).padding()
                Spacer()
                Toggle("", isOn: $alarm.isSwitchOn).padding()
                
            }
        }
    }
}

struct ToolbarAddAlarm: ToolbarContent{
    @ObservedObject var viewModel: ViewModel
    @Binding var showInfoModalView: Bool
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: { showInfoModalView = true})
            {
                Label("Add", systemImage: "plus")
            }
        }
    }
}

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var showInfoModalView: Bool = false
    
    var body: some View {
        VStack{
            NavigationView {
                AlarmsList(viewModel: viewModel)
                    .navigationTitle("Alarms")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarAddAlarm(viewModel: viewModel, showInfoModalView: $showInfoModalView)
                    }
            }
        }.sheet(isPresented: $showInfoModalView) {
            AddNewView(isPresented: $showInfoModalView, viewModel: viewModel)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
