//
//  ContentView.swift
//  Assignment1
//
//  Created by Lebedeva Alice on 10.09.2021.
//

import SwiftUI

struct WelcomeText: View {
    var body: some View {
        Text("Welcome to SwiftUI!")
            .font(.system(size: 40,  weight: .heavy))
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(Color(UIColor.init(rgb:  0x5230bf)))
            .background(Color(UIColor.white).opacity(0.8))
            .cornerRadius(16.0)
            .padding(.bottom, 70)
    }
}

struct Email: View {
    @Binding var email: String
    
    var body: some View {
        HStack {
            Image(systemName: "mail").padding().foregroundColor(.gray)
            TextField("Email", text: $email)
                .padding()
        }
        .background(Color(UIColor.white))
        .cornerRadius(5.0)
        .padding(.bottom, 20)
    }
}

struct Password: View {
    @Binding var password: String
    
    var body: some View {
        HStack {
            Image(systemName: "lock").padding().foregroundColor(.gray)
            SecureField("Password", text: $password)
                .padding()
        }
        .background(Color(UIColor.white))
        .cornerRadius(5.0)
        .padding(.bottom, 20)
        
    }
}
struct BtnLogin: View {
    var body: some View {
        Button("LOGIN"){}
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 220, height: 60)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .background(Color.blue.opacity(0.7))
            .cornerRadius(15.0)
        
    }
}

struct ContentView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View{
        GeometryReader { geometry in
            ZStack{
                Image("back")
                    .resizable()
                    .aspectRatio(geometry.size, contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    WelcomeText()
                    Email(email: $email)
                    Password(password: $password)
                    BtnLogin()
                }.padding(.horizontal, 10)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
