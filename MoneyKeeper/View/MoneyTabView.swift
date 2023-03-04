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
                
                
//                Button(action: {
//
//                }){
//                    Image(systemName: "plus")
//                        .resizable()
//                        .foregroundColor(.black)
//                        .frame(width: 25,height: 25)
//                        .offset(x: -30)
//                        .background{
//                            Capsule()
//                                .fill(
//                                    .linearGradient(colors:[
//                                        Color("Purple").opacity(0.5),
//
//                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
//
//                                )
//                                .frame(width: 120,height: 50)
//                        }
//                        .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
//                }
//                .offset(x:210,y: -70)
//                AddButton()
//
                    .overlay(alignment: .bottomTrailing){
                        AddButton()
                            .offset(x: -10, y:-15)
                    }
//                AddButton()
//                    .offset(x: 150, y:-70)
            }
          
            .padding(.bottom, searchBarHeight)
            .sheet(isPresented: $isAddFormPresented) {
                AddMoneyKeeper(context: self.context)
            }
          
          // .navigationBarItems(trailing: Button(action: addTapped) { Text("Add") })
            .navigationBarTitle("MoneyKeeper", displayMode: .inline)
        }
       
    }
    
//    func addTapped() {
//        isAddFormPresented = true
//    }

    func AddButton()->some View{
        Button{
            isAddFormPresented = true
        } label: {
            Image(systemName: "plus")
               
                .resizable()
                .font(.system(size: 25, weight: .medium))
                .frame(width: 20, height: 20)
                
        }
        .foregroundColor(.white)
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(Color("Purple"))
        .frame(width: 43,height: 43)
        .cornerRadius(15)
       
    }
    
}

struct LogsTabView_Previews: PreviewProvider {
    static var previews: some View {
        MoneyTabView()
    }
}

