//
//  ScreenIdentifer.swift
//  TipCalculator
//
//  Created by Sunil Maurya on 09/04/24.
//

import Foundation

enum ScreenIdentifier {
    
    enum LogoView: String {
        case logoView
    }
    enum ResultView: String {
        case totalAmountPerPersonValueLabel
        case totalBillValueLabel
        case totalTipValueLabel
    }
    
    enum BillInputView: String {
        case textField
    }
    
    enum TipInputView: String {
        case tenPerecentButton
        case fifteenPercentButton
        case twentyPercentButton
        case customTipButton
        case customTipAlertViewTextField
    }
    
    enum SplitInputView: String {
        case decrementButton
        case incrementButton
        case quantityValueLabel
    }
}
