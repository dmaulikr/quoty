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
    
    @IBOutlet weak var quoteTextLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    
    @IBAction func tweetButtonTapped(_ sender: Any) {
        if(SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)) {
            let socialController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            socialController?.setInitialText("#quotyapp \n\(quoteTextLabel.text!) \n\(authorLabel.text!)")
            
            self.present(socialController!, animated: true, completion: nil)
            //TODO: give feedback for actions
        } else /*open web*/{
            let tweetText = "#quotyapp \n\(quoteTextLabel.text!) \n\(authorLabel.text!)"
            let shareString = "https://twitter.com/intent/tweet?text=\(tweetText)"
            // encode a space to %20 for example
            let escapedShareString = shareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            // cast to an url
            let url = URL(string: escapedShareString)
            
            // open in safari
            UIApplication.shared.openURL(url!)
        }
    }
    
    @IBAction func newButtonTapped(_ sender: Any) {
        let resource = QuoteResource()
        resource.fetchData { (response) in
            // write data in view
            self.quoteTextLabel.text = response.text
            self.authorLabel.text = "- \(response.author)"
        }
        
        //add color transition
        let color = randomColor()
        
        UIView.animate(withDuration: 2.0) { 
            self.view.backgroundColor = color
            self.tweetButton.backgroundColor = color
            self.newButton.backgroundColor = color
        }
    }
    
    
    
    //
    private func randomColor() -> UIColor {
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
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


