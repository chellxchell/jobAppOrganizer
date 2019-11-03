//
//  JobAppTableViewController.swift
//  jobAppOrganizer
//
//  Created by Medill on 11/1/19.
//  Copyright © 2019 Medill. All rights reserved.
//  FOR JOB APPLICATION TABLE VIEW

import UIKit
import os.log

class JobAppTableViewController: UITableViewController {
    //MARK: Properties
    
    var jobApps = [JobApp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.title = "You Job Applications"

        // Load the sample data.
        loadSampleJobApps()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobApps.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "JobAppTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? JobAppTableViewCell  else {
            fatalError("The dequeued cell is not an instance of JobAppTableViewCell.")
        }
        let jobApp = jobApps[indexPath.row]
        
        // Configure the cell...
        cell.nameLabel.text = jobApp.companyName
        cell.titleLabel.text = jobApp.jobTitle
        cell.responseLabel.text = jobApp.deadline

        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            jobApps.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new job app.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let jobAppDetailViewController = segue.destination as? JobAppViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedJobAppCell = sender as? JobAppTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedJobAppCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedJobApp = jobApps[indexPath.row]
            jobAppDetailViewController.jobApp = selectedJobApp
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    //MARK: Private Methods
    private func loadSampleJobApps() {
        let jobApp1 = JobApp(companyName: "Apple", jobTitle: "SWE Intern", location: ["Cupertino","CA"], deadline: "11/1/2019", jobLink: "apple.com", notes: "software engineering intern", coverLetter: false, applied: true)
        let jobApp2 = JobApp(companyName: "Microsoft", jobTitle: "SWE Intern", location: ["Seattle","WA"], deadline: "11/1/2019", jobLink: "microsoft.com", notes: "software engineering intern", coverLetter: true, applied: true)
        let jobApp3 = JobApp(companyName: "Google", jobTitle: "SWE Intern", location: ["Mountainview","CA"], deadline: "11/1/2019", jobLink: "google.com", notes: "software engineering intern", coverLetter: false, applied: true)
        jobApps += [jobApp1, jobApp2, jobApp3]
    }
    
    //MARK: Actions
    @IBAction func unwindToJobAppList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? JobAppViewController, let jobApp = sourceViewController.jobApp {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                jobApps[selectedIndexPath.row] = jobApp
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: jobApps.count, section: 0)
                
                jobApps.append(jobApp)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
}
