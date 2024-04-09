//
//  ResultView.swift
//  TipCalculator
//
//  Created by Sunil Maurya on 02/04/24.
//

import UIKit

class ResultView: UIView {

    private let headerLabel: UILabel = {
        LabelFactory.build(text: "Total per person", font: ThemeFont.demiBold(of: 18))
    }()
    
    
    private let amountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(string: "$0", attributes:[.font: ThemeFont.bold(of: 48)])
        text.addAttributes([.font: ThemeFont.bold(of: 24)], range: NSMakeRange(0, 1))
        label.attributedText = text
        label.accessibilityIdentifier = ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue
        return label
    }()
    
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separator
        return view
    }()
    
    private let totalBillView: AmountView = {
        let view = AmountView(title: "Total bill",
                              textAlignment: .left,
                              amountLabelIdentifier: ScreenIdentifier.ResultView.totalBillValueLabel.rawValue)
        return view
    }()
    
    private let totalTipView: AmountView = {
        let view = AmountView(title: "Total tip",
                              textAlignment: .right,
                              amountLabelIdentifier: ScreenIdentifier.ResultView.totalTipValueLabel.rawValue)
        return view
    }()
    
    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [totalBillView, UIView(), totalTipView])
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [headerLabel, amountPerPersonLabel, horizontalLineView, buildSpacerView(height: 0), hStackView])
        view.axis = .vertical
        view.spacing = 8
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
        backgroundColor = .white
        addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.bottom.equalTo(snp.bottom).offset(-24)
        }
        
        horizontalLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        
        addShadow(offset: CGSize(width: 0, height: 3), color: .black, radius: 12.0, opacity: 0.1)
    }
    
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
    
    func configure(result: BillOutput) {
        let text = NSMutableAttributedString(string: result.amountPerPerson.curencyFormated, attributes: [.font: ThemeFont.bold(of: 48)])
        text.addAttributes([.font: ThemeFont.bold(of: 24)], range: NSMakeRange(0, 1))
        amountPerPersonLabel.attributedText = text
        totalBillView.configure(amount: result.totalBill)
        totalTipView.configure(amount: result.totalTip)
    }
}

class AmountView: UIView {
    
    private let title: String
    private let textAlignment: NSTextAlignment
    private let amountLabelIdentifier: String
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(text: self.title, font: ThemeFont.regular(of: 18), textColor: ThemeColor.text, alignment: self.textAlignment)
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = self.textAlignment
        label.textColor = ThemeColor.primary
        let text = NSMutableAttributedString(string: "$0", attributes:[.font: ThemeFont.bold(of: 24)])
        text.addAttributes([.font: ThemeFont.bold(of: 16)], range: NSMakeRange(0, 1))
        label.attributedText = text
        label.accessibilityIdentifier = amountLabelIdentifier
        return label
    }()

    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, amountLabel])
        view.axis = .vertical
        return view
    }()

    init(title: String, textAlignment: NSTextAlignment, amountLabelIdentifier: String) {
        self.title = title
        self.textAlignment = textAlignment
        self.amountLabelIdentifier = amountLabelIdentifier
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(amount: Double) {
        let text = NSMutableAttributedString(string: amount.curencyFormated, attributes: [.font: ThemeFont.bold(of: 24)])
        text.addAttributes([.font: ThemeFont.bold(of: 16)], range: NSMakeRange(0, 1))
        amountLabel.attributedText = text
    }
}
