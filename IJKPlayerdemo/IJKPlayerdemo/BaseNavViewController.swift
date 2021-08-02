//
//  BaseNavViewController.swift
//  IJKPlayerdemo
//
//  Created by 金劲通 on 2021/8/2.
//  Copyright © 2021 riven. All rights reserved.
//

import UIKit
import EZSwiftExtensions
class BaseNavViewController: UINavigationController, UINavigationControllerDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
        //configSubviews()
        self.delegate = self
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
}


// MARK: - config ui
extension BaseNavViewController {
    func configNavgationBar() {
        let appearance = UINavigationBar.appearance()
        appearance.isTranslucent = false
        let bgImg = UIImage.colorImg(UIColor.init(hexString: "#FFFFFF")!, size: CGSize(width: self.view.frame.size.width, height: 64))
        appearance.setBackgroundImage(bgImg, for: .default)
        let shadowImg = UIImage.colorImg(UIColor.init(hexString: "#FFFFFF")!, size: CGSize(width: self.view.frame.size.width, height: 0.5))
        appearance.shadowImage = shadowImg
        appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),NSAttributedString.Key.foregroundColor: UIColor(hexString: "#282828")!]
    }
    
    
    func configSubviews() {
        addSubviews()
        snapSubViews()
    }
    
    func addSubviews() {
        
    }
    
    func snapSubViews() {
        
    }
}
// MARK: - view controller lifecyle

// MARK: - target methods
extension BaseNavViewController {}
// MARK: - delegate
extension BaseNavViewController {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.hideNavigationBar {
            setNavigationBarHidden(true, animated: true)
        } else {
            setNavigationBarHidden(false, animated: true)
        }
    }
}


// MARK: - private methods
extension UIViewController {
    @objc var hideNavigationBar: Bool {
        return false
    }
}

// MARK: - target-action
extension BaseNavViewController {}
