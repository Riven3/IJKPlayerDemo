//
//  UIView+Extension.swift
//  Demo
//
//  Created by 金劲通 on 2021/4/12.
//

import Foundation
import UIKit
extension UIView {
    //设置播放器工具栏渐变色
    public func setPlayerBarGradient(startP:CGPoint,endP:CGPoint) {
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.0).cgColor,
                                UIColor.black.withAlphaComponent(0.7).cgColor]
        let gradientLoactions:[NSNumber] = [0,1]
        gradientLayer.locations = gradientLoactions
        gradientLayer.startPoint = startP
        gradientLayer.endPoint = endP
        self.layer.addSublayer(gradientLayer)
    }
    //获取当前屏幕截图
    public func getViewShot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: false)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}
