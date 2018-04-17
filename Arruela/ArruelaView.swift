//
//  ArruelaView.swift
//  Arruela
//
//  Created by Rodrigo Goncalez on 17/04/2018.
//  Copyright © 2018 Arruela. All rights reserved.
//

import UIKit

class ArruelaView: UIView {
    let teste = UIView()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
        self.clipsToBounds = true
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 200,y: 200), radius: CGFloat(100), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: false)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.clear.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.red.cgColor
        //you can change the line width
        shapeLayer.lineWidth = 3.0
        
        self.layer.addSublayer(shapeLayer)
        
       teste.frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
        teste.backgroundColor = UIColor.blue
        teste.isUserInteractionEnabled = true
        self.addSubview(teste)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            // do something with your currentPoint
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            // do something with your currentPoint
            teste.center = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            // do something with your currentPoint
            teste.center = currentPoint
        }
    }

}
