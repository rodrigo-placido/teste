//
//  ViewController.swift
//  Arruela
//
//  Created by viniciusmo on 4/17/18.
//  Copyright © 2018 Arruela. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ArruelaViewDelegate {
    var label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        let circle = ArruelaView(frame: CGRect(x: 50, y: 50, width: 260, height: 260))
        circle.delegate = self
        circle.setPosition(position: 0)
        circle.addThumb(position: 30)
        self.view.addSubview(circle)
        
        label.frame = CGRect(x: 0.0, y: 0.0, width: 80, height: 30)
        label.center = circle.center
        self.view.addSubview(label)
        
    }
    
    func getPosition(position: Double) {
        print(position)
        label.text = "\(position)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

