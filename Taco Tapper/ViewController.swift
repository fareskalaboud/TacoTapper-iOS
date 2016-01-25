//
//  ViewController.swift
//  Taco Tapper
//
//  Created by Fares Alaboud on 23/01/2016.
//  Copyright © 2016 Fares K. Alaboud. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var logoImageView : UIImageView!
    @IBOutlet weak var howManyTapsTxtField : UITextField!
    @IBOutlet weak var playButton : UIButton!
    @IBOutlet weak var tacoButton : UIButton!
    @IBOutlet weak var tapsLabel : UILabel!
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet var backArrow: UIButton!
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!

    @IBAction func dismissKeyboard(sender: UITapGestureRecognizer)
    {
        howManyTapsTxtField.resignFirstResponder()
    }
    
    var maxTaps : Int = 0
    var currentTaps : Int = 0
    
    override func viewWillAppear(animated: Bool) {
        howManyTapsTxtField.delegate = self
    }
    
    @IBAction func startGame(sender: UIButton) {
        if howManyTapsTxtField.text != nil && howManyTapsTxtField.text != "" {
            if Int(howManyTapsTxtField.text!)! <= 999999 {
                toggleHiddenControls()
                maxTaps = Int(howManyTapsTxtField.text!)!
                updateTapsLabel()
            } else {
                alert("Max Taps: 999,999", message: "A bit too ambitious, eh amigo?")
            }
        } else {
                alert("Input Number", message: "You haven't told me how many tacos you want to tap!")
        }
    }
    
    @IBAction func tap(sender: UIButton) {
        currentTaps++
        updateTapsLabel()
        
        if isGameOver() {
            tacoButton.enabled = false
            tapsLabel.text = "Share your victory!"
            toggleSharingOptions()
        }
    }
    
    func toggleHiddenControls() {
        logoImageView.hidden = !logoImageView.hidden
        howManyTapsTxtField.hidden = !howManyTapsTxtField.hidden
        playButton.hidden = !playButton.hidden
        
        tacoButton.hidden = !tacoButton.hidden
        tapsLabel.hidden = !tapsLabel.hidden
    }
    
    func updateTapsLabel() {
        tapsLabel.text = "\(currentTaps) Taps"
    }
    
    @IBAction func restartGame(sender: UIButton!) {
        maxTaps = 0
        currentTaps = 0
        tapsLabel.text = "\(currentTaps) Taps"
        tacoButton.enabled = true
        
        
        toggleHiddenControls()
        toggleSharingOptions()
    }
    
    func isGameOver() -> Bool {
        if currentTaps >= maxTaps {
            return true
        } else {
            return false
        }
    }
    
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: .Alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .Default) { (action) in })
        
        self.presentViewController(alertController, animated: true) {
            
        }
    }
    

    @IBAction func infoButtonPressed(sender: AnyObject) {
        alert("Taco Tapper v1.0", message: "Written by Fares Alaboud.\n\nBuilt as an extension to exercises from the iOS 9 & Swift 2 course by Mark Price of Devslopes.\n\nAssets from Textcraft and Freepik.")
    }
    
    func toggleSharingOptions() {
        facebookButton.hidden = !facebookButton.hidden
        twitterButton.hidden = !twitterButton.hidden
        backArrow.hidden = !backArrow.hidden
    }
    
    @IBAction func twitterButtonPushed(sender: UIButton) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("I tapped \(maxTaps) tacos on Taco Tapper! Check out #TacoTapper on http://tt.fares.ws")
            self.presentViewController(twitterSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please go to your settings, log in to a Twitter account and come back here to share your taco tapping victory.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func facebookButtonPushed(sender: UIButton) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("I tapped \(maxTaps) tacos on Taco Tapper! Check out #TacoTapper on http://tt.fares.ws")
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please go to your settings, log in to a Facebook account and come back here to share your taco tapping victory.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // MARK - Delegate Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
}
