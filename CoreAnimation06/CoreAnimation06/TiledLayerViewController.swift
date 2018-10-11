//
//  TiledLayerViewController.swift
//  CoreAnimation06
//
//  Created by roni on 2018/10/11.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit

class TiledLayerViewController: BaseViewController {

    deinit {

        // 全局变量 - 记得移除, 否则销毁后代理调用导致崩溃
        tiledLayer.removeFromSuperlayer()
        scrollView.delegate = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addContainerView()
        scrollView.frame = containerView.bounds
        containerView.addSubview(scrollView)

        let imageView = UIImageView(image: UIImage(named: "image06"))
        imageView.frame = scrollView.frame
        scrollView.addSubview(imageView)


        tiledLayer.frame = CGRect(x: 0, y: 0, width: 2048, height: 2048)
        tiledLayer.delegate = self
//        tiledLayer.contentsScale = UIScreen.main.scale

        scrollView.layer.addSublayer(tiledLayer)

        scrollView.contentSize = tiledLayer.frame.size
    }

    let tiledLayer = CATiledLayer()

    lazy var scrollView: UIScrollView = {
        return UIScrollView()
    }()
}

extension TiledLayerViewController: CALayerDelegate {
    func draw(_ layer: CALayer, in ctx: CGContext) {
        let currentLayer = layer as! CATiledLayer
        let bounds = ctx.boundingBoxOfClipPath
        let scale = UIScreen.main.scale
        let x = floor(bounds.origin.x / currentLayer.tileSize.width * scale)
        let y = floor(bounds.origin.y / currentLayer.tileSize.height * scale)
        let imageName = String(format: "image06_%02d_%02d", x, y)
        guard let imagePath = Bundle.main.path(forResource: imageName, ofType: "jpg") else {
            return
        }
        let tileImage = UIImage(contentsOfFile: imagePath)
        UIGraphicsPushContext(ctx)
        tileImage?.draw(in: bounds)
        UIGraphicsPopContext()
    }
}
