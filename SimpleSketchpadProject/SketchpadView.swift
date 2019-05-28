//
//  SketchpadView.swift
//  SimpleSketchpadProject
//
//  Created by zhifu360 on 2019/5/28.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class SketchpadView: UIView {

    ///线条颜色
    var lineColor = UIColor.black
    
    ///线宽
    var lineWidth: CGFloat = 1
    
    ///所有的线
    var allLineArray = [[CGPoint]]()
    
    ///当前划线的点
    var currentPointArray = [CGPoint]()
    
    ///所有的线宽
    var lineWidthArray = [CGFloat]()
    
    ///所有的线条颜色
    var lineColorArray = [UIColor]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        //获取上下文
        let context = UIGraphicsGetCurrentContext()
        context?.setLineCap(.round)
        context?.setLineJoin(.round)
        
        //绘制之前的线
        if allLineArray.count > 0 {
            //遍历之前的线
            for i in 0..<allLineArray.count {
                let tmpArr = allLineArray[i]
                if tmpArr.count > 0 {
                    //画线
                    context?.beginPath()
                    //取出起始点
                    let sPoint = tmpArr[0]
                    context?.move(to: sPoint)
                    //取出所有当前线的点
                    for j in 0..<tmpArr.count {
                        let endPoint = tmpArr[j]
                        context?.addLine(to: endPoint)
                    }
                    //设置线宽 颜色
                    context?.setLineWidth(lineWidthArray[i])
                    context?.setStrokeColor(lineColorArray[i].cgColor)
                    context?.strokePath()
                }
            }
        }
        
        //绘制当前线
        if currentPointArray.count > 0 {
            context?.beginPath()
            context?.setLineWidth(lineWidth)
            context?.setStrokeColor(lineColor.cgColor)
            context?.move(to: currentPointArray [0])
            for i in 0..<currentPointArray.count {
                context?.addLine(to: currentPointArray[i])
            }
            context?.strokePath()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = event?.allTouches?.first?.location(in: self)
        currentPointArray.append(point!)
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = event?.allTouches?.first?.location(in: self)
        currentPointArray.append(point!)
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //触摸结束后，存线、存线宽、清空当前线
        allLineArray.append(currentPointArray)
        lineWidthArray.append(lineWidth)
        lineColorArray.append(lineColor)
        currentPointArray.removeAll()
        setNeedsDisplay()
    }
    
    ///清空画板
    func clearAll() {
        allLineArray.removeAll()
        currentPointArray.removeAll()
        lineWidthArray.removeAll()
        lineColorArray.removeAll()
        setNeedsDisplay()
    }

}
