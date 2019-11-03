//
//  JobAppViewController.swift
//  jobAppOrganizer
//
//  Created by Medill on 11/1/19.
//  Copyright © 2019 Medill. All rights reserved.
//  FOR "NEW JOB APPLICATION" FORM

import UIKit
import os.log

class JobAppViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var companyName: UITextField!
    @IBOutlet weak var jobTitle: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var deadline: UITextField!
    @IBOutlet weak var link: UITextField!
    @IBOutlet weak var coverletter: UITextField!
    @IBOutlet weak var applied: UITextField!
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var jobApp: JobApp?

    // MARK: Navigation
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        // Set the jobApp to be passed to JobAppTableViewController after the unwind segue.
        jobApp = JobApp(companyName: companyName.text!, jobTitle: jobTitle.text!, location: [city.text!,state.text!], deadline: deadline.text!, jobLink: link.text!, notes: notes.text!, coverLetter: isTrue(att: coverletter.text!), applied: isTrue(att: applied.text!))
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    // MARK: Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        companyName.delegate = self
        
        // Set up views if editing an existing Job Application.
        if let jobApp = jobApp {
            navigationItem.title = jobApp.companyName
            companyName.text = jobApp.companyName
            jobTitle.text = jobApp.jobTitle
            city.text = (jobApp.location!).first
            state.text = (jobApp.location!).last
            deadline.text = jobApp.deadline
            link.text = jobApp.jobLink
            coverletter.text = boolToString(val: jobApp.coverLetter!)
            applied.text = boolToString(val: jobApp.applied!)
            notes.text = jobApp.notes
        }
        
        // Enable the Save button only if the text field has a valid Job Application name.
        updateSaveButtonState()
    }
    
    // converts string "yes" or "no" to boolean value
    func isTrue(att: String) -> Bool{
        if (att=="yes" || att=="Yes" || att=="Y" || att=="y"){
            return true
        }
        else{
            return false
        }
    }
    
    // converts boolean value to readable string
    func boolToString(val: Bool) -> String{
        if (val == true){
            return "yes"
        }
        else{
            return "no"
        }
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = companyName.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

}

