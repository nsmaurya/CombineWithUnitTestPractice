//
//  TipInputView.swift
//  TipCalculator
//
//  Created by Sunil Maurya on 02/04/24.
//

import UIKit

class TipInputView: UIView {

    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(title: "Choose", subTitle: "your tip")
        return view
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        buildTipButton(tip: .tenPercent)
    }()
    
    private lazy var fifteenPercentTipButton: UIButton = {
        buildTipButton(tip: .fifteenPercent)
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        buildTipButton(tip: .twentyPercent)
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(of: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8)
        return button
    }()

    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [tenPercentTipButton, fifteenPercentTipButton, twentyPercentTipButton])
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 16
        return view
    }()

    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [hStackView, customTipButton])
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 16
        return view
    }()

    init() {
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        [headerView, buttonStackView].forEach(self.addSubview(_:))
        buttonStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(buttonStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
            make.centerY.equalTo(hStackView.snp.centerY)
        }
    }
    
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(string: tip.stringValue, attributes:[.font: ThemeFont.bold(of: 20), .foregroundColor: UIColor.white])
        text.addAttributes([.font: ThemeFont.demiBold(of: 14)], range: NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        return button
    }
}

enum Tip {
    case none
    case tenPercent
    case fifteenPercent
    case twentyPercent
    case custom(value: Int)
    
    var stringValue: String {
        switch self {
        case .none:
            return ""
        case .tenPercent:
            return "10%"
        case .fifteenPercent:
            return "15%"
        case .twentyPercent:
            return "20%"
        case .custom(let value):
            return String(value)
        }
    }
}
