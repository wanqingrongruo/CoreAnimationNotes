//
//  ScrollLayerViewController.swift
//  CoreAnimation06
//
//  Created by roni on 2018/10/11.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit

class CustomScrollView: UIView {
    override open class var layerClass: AnyClass {
        return CAScrollLayer.self
    }

    func setup() {
        layer.masksToBounds = true

        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(gesture:)))
        addGestureRecognizer(pan)
    }

    @objc func pan(gesture: UIPanGestureRecognizer) {
        var offset = bounds.origin
        offset.x -= gesture.translation(in: self).x
        offset.y -= gesture.translation(in: self).y

        let layer = self.layer as! CAScrollLayer
        layer.scroll(to: offset)

        gesture.setTranslation(.zero, in: self)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        setup()
    }
}

class ScrollLayerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let action = UIAlertAction(title: "确定", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        let actionSheet = UIAlertController(title: "提示", message: "What can i do for you", preferredStyle: .alert)
        actionSheet.addAction(action)
        DispatchQueue.main.async {
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
}
