//
//  ViewController.swift
//  Transcribe
//
//  Created by asowers1 on 02/29/2016.
//  Copyright (c) 2016 asowers1. All rights reserved.
//

import UIKit
import Transcribe

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      var q = TSQueue<String>()
      
      q.enQueue("aaaa")
      q.enQueue("bbbb")
      q.enQueue("cccc")
      
      let a = q.deQueue()
      
      print(a)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

