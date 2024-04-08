//
//  Double+Extension.swift
//  TipCalculator
//
//  Created by Sunil Maurya on 08/04/24.
//

import Foundation
extension Double {
    var curencyFormated: String {
        var isWholeNumber: Bool {
            isZero ? true : isNormal ? false: self == rounded()
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        return formatter.string(for: self) ?? ""
    }
}
