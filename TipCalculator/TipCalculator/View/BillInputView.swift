//
//  BillInputView.swift
//  TipCalculator
//
//  Created by Sunil Maurya on 02/04/24.
//

import UIKit
import Combine
import CombineCocoa

class BillInputView: UIView {
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(title: "Enter", subTitle: "your bill")
        return view
    }()
    
    private let textContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 8.0)
        return view
    }()
    
    private let currencyLabel: UILabel = {
        let label = LabelFactory.build(text: "$", font: ThemeFont.bold(of: 24))
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = ThemeFont.regular(of: 28)
        textField.keyboardType = .decimalPad
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        //toolbar
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 36))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        toolBar.items = [(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)), doneButton]
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        return textField
    }()
    
    private let billSubject: PassthroughSubject<Double, Never> = .init()
    var valuePublisher: AnyPublisher<Double,Never> {
        return billSubject.eraseToAnyPublisher()
    }
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        [headerView, textContainerView].forEach { addSubview($0)}
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(textContainerView.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(textContainerView.snp.leading).offset(-24)
        }
        
        textContainerView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        [currencyLabel, textField].forEach(textContainerView.addSubview(_:))
        currencyLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(textContainerView.snp.leading).offset(16)
        }
        
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(currencyLabel.snp.trailing).offset(16)
            make.trailing.equalTo(textContainerView.snp.trailing).offset(-16)
        }
    }
    
    private func observe() {
        textField.textPublisher.sink {[unowned self] text in
            self.billSubject.send(text?.doubleValue ?? 0)
        }.store(in: &cancellable)
    }
    
    func reset() {
        textField.text = nil
        billSubject.send(0)
    }
    
    @objc private func doneButtonTapped() {
        textField.endEditing(true)
    }
}
