//
//  AddMoneyKeeper.swift
//  MoneyKeeper
//
//  Created by Bhumika Patel on 02/03/23.
//

import SwiftUI
import CoreData

struct AddMoneyKeeper: View {
    @State var name: String = ""
    @State var amount: Double = 0
    @State var date: Date = Date()
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .disableAutocorrection(true)
                TextField("Amount", value: $amount, formatter: Utils.numberFormatter)
                    .keyboardType(.numbersAndPunctuation)
                    
                Picker(selection: $category, label: Text("Category")) {
                    ForEach(Category.allCases) { category in
                        Text(category.rawValue.capitalized).tag(category)
                    }
                }
                DatePicker(selection: $date, displayedComponents: .date) {
                    Text("Date")
                }
            }

//            .navigationBarItems(
//                leading: Button(action: self.onCancelTapped) { Text("Cancel")},
//                trailing: Button(action: self.onSaveTapped) { Text("Save")}
//            )
            .navigationBarTitle("Add MoneyDetails")
            
        }
    }
}

struct AddMoneyKeeper_Previews: PreviewProvider {
    static var previews: some View {
        AddMoneyKeeper()
    }
}
