//
//  Extension.swift
//  MoneyKeeper
//
//  Created by Bhumika Patel on 02/03/23.
//

import Foundation

extension Double {
    
    var formattedCurrencyText: String {
        return Utils.numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
    
}
