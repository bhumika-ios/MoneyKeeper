//
//  AddMoneyKeeper.swift
//  MoneyKeeper
//
//  Created by Bhumika Patel on 02/03/23.
//

import SwiftUI
import CoreData

struct AddMoneyKeeper: View {
    var moneyToEdit: MoneySpent?
    var context: NSManagedObjectContext
    
    @State var name: String = ""
    @State var amount: Double = 0
    @State var category: Category = .utilities
    @State var date: Date = Date()
    
    @Environment(\.presentationMode)
    var presentationMode
    
    var title: String {
        moneyToEdit == nil ? "Create Money" : "Edit Money"
    }
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
           

            .navigationBarItems(
                leading: Button(action: self.onCancelTapped) { Text("Cancel")},
                trailing: Button(action: self.onSaveTapped) { Text("Save")}
            )
            .navigationBarTitle(title)
            
        }
    }
    private func onCancelTapped() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func onSaveTapped() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        let money: MoneySpent
        if let moneyToEdit = self.moneyToEdit {
            money = moneyToEdit
        } else {
            money = MoneySpent(context: self.context)
            money.id = UUID()
        }
        
        money.name = self.name
        money.category = self.category.rawValue
        money.amount = NSDecimalNumber(value: self.amount)
        money.date = self.date
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddMoneyKeeper_Previews: PreviewProvider {
    static var previews: some View {
        let stack = CoreDataStack(containerName: "MoneyKeeper")
        return AddMoneyKeeper(context: stack.viewContext)
    }
}
