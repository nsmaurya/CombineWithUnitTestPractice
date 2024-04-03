//
//  LabelFactory.swift
//  TipCalculator
//
//  Created by Sunil Maurya on 03/04/24.
//

import UIKit

struct LabelFactory {
    static func build(
        text: String?,
        font: UIFont,
        backgroundColor: UIColor = .clear,
        textColor: UIColor = ThemeColor.text,
        alignment: NSTextAlignment = .center
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.textAlignment = alignment
        return label
    }
}
