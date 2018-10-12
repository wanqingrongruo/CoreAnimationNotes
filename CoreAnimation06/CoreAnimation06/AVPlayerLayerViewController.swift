//
//  AVPlayerLayerViewController.swift
//  CoreAnimation06
//
//  Created by roni on 2018/10/11.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit
import AVFoundation

class AVPlayerLayerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addContainerView()

        guard let url = Bundle.main.url(forResource: "2", withExtension: "mp4") else {
            return
        }
        let palyer = AVPlayer(url: url)
        let palyerLayer = AVPlayerLayer(player: palyer)

        palyerLayer.frame = containerView.bounds
        containerView.layer.addSublayer(palyerLayer)

        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500
        transform = CATransform3DRotate(transform, CGFloat.pi / 4, 1, 1, 0)
        palyerLayer.transform = transform

        palyerLayer.masksToBounds = true
        palyerLayer.cornerRadius = 20
        palyerLayer.borderColor = UIColor.red.cgColor
        palyerLayer.borderWidth = 5.0

        palyer.play()
    }

}
