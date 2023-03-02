//
//  MoneyKeeperApp.swift
//  MoneyKeeper
//
//  Created by Bhumika Patel on 02/03/23.
//

import SwiftUI

@main
struct MoneyKeeperApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            AddMoneyKeeper()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
