//
//  TextLayerViewController.swift
//  CoreAnimation06
//
//  Created by roni on 2018/10/9.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit

class TextLayerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addContainerView()
    }

    override func handleOrientation() {
        let width = UIScreen.main.bounds.width
        containerView.frame = CGRect(x: 0, y: 0, width: width, height: 300)
        containerView.center = view.center
    }
}
