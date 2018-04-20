//
//  ArruelaView.swift
//  Arruela
//
//  Created by Rodrigo Goncalez on 17/04/2018.
//  Copyright © 2018 Arruela. All rights reserved.
//

import UIKit

protocol ArruelaViewDelegate:class {
    func getPosition(position: Double)
}

class ArruelaView: UIView {
    let Knob = UIView()
    
    var circleCenterX = Float()
    var circleCenterY = Float()
    var circleRadius = Float()
    
    weak var delegate: ArruelaViewDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = UIColor.yellow
        
        circleCenterX = Float(self.frame.size.width) / 2
        circleCenterY = Float(self.frame.size.height) / 2
        circleRadius = 120.0
        self.clipsToBounds = true
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: CGFloat(circleCenterX), y:  CGFloat(circleCenterY)), radius: CGFloat(circleRadius), startAngle: CGFloat(degressToRadians(radians: -100)), endAngle:CGFloat(degressToRadians(radians: -80)), clockwise: false)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.clear.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.red.cgColor
        //you can change the line width
        shapeLayer.lineWidth = 4.0
        self.layer.addSublayer(shapeLayer)
        
        let color1 = UIColor(red: 225/255.0, green: 255/255.0, blue: 80/255.0, alpha: 1)
        let color2 = UIColor(red: 0/255.0, green: 234/255.0, blue: 214/255.0, alpha: 1)
        let rect = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        let gradient = CAGradientLayer()
        gradient.frame = rect
        gradient.colors = [color1.cgColor,
                           color2.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.mask = shapeLayer

        self.layer.addSublayer(gradient)
        
        Knob.frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
        Knob.backgroundColor = UIColor.blue
        Knob.isUserInteractionEnabled = true
        self.addSubview(Knob)
        
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
        let distanceX = touchX - circleCenterX
        let distanceY = circleCenterY - touchY
        let b = distanceX*distanceX
        let c = distanceY*distanceY
        let a = sqrt(b + c)
        return a
    }
    
    private func radiansToDegrees(degrees:Double) -> Double{
        return degrees * 180 / .pi
    }
    
    func addThumb(position: Double) {
        let angle = convertPositionToAngle(position: position)
        let thumbX = Double((Double(circleCenterX) + Double(circleRadius) * cos(angle)))
        let thumbY = Double((Double(circleCenterY) - Double(circleRadius) * sin(angle)))
        let point = CGPoint(x: thumbX, y: thumbY)
        
        let thumb = UIView()
        thumb.frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
        thumb.backgroundColor = UIColor.gray
        thumb.isUserInteractionEnabled = true
        self.addSubview(thumb)
        thumb.center = point
        self.bringSubview(toFront: Knob)
        
    }
    
    func setPosition(position: Double) {
        let angle = convertPositionToAngle(position: position)
        let thumbX = Double((Double(circleCenterX) + Double(circleRadius) * cos(angle)))
        let thumbY = Double((Double(circleCenterY) - Double(circleRadius) * sin(angle)))
        let point = CGPoint(x: thumbX, y: thumbY)
        
        Knob.center = point
    }
    
    private func degressToRadians(radians:Double) -> Double{
        return radians * .pi / 180
    }

    private func convertPositionToAngle(position: Double) -> Double{
        let toAngle = (position * 340) / 100
        var normalizedAngle = 0.0
        if (80 > toAngle) {
            normalizedAngle = 80.0 - toAngle
        } else {
            normalizedAngle = 360 - abs(toAngle - 80)
        }
        return degressToRadians(radians:normalizedAngle)
    }
    
    private func distanceBetweensTwoAnglesInClockWise(angle: Double) -> Double {
        let degrees = radiansToDegrees(degrees: angle)
        var distance = Double()
        if (degrees > 80) {
            distance = 340.0 - (degrees - 80.0)
        } else {
            distance = 80.0 - degrees
        }
        return distance
    }

    private func calculatePosition(degress: Double) -> Double {
        let distance = self.distanceBetweensTwoAnglesInClockWise(angle: degress)
        return ((distance * 100) / 340)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            let angle = calculateAngle(touchX: Float(currentPoint.x), touchY: Float(currentPoint.y))
            // do something with your currentPoint
            
            let thumbX = Double((circleCenterX + circleRadius * cos(angle)))
            let thumbY = Double((circleCenterY - circleRadius * sin(angle)))
            
            let point = CGPoint(x: thumbX, y: thumbY)
            
            let degrees = self.radiansToDegrees(degrees: Double(angle))
            let angleAux = (Int(degrees) + 360) % 360
            if (!(angleAux < 100 && angleAux > 80)) {
                Knob.center = point
                delegate?.getPosition(position: self.calculatePosition(degress: degrees))
            }
        }
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let currentPoint = touch.location(in: self)
//            let angle = calculateAngle(touchX: Float(currentPoint.x), touchY: Float(currentPoint.y))
//            // do something with your currentPoint
//
//            let thumbX = Double((150 + 100 * cos(angle)))
//            let thumbY = Double((150 - 100 * sin(angle)))
//            let point = CGPoint(x: thumbX, y: thumbY)
//
//            let degrees = self.radiansToDegrees(degrees: Double(angle))
//            let angleAux = (Int(degrees) + 360) % 360
//            if (!(angleAux < 100 && angleAux > 80)) {
//                Knob.center = point
//                delegate?.getPosition(position: self.calculatePosition(degress: degrees))
//            }
//        }
//    }

}
