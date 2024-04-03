//
//  TipInputView.swift
//  TipCalculator
//
//  Created by Sunil Maurya on 02/04/24.
//

import UIKit

class TipInputView: UIView {

    init() {
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        backgroundColor = .green
    }
}
