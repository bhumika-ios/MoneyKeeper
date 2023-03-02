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
                        Image(systemName: "homekit")
                       
           
                    }
            }
            .tag(0)
            DashboardTabView()
                .tabItem {
                    VStack {
                        Text("Dashboard")
                        Image(systemName: "chart.pie")
           
                    }
            }
            .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
