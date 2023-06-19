//
//  ViewController.swift
//  PopViewUIKit
//
//  Created by S JZ on 2023/6/19.
//

import UIKit

class ViewController: UIViewController {

    let textPop = TextPop(text: "1231231313131")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textPop.show()
    }
}

