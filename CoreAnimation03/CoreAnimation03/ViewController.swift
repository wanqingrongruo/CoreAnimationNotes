//
//  ViewController.swift
//  CoreAnimation03
//
//  Created by roni on 2018/7/5.
//  Copyright © 2018年 roni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 坐标系
        // 是否是左手坐标系 => view.layer.isGeometryFlipped
        // 层次顺序 => view.layer.zPosition

        // Hit Testing
        hitTestAction()
    }

    private lazy var centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    let blueLayer = CALayer()

    func hitTestAction() {

        centerView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        centerView.center = view.center
        view.addSubview(centerView)

        blueLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        blueLayer.backgroundColor = UIColor.blue.cgColor

        centerView.layer.addSublayer(blueLayer)

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: view) else { return }

        // 01: 使用 contains(:) 判断点击位置
//        var cPoint = view.layer.convert(point, to: centerView.layer)
//        if centerView.layer.contains(cPoint) {
//            cPoint = centerView.layer.convert(cPoint, to: blueLayer)
//            if blueLayer.contains(cPoint) {
//                showTip(title: "Inside blue layer")
//            } else {
//               showTip(title: "Inside red layer")
//            }
//        }

        // 02: 使用 hitTest(:) 判断点击位置
        let layer = view.layer.hitTest(point)
        guard let oLayer = layer else {
            showTip(title: "不存在")
            return
        }

        if oLayer.isEqual(blueLayer) {
            showTip(title: "Inside blue layer")
        } else if oLayer.isEqual(centerView.layer) {
            showTip(title: "Inside red layer")
        } else {
            showTip(title: "Inside self.view layer")
        }


    }

    func showTip(title: String?, message: String? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension ViewController: CALayerDelegate {
    func layoutSublayers(of layer: CALayer) {
        // 手动控制 layer 的布局
    }
}

