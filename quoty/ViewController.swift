//
//  ViewController.swift
//  quoty
//
//  Created by Marvin Messenzehl on 13.03.17.
//  Copyright © 2017 Marvin Messenzehl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let resource = QuoteResource()
        resource.fetchData { (response) in
            // TODO: write data in view
        }
    }

    
}

