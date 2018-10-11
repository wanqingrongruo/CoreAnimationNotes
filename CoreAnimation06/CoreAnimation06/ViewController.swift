//
//  ViewController.swift
//  CoreAnimation06
//
//  Created by roni on 2018/10/9.
//  Copyright © 2018 roni. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    enum ChapterType {
        case shapeLayer
        case textLayer
        case transformLayer
        case gradientLayer
        case replicatorLayer
        case scrollerLayer
        case tiledLayer
        case emitterLayer
        case eagLayer
    }
    struct Option {
        var title: String
        var vc: String
        var type: ChapterType
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "专用图层"
        setUI()
    }
    
    override func viewWillLayoutSubviews() {
        tableView.frame = view.bounds
    }

    override func handleOrientation() {}

    func setUI() {
        tableView.frame = view.bounds
        view.addSubview(tableView)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
    }

    lazy var dataSource: [Option] = {
        var array = [Option]()

        let option01 = Option(title: "CAShapeLayer", vc: "ShapeLayerViewController", type: .shapeLayer)
        array.append(option01)

        let option02 = Option(title: "CATextLayer", vc: "TextLayerViewController", type: .textLayer)
        array.append(option02)

        let option03 = Option(title: "CATransfornmLayer", vc: "TransfornmLayerViewController", type: .transformLayer)
        array.append(option03)

        let option04 = Option(title: "CAGradientLayer", vc: "GradientLayerViewController", type: .gradientLayer)
        array.append(option04)

        let option05 = Option(title: "CAReplicatorLayer", vc: "ReplicatorLayerViewController", type: .replicatorLayer)
        array.append(option05)

        return array
    }()


    internal let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = UIColor.clear
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.showsVerticalScrollIndicator = true
        return tableView
    }()
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let item = dataSource[indexPath.section]
        cell.textLabel?.text = item.title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let item = dataSource[indexPath.section]
        let nameSpace = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String ?? ""
        let vcString = nameSpace + "." + item.vc

        func generateVC(vc: UIViewController.Type) {
            let cls = vc.init()
            cls.title = item.title
            navigationController?.pushViewController(cls, animated: true)
        }

        switch item.type {
        case .shapeLayer:
            if let clz = NSClassFromString(vcString) as? ShapeLayerViewController.Type {
                generateVC(vc: clz)
            }
        case .textLayer:
            if let clz = NSClassFromString(vcString) as? TextLayerViewController.Type {
                generateVC(vc: clz)
            }
        case .transformLayer:
            if let clz = NSClassFromString(vcString) as? TransfornmLayerViewController.Type {
                generateVC(vc: clz)
            }
        case .gradientLayer:
            if let clz = NSClassFromString(vcString) as? GradientLayerViewController.Type {
                generateVC(vc: clz)
            }
        case .replicatorLayer:
            if let clz = NSClassFromString(vcString) as? ReplicatorLayerViewController.Type {
                generateVC(vc: clz)
            }
        default:
            break
        }
    }
}

