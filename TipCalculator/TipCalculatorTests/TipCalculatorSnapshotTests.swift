//
//  TipCalculatorSnapshotTests.swift
//  TipCalculatorTests
//
//  Created by Sunil Maurya on 09/04/24.
//

import XCTest
import SnapshotTesting
@testable import TipCalculator

final class TipCalculatorSnapshotTests: XCTestCase {

    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }

    func testLogoView() {
        //given
        let size = CGSize(width: screenWidth, height: 48)
        //when
        let view = LogoView()
        //then
        //very first time uncomment this to create snapshot in TipCalculatorTests folder
        //assertSnapshot(matching: view, as: .image(size: size), record: true)
        
        //after first time run, run below to check
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testResultViewWithValues() {
        //given
        let size = CGSize(width: screenWidth, height: 224)
        let billOutput = BillOutput(amountPerPerson: 100.25, totalBill: 45, totalTip: 60)
        //when
        let view = ResultView()
        view.configure(result: billOutput)
        //then
        //very first time uncomment this to create snapshot in TipCalculatorTests folder
        //assertSnapshot(matching: view, as: .image(size: size), record: true)
        
        //after first time run, run below to check
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialResultView() {
        //given
        let size = CGSize(width: screenWidth, height: 224)
        //when
        let view = ResultView()
        //then
        //very first time uncomment this to create snapshot in TipCalculatorTests folder
        //assertSnapshot(matching: view, as: .image(size: size), record: true)
        
        //after first time run, run below to check
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialBillInputView() {
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = BillInputView()
        //then
        //very first time uncomment this to create snapshot in TipCalculatorTests folder
        //assertSnapshot(matching: view, as: .image(size: size), record: true)
        
        //after first time run, run below to check
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testBillInputViewWithValues() {
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = BillInputView()
        let textField = view.allSubViewsOf(type: UITextField.self).first
        textField?.text = "500"
        //then
        //very first time uncomment this to create snapshot in TipCalculatorTests folder
        //assertSnapshot(matching: view, as: .image(size: size), record: true)
        
        //after first time run, run below to check
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialTipInputView() {
        //given
        let size = CGSize(width: screenWidth, height: 56 + 56 + 16)
        //when
        let view = TipInputView()
        //then
        //very first time uncomment this to create snapshot in TipCalculatorTests folder
        //assertSnapshot(matching: view, as: .image(size: size), record: true)
        
        //after first time run, run below to check
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testTipInputViewWithSelection() {
        //given
        let size = CGSize(width: screenWidth, height: 56 + 56 + 16)
        //when
        let view = TipInputView()
        let button = view.allSubViewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        //then
        //very first time uncomment this to create snapshot in TipCalculatorTests folder
        //assertSnapshot(matching: view, as: .image(size: size), record: true)
        
        //after first time run, run below to check
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialSplitInputView() {
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = SplitInputView()
        //then
        //very first time uncomment this to create snapshot in TipCalculatorTests folder
        //assertSnapshot(matching: view, as: .image(size: size), record: true)
        
        //after first time run, run below to check
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testSplitInputViewWithSelection() {
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = SplitInputView()
        let button = view.allSubViewsOf(type: UIButton.self).last
        button?.sendActions(for: .touchUpInside)
        //then
        //very first time uncomment this to create snapshot in TipCalculatorTests folder
        //assertSnapshot(matching: view, as: .image(size: size), record: true)
        
        //after first time run, run below to check
        assertSnapshot(matching: view, as: .image(size: size))
    }
}

extension UIView {

    /** This is the function to get subViews of a view of a particular type
*/
    func subViews<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T{
                all.append(aView)
            }
        }
        return all
    }


/** This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T */
        func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
            var all = [T]()
            func getSubview(view: UIView) {
                if let aView = view as? T{
                all.append(aView)
                }
                guard view.subviews.count>0 else { return }
                view.subviews.forEach{ getSubview(view: $0) }
            }
            getSubview(view: self)
            return all
        }
    }
