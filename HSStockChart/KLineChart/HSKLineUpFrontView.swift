//
//  HSHighLight.swift
//  HSStockChartDemo
//
//  Created by Hanson on 2017/2/16.
//  Copyright © 2017年 hanson. All rights reserved.
//

import UIKit

class HSKLineUpFrontView: UIView, HSDrawLayerProtocol {
    
    var rrText = CATextLayer()
    var volText = CATextLayer()
    var maxMark = CATextLayer()
    var secMaxMark = CATextLayer()
    var midMark = CATextLayer()
    var secMinMark = CATextLayer()
    var minMark = CATextLayer()
    var maxVolMark = CATextLayer()
    var yAxisLayer = CAShapeLayer()
    
    var corssLineLayer = CAShapeLayer()
    var volMarkLayer = CATextLayer()
    var leftMarkLayer = CATextLayer()
    var bottomMarkLayer = CATextLayer()
    var yAxisMarkLayer = CATextLayer()
    
    var uperChartHeight: CGFloat {
        get {
            return theme.uperChartHeightScale * (self.frame.height - theme.bottomHeight)
        }
    }
    var lowerChartTop: CGFloat {
        get {
            return uperChartHeight + theme.xAxisHeitht
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        drawMarkLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == self {
            // 交给下一层级的view响应事件（解决该 view 在 scrollView 上面到时scrollView无法滚动问题）
            return nil
        }
        return view
    }
    
    func configureAxis(max: CGFloat, min: CGFloat, maxVol: CGFloat) {
        let maxPriceStr = max.hschart.toStringWithFormat(".2")
        let minPriceStr = min.hschart.toStringWithFormat(".2")
        let midPriceStr = ((max + min) / 2).hschart.toStringWithFormat(".2")
        let secMaxPriceStr = ((max + (max + min) / 2) / 2).hschart.toStringWithFormat(".2")
        let secMinPriceStr = ((min + (max + min) / 2) / 2).hschart.toStringWithFormat(".2")
        maxMark.string = maxPriceStr
        minMark.string = minPriceStr
        midMark.string = midPriceStr
        secMaxMark.string = secMaxPriceStr
        secMinMark.string = secMinPriceStr
        
//        let maxVolStr = maxVol.hschart.toStringWithFormat(".2")
//        maxVolMark.string = maxVolStr
    }
    
    func drawMarkLayer() {

        maxMark = getYAxisMarkLayer(frame: frame, text: "0.00", y: theme.viewMinYGap, isLeft: false)
        minMark = getYAxisMarkLayer(frame: frame, text: "0.00", y: uperChartHeight - theme.viewMinYGap, isLeft: false)
        midMark = getYAxisMarkLayer(frame: frame, text: "0.00", y: uperChartHeight / 2, isLeft: false)
        secMaxMark = getYAxisMarkLayer(frame: frame, text: "0.00", y: uperChartHeight / 4, isLeft: false)
        secMinMark = getYAxisMarkLayer(frame: frame, text: "0.00", y: uperChartHeight * 3 / 4, isLeft: false)
        
        self.layer.addSublayer(maxMark)
        self.layer.addSublayer(minMark)
        self.layer.addSublayer(midMark)
        self.layer.addSublayer(secMinMark)
        self.layer.addSublayer(secMaxMark)
        
//        rrText = getYAxisMarkLayer(frame: frame, text: "不复权", y: theme.viewMinYGap, isLeft: true)
//        volText = getYAxisMarkLayer(frame: frame, text: "成交量", y: lowerChartTop + theme.volumeGap, isLeft: true)
//        maxVolMark = getYAxisMarkLayer(frame: frame, text: "0.00", y: lowerChartTop + theme.volumeGap, isLeft: false)
//        self.layer.addSublayer(rrText)
//        self.layer.addSublayer(volText)
//        self.layer.addSublayer(maxVolMark)
    }
    
    func drawCrossLine(pricePoint: CGPoint, volumePoint: CGPoint, model: AnyObject?) {
        corssLineLayer.removeFromSuperlayer()
        corssLineLayer = getCrossLineLayer(frame: frame, pricePoint: pricePoint, volumePoint: volumePoint, model: model)
        self.layer.addSublayer(corssLineLayer)
    }
    
    func removeCrossLine() {
        self.corssLineLayer.removeFromSuperlayer()
    }
}
