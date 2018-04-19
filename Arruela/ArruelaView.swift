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
    let circleCenterX:Float = 150.0
    let circleCenterY:Float = 150.0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
        self.clipsToBounds = true
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 150,y: 150), radius: CGFloat(100), startAngle: CGFloat(degressToRadians(radians: -100)), endAngle:CGFloat(degressToRadians(radians: -80)), clockwise: false)
        
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
    
    func calculateAngle(touchX: Float, touchY: Float) -> Float {
        let adjacent = touchX - circleCenterX
        let hypotenuse = calculateHypotenuse(touchX: touchX , touchY: touchY)
        let cosine = adjacent / hypotenuse
        var angle = acos(cosine)
        let distanceY = circleCenterY - touchY
        if (distanceY < 0) {
            angle = -angle
        }
        return angle
    }
    
    func calculateHypotenuse(touchX: Float, touchY: Float) -> Float {
        let distanceX = touchX - 150
        let distanceY = 150 - touchY
        let b = distanceX*distanceX
        let c = distanceY*distanceY
        let a = sqrt(b + c)
        return a
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            // do something with your currentPoint
        }
    }
    
    private func radiansToDegrees(degrees:Double) -> Double{
        return degrees * 180 / .pi
    }
    
    func setPosition(position: Double) {
        let angle = convertPositionToAngle(position: position)
        let thumbX = Double((150 + 100 * cos(angle)))
        let thumbY = Double((150 - 100 * sin(angle)))
        let point = CGPoint(x: thumbX, y: thumbY)
        
        teste.center = point
    }
    
    private func degressToRadians(radians:Double) -> Double{
        return radians * .pi / 180
    }

    private func convertPositionToAngle(position: Double) -> Double{
        let toAngle = (position * 360) / 100
        var normalizedAngle = 0.0
        if (90 > toAngle) {
            normalizedAngle = 90.0 - toAngle
        } else {
            normalizedAngle = 360 - abs(toAngle - 90)
        }
        return degressToRadians(radians:normalizedAngle)
    }

   
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            let angle = calculateAngle(touchX: Float(currentPoint.x), touchY: Float(currentPoint.y))
            // do something with your currentPoint
            
            let thumbX = Double((150 + 100 * cos(angle)))
            let thumbY = Double((150 - 100 * sin(angle)))
            let point = CGPoint(x: thumbX, y: thumbY)
            

            teste.center = point
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
