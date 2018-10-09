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

        setupTextLayer()
    }

    func setupTextLayer() {
        let textLayer = CATextLayer()
        textLayer.frame = containerView.bounds

        containerView.layer.addSublayer(textLayer)

        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.alignmentMode = .justified
        textLayer.isWrapped = true

        let font = UIFont.systemFont(ofSize: 15)
        let fontName = font.fontName as CFString
        let fontRef = CGFont(fontName)
        textLayer.font = fontRef
        textLayer.fontSize = font.pointSize

        let text = "穿过幽暗的岁月 也曾感到彷徨 当你低头的瞬间 才发觉脚下的路"
        textLayer.string = text

        textLayer.contentsScale = UIScreen.main.scale
    }

    override func handleOrientation() {
        let width = UIScreen.main.bounds.width
        containerView.frame = CGRect(x: 0, y: 0, width: width, height: 300)
        containerView.center = view.center
    }
}
