//
//  BaseViewController.swift
//  CoreAnimation06
//
//  Created by roni on 2018/10/9.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(handleOrientation), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    @objc func handleOrientation() {
        // 子类重写
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
