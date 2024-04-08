//
//  UIResponder+Extension.swift
//  TipCalculator
//
//  Created by Sunil Maurya on 08/04/24.
//

import Foundation
import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
