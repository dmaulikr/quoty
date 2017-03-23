//
//  ViewController.swift
//  quoty
//
//  Created by Marvin Messenzehl on 13.03.17.
//  Copyright © 2017 Marvin Messenzehl. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {

    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var quoteTextLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    
    @IBAction func tweetButtonTapped(_ sender: Any) {
        if(SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)) {
            let socialController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            //TODO: Add initial text (quote)
            
            self.present(socialController!, animated: true, completion: nil)
            //TODO: give feedback for actions
        } //TODO: Else case --> open web
    }
    
    @IBAction func newButtonTapped(_ sender: Any) {
        let resource = QuoteResource()
        resource.fetchData { (response) in
            // write data in view
            self.quoteTextLabel.text = response.text
            self.authorLabel.text = "- \(response.author)"
        }
        
        //TODO: Add the color change
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let resource = QuoteResource()
        resource.fetchData { (response) in
            // write data in view
            self.quoteTextLabel.text = response.text
            self.authorLabel.text = "- \(response.author)"
            
            self.quoteTextLabel.isHidden = false
            self.authorLabel.isHidden = false
        }
    }

    
}

