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

    func addContainerView() {
        containerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300)
        containerView.center = view.center
        view.addSubview(containerView)
    }


    @objc func handleOrientation() {
        // 子类重写
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 239 / 255.0, green: 239 / 255.0, blue: 239 / 255.0, alpha: 1)
        return view
    }()
}
