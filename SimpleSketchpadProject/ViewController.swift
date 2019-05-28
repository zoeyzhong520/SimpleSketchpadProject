//
//  ViewController.swift
//  SimpleSketchpadProject
//
//  Created by zhifu360 on 2019/5/28.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    ///创建画板
    lazy var sketchpadView: SketchpadView = {
        let view = SketchpadView(frame: self.view.bounds)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setPage()
    }

    func setPage() {
        view.backgroundColor = .white
        view.addSubview(sketchpadView)
        setColorSelectView()
    }
    
    func setColorSelectView() {
        let colorArr = [UIColor.purple,UIColor.blue,UIColor.orange,UIColor.red,UIColor.black]
        let btnW: CGFloat = 50
        let btnH: CGFloat = 50
        let verticalMaigin: CGFloat = 10
        for i in 0..<colorArr.count {
            let btn = UIButton(frame: CGRect(x: view.bounds.size.width - btnW - verticalMaigin, y:
                view.bounds.size.height - verticalMaigin - btnH - (CGFloat(i)*(btnH+verticalMaigin)), width: btnW, height: btnH))
            btn.layer.cornerRadius = btnH/2
            btn.backgroundColor = colorArr[i]
            btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
            view.addSubview(btn)
        }
    }
    
    func setNavigation() {
        title = "演示"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "清空", style: .plain, target: self, action: #selector(clearSketchpad))
    }
    
    @objc func clearSketchpad() {
        sketchpadView.clearAll()
    }
    
    @objc func btnAction(_ btn: UIButton) {
        sketchpadView.lineColor = btn.backgroundColor!
    }

}

