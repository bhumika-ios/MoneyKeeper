//
//  DashboardTabView.swift
//  MoneyKeeper
//
//  Created by Bhumika Patel on 02/03/23.
//

import SwiftUI
import CoreData

struct DashboardTabView: View {
    
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    @State var totalMoney: Double?
    @State var categoriesSum: [CategorySum]?
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 4) {
                if totalMoney != nil {
                    Text("Total Money")
                        .font(.headline)
                    if totalMoney != nil {
                        Text(totalMoney!.formattedCurrencyText)
                            .font(.largeTitle)
                    }
                }
            }
            
            if categoriesSum != nil {
                if totalMoney != nil && totalMoney! > 0 {
                    PieChartView(
                        data: categoriesSum!.map { ($0.sum, $0.category.color) },
                        style: Styles.pieChartStyleOne,
                        form: CGSize(width: 300, height: 240),
                        dropShadow: false
                    )
                }
                
                Divider()

                List {
                    Text("Breakdown").font(.headline)
                    ForEach(self.categoriesSum!) {
                        CategoryRowView(category: $0.category, sum: $0.sum)
                    }
                }
            }
            
            if totalMoney == nil && categoriesSum == nil {
                Text("No Money data\nPlease add your money from the AddMoney")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .padding(.horizontal)
            }
        }
        .padding(.top)
        .onAppear(perform: fetchTotalSums)
    }
    
    func fetchTotalSums() {
        MoneySpent.fetchAllCategoriesTotalAmountSum(context: self.context) { (results) in
            guard !results.isEmpty else { return }
            
            let totalSum = results.map { $0.sum }.reduce(0, +)
            self.totalMoney = totalSum
            self.categoriesSum = results.map({ (result) -> CategorySum in
                return CategorySum(sum: result.sum, category: result.category)
            })
        }
    }
}


struct CategorySum: Identifiable, Equatable {
    let sum: Double
    let category: Category
    
    var id: String { "\(category)\(sum)" }
}


struct DashboardTabView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardTabView()
    }
}
