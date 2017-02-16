//
//  ViewController.swift
//  projectKazu
//
//  Created by Apple on 2017/02/10.
//  Copyright © 2017年 Sasaki Kazuhiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mySwitch: UISwitch!
    
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func changeSwitch(_ sender: UISwitch) {
        print(sender.isOn)
        
        if sender.isOn {
            print("スイッチON")
        }else{
            print("スイッチOFF")
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

