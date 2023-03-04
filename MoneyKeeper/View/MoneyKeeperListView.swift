//
//  MoneyKeeperListView.swift
//  MoneyKeeper
//
//  Created by Bhumika Patel on 02/03/23.
//

import SwiftUI
import CoreData

import SwiftUI
import CoreData

struct MoneyKeeperListView: View {
    
    @State var moneyToEdit: MoneySpent?
    
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    @FetchRequest(
        entity: MoneySpent.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \MoneySpent.date, ascending: false)
        ]
    )
    private var result: FetchedResults<MoneySpent>
    
    init(predicate: NSPredicate?, sortDescriptor: NSSortDescriptor) {
        let fetchRequest = NSFetchRequest<MoneySpent>(entityName: MoneySpent.entity().name ?? "MoneySpent")
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        _result = FetchRequest(fetchRequest: fetchRequest)
    }
    
    var body: some View {
        List {
            ForEach(result) { (money: MoneySpent) in
                Button(action: {
                    self.moneyToEdit = money
                }) {
                    HStack(spacing: 16) {
                        CategoryImageView(category: money.categoryEnum)

                        VStack(alignment: .leading, spacing: 8) {
                            Text(money.nameText).font(.headline)
                            Text(money.dateText).font(.subheadline)
                        }
                        Spacer()
                        Text(money.amountText).font(.headline)
                    }
                    .padding(.vertical, 4)
                }
                
            }
               
            .onDelete(perform: onDelete)
            .sheet(item: $moneyToEdit, onDismiss: {
                self.moneyToEdit = nil
            }) { (money: MoneySpent) in
              
                AddMoneyKeeper(
                    moneyToEdit: money,
                    context: self.context,
                    name: money.name ?? "",
                    amount: money.amount?.doubleValue ?? 0,
                    category: Category(rawValue: money.category ?? "") ?? .food,
                    date: money.date ?? Date()
                )
            }
         
            .listStyle(.automatic)
        }
    }
    
    private func onDelete(with indexSet: IndexSet) {
        indexSet.forEach { index in
            let money = result[index]
            context.delete(money)
        }
        try? context.saveContext()
    }
}

struct LogListView_Previews: PreviewProvider {
    static var previews: some View {
        let stack = CoreDataStack(containerName: "MoneySpent")
        let sortDescriptor = ExpenseLogSort(sortType: .date, sortOrder: .descending).sortDescriptor
        return MoneyKeeperListView(predicate: nil, sortDescriptor: sortDescriptor)
            .environment(\.managedObjectContext, stack.viewContext)
    }
}
