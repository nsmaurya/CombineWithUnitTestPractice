//
//  HeaderView.swift
//  TipCalculator
//
//  Created by Sunil Maurya on 03/04/24.
//

import UIKit

class HeaderView: UIView {
    private let titleLabel: UILabel = {
        LabelFactory.build(text: nil, font: ThemeFont.demiBold(of: 18))
    }()
    
    private let subTitleLabel: UILabel = {
        LabelFactory.build(text: nil, font: ThemeFont.regular(of: 18))
    }()

    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [UIView(), titleLabel, subTitleLabel, UIView()])
        view.axis = .vertical
        view.spacing = -4
        view.alignment = .leading
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
        addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
}
