//
//  BaseShadow.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 27/11/2022.
//

import UIKit

extension UIView {
    func setShadow(radius: CGFloat = 4, shadowOffset: CGSize = CGSize(width: 7, height: 7), cornerRadius: CGFloat) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = shadowOffset
        layer.shadowPath = UIBezierPath(roundedRect: bounds.inset(by: UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 0)), cornerRadius: cornerRadius).cgPath
        layer.shadowOpacity = 0.45
    }
}
