//
//  UIButton+Extensions.swift
//  FlexingMVI
//
//  Created by waheedCodes on 12/04/2022.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {

    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
