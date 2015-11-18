//
//  MasterViewController.swift
//  CollegeNames15
//
//  Created by Gabriel Querbes on 11/17/15.
//  Copyright © 2015 The Modern Tech. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()
    
    //creating an object array of universities
    var UniversityObjectArray = [UnivsersitiesClass]()

    //function to create universitites
    func createUniversities() -> [UnivsersitiesClass]{
        var universitiesArray = [UnivsersitiesClass]()
    
        let uni1 = UnivsersitiesClass(name: "George Mason University", address: "Fairfax City", URL: "http://www.gmu.edu", studentCount: 33000)
        universitiesArray.append(uni1)
        
        let uni2 = UnivsersitiesClass(name: "Virginia Tech", address: "Blacksburg", URL: "http://www.VT.edu", studentCount: 3000)
        universitiesArray.append(uni2)
        
        let uni3 = UnivsersitiesClass(name: "University of Virginia", address: "Charlottesville", URL: "http://www.UVA.edu", studentCount: 21000)
        universitiesArray.append(uni3)
        
        let uni4 = UnivsersitiesClass(name: "Virginia Commonwealth University", address: "Blacksburg", URL: "http://www.VCU.edu", studentCount: 33000)
        universitiesArray.append(uni4)
        
        return universitiesArray
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //call function to create univerisites and populate array of university objects
        UniversityObjectArray = createUniversities()
        
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedUniversity = UniversityObjectArray[indexPath.row] as UnivsersitiesClass
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                //detail item comes from detail contorller
                controller.detailItem = selectedUniversity
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View
    // "mark:" allows functions to be grouped together
   
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // sets table view with enough space for each element in array
        return  UniversityObjectArray.count
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = UniversityObjectArray[indexPath.row] as UnivsersitiesClass
        cell.textLabel!.text = object.name
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

