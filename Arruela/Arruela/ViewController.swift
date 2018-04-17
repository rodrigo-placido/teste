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
        let circle = ArruelaView(frame: CGRect(x: 10, y: 10, width: 300, height: 300))
        circle.setPosition(position: 0)
        self.view.addSubview(circle)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

