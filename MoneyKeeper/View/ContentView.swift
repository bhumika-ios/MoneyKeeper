////
////  ContentView.swift
////  MoneyKeeper
////
////  Created by Bhumika Patel on 02/03/23.
////
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MoneyTabView()
                .tabItem {
                    VStack {
                        Text("Home")
                        Image(systemName: "house.fill")
                       
           
                    }
            }
            .tag(0)
            DashboardTabView()
                .tabItem {
                    VStack {
                        Text("Chart")
                        Image(systemName: "chart.pie")
           
                    }
            }
            .tag(1)
//            DashboardTabView()
//                .tabItem {
//                    VStack {
//                        Text("Profile")
//                        Image(systemName: "person.fill")
//                       
//           
//                    }
//            }
//            .tag(2)
        }
        
        .accentColor(Color("Purple"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
