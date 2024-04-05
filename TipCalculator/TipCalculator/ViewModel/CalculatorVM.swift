//
//  CalculatorVM.swift
//  TipCalculator
//
//  Created by Sunil Maurya on 05/04/24.
//

import Foundation
import Combine

class CalculatorVM {
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<BillOutput, Never>
    }
    
    func transform(input: Input) -> Output {
        let output = BillOutput(amountPerPerson: 100, totalBill: 200, totalTip: 50)
        return Output(updateViewPublisher: Just(output).eraseToAnyPublisher())
    }
}
