//
//  TipInputView.swift
//  TipCalculator
//
//  Created by Sunil Maurya on 02/04/24.
//

import UIKit
import Combine
import CombineCocoa

class TipInputView: UIView {

    private var cancellables = Set<AnyCancellable>()

    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(title: "Choose", subTitle: "your tip")
        return view
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        button.tapPublisher.flatMap ({
            Just(Tip.tenPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.tenPerecentButton.rawValue
        return button
    }()
    
    private lazy var fifteenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPercent)
        button.tapPublisher.flatMap ({
            Just(Tip.fifteenPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.fifteenPercentButton.rawValue
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        button.tapPublisher.flatMap ({
            Just(Tip.twentyPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.twentyPercentButton.rawValue
        return button
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(of: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8)
        button.tapPublisher.sink { [weak self] _ in
            self?.handleCustomTipButton()
        }.store(in: &cancellables)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.customTipButton.rawValue
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
    
    private let tipSubject = CurrentValueSubject<Tip, Never>(.none)
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }

    init() {
        super.init(frame: .zero)
        layout()
        observe()
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
    
    func reset() {
        tipSubject.send(.none)
    }
    
    private func observe() {
        tipSubject.sink {[unowned self] tip in
            self.resetView()
            switch tip {
            case .none:
                break
            case .tenPercent:
                tenPercentTipButton.backgroundColor = ThemeColor.secondary
            case .fifteenPercent:
                fifteenPercentTipButton.backgroundColor = ThemeColor.secondary
            case .twentyPercent:
                twentyPercentTipButton.backgroundColor = ThemeColor.secondary
            case .custom(let value):
                customTipButton.backgroundColor = ThemeColor.secondary
                let text = NSMutableAttributedString(string: "$\(value)", attributes: [
                    .font: ThemeFont.bold(of: 20)
                ])
                text.addAttributes([
                    .font: ThemeFont.bold(of: 14)
                ], range: NSMakeRange(0, 1))
                customTipButton.setAttributedTitle(text, for: .normal)
            }
        }.store(in: &cancellables)
    }

    private func resetView() {
        [tenPercentTipButton, fifteenPercentTipButton, twentyPercentTipButton, customTipButton].forEach {
            $0.backgroundColor = ThemeColor.primary
        }
        let text = NSMutableAttributedString(string: "Custom tip", attributes: [
            .font: ThemeFont.bold(of: 20)
        ])
        customTipButton.setAttributedTitle(text, for: .normal)
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
    
    private func handleCustomTipButton() {
        let alert: UIAlertController = {
            let controller = UIAlertController(title: "Enter Custom Tip", message: nil, preferredStyle: .alert)
            controller.addTextField { textField in
                textField.placeholder = "Make it generous!"
                textField.autocorrectionType = .no
                textField.keyboardType = .numberPad
                textField.accessibilityIdentifier = ScreenIdentifier.TipInputView.customTipAlertViewTextField.rawValue
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] action in
                guard let text = controller.textFields?.first?.text, let value = Int(text) else { return }
                self?.tipSubject.send(.custom(value: value))
            }
            [okAction, cancel].forEach(controller.addAction(_:))
            return controller
        }()
        parentViewController?.present(alert, animated: true)
    }
}
