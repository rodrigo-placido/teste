//
//  ArruelaView.swift
//  Arruela
//
//  Created by Rodrigo Goncalez on 17/04/2018.
//  Copyright © 2018 Arruela. All rights reserved.
//

import UIKit

class ArruelaView: UIView {

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
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 200,y: 200), radius: CGFloat(100), startAngle: CGFloat((Double.pi * 3)/4), endAngle:CGFloat(Double.pi / 4), clockwise: false)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.clear.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.red.cgColor
        //you can change the line width
        shapeLayer.lineWidth = 3.0
        
        self.layer.addSublayer(shapeLayer)
    }

}
