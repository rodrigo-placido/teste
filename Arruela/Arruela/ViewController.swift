//
//  ViewController.swift
//  Arruela
//
//  Created by viniciusmo on 4/17/18.
//  Copyright © 2018 Arruela. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 200,y: 200), radius: CGFloat(100), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: false)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.clear.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.red.cgColor
        //you can change the line width
        shapeLayer.lineWidth = 3.0
        
        view.layer.addSublayer(shapeLayer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

