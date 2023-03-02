//
//  MoneyTabView.swift
//  MoneyKeeper
//
//  Created by Bhumika Patel on 02/03/23.
//

import SwiftUI
import CoreData

struct MoneyTabView: View {
    
    @Environment(\.managedObjectContext)
        var context: NSManagedObjectContext
    
    @State private var searchText : String = ""
    @State private var searchBarHeight: CGFloat = 0
    @State private var sortType = SortType.date
    @State private var sortOrder = SortOrder.descending
    
    @State var selectedCategories: Set<Category> = Set()
    @State var isAddFormPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
//                SearchBar(text: $searchText, keyboardHeight: $searchBarHeight, placeholder: "Search MoneyDetails")
                FilterCategoriesView(selectedCategories: $selectedCategories)
                Divider()
                SelectSortOrderView(sortType: $sortType, sortOrder: $sortOrder)
                Divider()
                MoneyKeeperListView(predicate: MoneySpent.predicate(with: Array(selectedCategories), searchText: searchText), sortDescriptor: ExpenseLogSort(sortType: sortType, sortOrder: sortOrder).sortDescriptor)
            }
            .padding(.bottom, searchBarHeight)
            .sheet(isPresented: $isAddFormPresented) {
                AddMoneyKeeper(context: self.context)
            }
            .navigationBarItems(trailing: Button(action: addTapped) { Text("Add") })
            .navigationBarTitle("MoneyKeeper", displayMode: .inline)
        }
    }
    
    func addTapped() {
        isAddFormPresented = true
    }
    
    
    
}

struct LogsTabView_Previews: PreviewProvider {
    static var previews: some View {
        MoneyTabView()
    }
}

