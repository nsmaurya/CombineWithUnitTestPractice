//
//  TipCalculatorUITests.swift
//  TipCalculatorUITests
//
//  Created by Sunil Maurya on 01/04/24.
//

import XCTest

final class TipCalculatorUITests: XCTestCase {

    private var app: XCUIApplication!
    
    private var screen: CalculatorScreen {
        CalculatorScreen(app: app)
    }
    
    override func setUp() {
        super.setUp()
        app = .init()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testResultViewWithDefaultValues()  {
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$0")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$0")
    }
    
    func testRegularTip() {
        //user enter $100 bill
        screen.enterBill(amount: 100)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₹ 100.00")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₹ 100.00")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₹ 0")
        
        //user select 10% tip
        screen.selectTip(tip: .tenPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₹ 110.00")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₹ 110.00")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₹ 10.00")
        
        //user select 15% tip
        screen.selectTip(tip: .fifteenPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₹ 115.00")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₹ 115.00")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₹ 15.00")
        
        //user select 20% tip
        screen.selectTip(tip: .twentyPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₹ 120.00")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₹ 120.00")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₹ 20.00")
        
        //user splits the bill by 4
        screen.selectIncrementButton(numberOfTaps: 3)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₹ 30.00")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₹ 120.00")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₹ 20.00")
        
        //user splits the bill by 2
        screen.selectDecrementButton(numberOfTaps: 2)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₹ 60.00")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₹ 120.00")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₹ 20.00")
    }
    
    func testCustomTipAndSplitBillBy2() {
        screen.enterBill(amount: 300)
        screen.selectTip(tip: .custom(value: 200))
        screen.selectIncrementButton(numberOfTaps: 1)
        
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₹ 250.00")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₹ 500.00")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₹ 200.00")
    }
    
    func testResetButton() {
        screen.enterBill(amount: 300)
        screen.selectTip(tip: .custom(value: 200))
        screen.selectIncrementButton(numberOfTaps: 1)
        screen.doubleTapLogoView()
        
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "₹ 0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "₹ 0")
        XCTAssertEqual(screen.totalTipValueLabel.label, "₹ 0")
        XCTAssertEqual(screen.billInputViewTextField.label, "")
        XCTAssertEqual(screen.splitValueLabel.label, "1")
        XCTAssertEqual(screen.customTipButton.label, "Custom tip")
    }
}
