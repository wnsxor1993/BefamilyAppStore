//
//  UIStackView +.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}
