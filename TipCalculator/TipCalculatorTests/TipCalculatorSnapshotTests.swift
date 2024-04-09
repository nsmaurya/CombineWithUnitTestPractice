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
}
