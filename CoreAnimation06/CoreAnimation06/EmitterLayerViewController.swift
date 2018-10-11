//
//  EmitterLayerViewController.swift
//  CoreAnimation06
//
//  Created by roni on 2018/10/11.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit

class EmitterLayerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addContainerView()

        emitterAction()
    }
    

    func emitterAction() {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.frame = containerView.bounds
        containerView.layer.addSublayer(emitterLayer)

        emitterLayer.renderMode = .additive
        emitterLayer.emitterPosition = CGPoint(x: emitterLayer.frame.size.width / 2, y: emitterLayer.frame.size.height / 2)

        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "star")?.cgImage
        cell.birthRate = 150
        cell.lifetime = 5
        cell.color = UIColor(displayP3Red: 1, green: 0.5, blue: 0.1, alpha: 1).cgColor
        cell.alphaSpeed = -0.4
        cell.velocity = 50
        cell.velocityRange = 50
        cell.emissionRange = CGFloat.pi * 2

        let cell02 = CAEmitterCell()
        cell02.contents = UIImage(named: "firework")?.cgImage
        cell02.birthRate = 150
        cell02.lifetime = 5
        cell02.color = UIColor(displayP3Red: 1, green: 0.5, blue: 0.1, alpha: 1).cgColor
        cell02.alphaSpeed = -0.4
        cell02.velocity = 50
        cell02.velocityRange = 50
        cell02.emissionRange = CGFloat.pi * 2

        emitterLayer.emitterCells = [cell, cell02]
    }

}
