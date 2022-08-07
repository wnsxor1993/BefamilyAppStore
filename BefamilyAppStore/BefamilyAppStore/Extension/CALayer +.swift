//
//  CALayer +.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/07.
//

import UIKit

extension CALayer {
    
    func addBorder(_ edges: [UIRectEdge], color: UIColor, width: CGFloat) {
        edges.forEach {
            let border = CALayer()
            
            switch $0 {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
                
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
                
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: frame.height / 3, width: width, height: frame.height / 3)
                break
                
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
                
            default:
                break
            }
            
            border.backgroundColor = color.cgColor
            addSublayer(border)
        }
    }
}
