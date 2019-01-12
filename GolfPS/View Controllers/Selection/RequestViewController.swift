//
//  RequestViewController.swift
//  GolfPS
//
//  Created by Greg DeJong on 7/26/18.
//  Copyright © 2018 DeJong Development. All rights reserved.
//

import UIKit
import MessageUI


extension RequestViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "unwindFromRequest", sender: nil)
    }
}

class RequestViewController: UIViewController {

    @IBOutlet weak var courseNameField: UITextField!
    @IBOutlet weak var courseCityField: UITextField!
    @IBOutlet weak var courseStateField: UITextField!
    @IBOutlet weak var courseCountryField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.layer.cornerRadius = 8
        submitButton.layer.masksToBounds = true
        
        cancelButton.layer.cornerRadius = 8
        cancelButton.layer.masksToBounds = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func doneWithName(_ sender: UITextField) {
        sender.resignFirstResponder();
        courseCityField.becomeFirstResponder()
    }
    @IBAction func doneWithCity(_ sender: UITextField) {
        sender.resignFirstResponder();
        courseStateField.becomeFirstResponder()
    }
    @IBAction func doneWithState(_ sender: UITextField) {
        sender.resignFirstResponder();
        courseCountryField.becomeFirstResponder()
    }
    @IBAction func doneWithCountry(_ sender: UITextField) {
        sender.resignFirstResponder();
    }
    
    @IBAction func clickSubmit(_ sender: UIButton) {
        let composeVC:MFMailComposeViewController? = MFMailComposeViewController()
        if (composeVC != nil) {
            composeVC!.mailComposeDelegate = self
            
            // Configure the fields of the interface.
            composeVC!.setToRecipients(["flummoxedcosmos@gmail.com"])
            composeVC!.setSubject("GolfPS Course Request")
            composeVC!.setMessageBody("Hey! I'd like to have my course added to the database. \nNAME:\(courseNameField.text ?? "unknown") \nCITY:\(courseCityField.text ?? "unknown") \nSTATE:\(courseStateField.text ?? "unknown") \n\(courseCountryField.text ?? "unknown").", isHTML: false)
            
            self.present(composeVC!, animated: true, completion: nil)
        }
    }
    @IBAction func clickCancel(_ sender: UIButton) {
        //tied to unwind segue back to course selection
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
