//
//  UIView +.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import UIKit

extension UIView {

    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
