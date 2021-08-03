//
//  StatusBar+Extension.swift
//  IJKPlayerdemo
//
//  Created by 金劲通 on 2021/8/3.
//

import UIKit

extension UIViewController {
    func statusBarHiddenFunc() {
        self.automaticallyAdjustsScrollViewInsets = false
        let backImage = UIImage.colorImg(.clear, size: CGSize(width: 10, height: 10))
        self.navigationController?.navigationBar.setBackgroundImage(backImage, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = backImage
    }
}
