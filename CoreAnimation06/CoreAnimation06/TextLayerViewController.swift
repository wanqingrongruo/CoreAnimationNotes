//
//  TextLayerViewController.swift
//  CoreAnimation06
//
//  Created by roni on 2018/10/9.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit
import CoreText

class LayerLabel: UILabel {

    open override class var layerClass: AnyClass {
        return CATextLayer.self
    }

    func textLayer() -> CATextLayer {
        return self.layer as! CATextLayer
    }

    func setup() {
//        self.text = self.text
//        self.textColor = self.textColor
//        self.font = self.font

        self.textLayer().alignmentMode = .justified
        self.textLayer().isWrapped = true
        self.layer.display()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        self.setup()
    }

    override var text: String? {
        didSet {
            super.text = text
            self.textLayer().string = text
        }
    }

    override var textColor: UIColor! {
        didSet {
            super.textColor = textColor
            self.textLayer().foregroundColor = textColor.cgColor
        }
    }

    override var font: UIFont! {
        didSet {
            super.font = font
            let fontName = font.fontName as CFString
            let fontRef = CGFont(fontName)
            self.textLayer().font = fontRef
            self.textLayer().fontSize = font.pointSize
        }
    }
}

class TextLayerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addContainerView()

//        setupTextLayer()

        setupLayerLabel()
    }

    func setupLayerLabel() {
        let label = LayerLabel(frame: CGRect(x: 10, y: 10, width: containerView.bounds.width - 20, height: containerView.bounds.height - 20))
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        label.textColor = UIColor.black
        label.text = "如果你仔细看这个文本，你会发现一个奇怪的地方：这些文本有一些像素化了。这是因为并没有以Retina的方式渲染，第二章提到了这个contentScale属性，用来决定图层内容应该以怎样的分辨率来渲染。contentsScale并不关心屏幕的拉伸因素而总是默认为1.0。如果我们想以Retina的质量来显示文字，我们就得手动地设置CATextLayer的contentsScale属性"

        containerView.addSubview(label)
    }

    func setupTextLayer() {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: 10, y: 10, width: containerView.bounds.width - 20, height: containerView.bounds.height - 20)

        containerView.layer.addSublayer(textLayer)

        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.alignmentMode = .justified
        textLayer.isWrapped = true

        let font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
//        let fontName = font.fontName as CFString
//        let fontRef = CGFont(fontName)
//        textLayer.font = fontRef
//        textLayer.fontSize = font.pointSize

        let text = "如果你仔细看这个文本，你会发现一个奇怪的地方：这些文本有一些像素化了。这是因为并没有以Retina的方式渲染，第二章提到了这个contentScale属性，用来决定图层内容应该以怎样的分辨率来渲染。contentsScale并不关心屏幕的拉伸因素而总是默认为1.0。如果我们想以Retina的质量来显示文字，我们就得手动地设置CATextLayer的contentsScale属性"
//        textLayer.string = text

        let attributeText = NSMutableAttributedString(string: text)

        var attritutes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                          NSAttributedString.Key.font: font] as [NSAttributedString.Key : Any]
        attributeText.setAttributes(attritutes, range: NSRange(location: 0, length: attributeText.length))

        attritutes = [NSAttributedString.Key.foregroundColor: UIColor.red,
                      NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                      NSAttributedString.Key.font: font] as [NSAttributedString.Key : Any]
        attributeText.setAttributes(attritutes, range: NSRange(location: 6, length: 5))

        textLayer.string = attributeText


        textLayer.contentsScale = UIScreen.main.scale
    }

    override func handleOrientation() {
        let width = UIScreen.main.bounds.width
        containerView.frame = CGRect(x: 0, y: 0, width: width, height: 300)
        containerView.center = view.center

        containerView.layer.sublayers?.forEach({
            $0.removeFromSuperlayer()
        })

        setupTextLayer()
    }
}
