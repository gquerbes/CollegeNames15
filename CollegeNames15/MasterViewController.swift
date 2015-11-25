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
    var UniversityObjectArray = [UniversitiesClass]()

    //function to create universitites
    func createUniversities() -> [UniversitiesClass]{
        var universitiesArray = [UniversitiesClass]()
    
        let uni1 = UniversitiesClass(name: "George Mason University", address: "Fairfax City", URL: "http://www.gmu.edu", studentCount: 33000, imageUrl: "", id: 1)
        universitiesArray.append(uni1)
        
        let uni2 = UniversitiesClass(name: "Virginia Tech", address: "Blacksburg", URL: "http://www.VT.edu", studentCount: 3000,imageUrl: "", id: 2)
        universitiesArray.append(uni2)
        
        let uni3 = UniversitiesClass(name: "University of Virginia", address: "Charlottesville", URL: "http://www.UVA.edu", studentCount: 21000,imageUrl: "", id: 3)
        universitiesArray.append(uni3)
        
        let uni4 = UniversitiesClass(name: "Virginia Commonwealth University", address: "Blacksburg", URL: "http://www.VCU.edu", studentCount: 33000,imageUrl: "", id: 4)
        universitiesArray.append(uni4)
        
        return universitiesArray
    }
    
    //function to create universitites with JSON data
    func createUniversitiesFromJSON()->[UniversitiesClass]{
        var universitiesArray = [UniversitiesClass]()
        
        //url of JSON data
        let restURL: NSURL = NSURL(string:"http://www.protogic.com/universityservice/service.svc/AllUniversity")!
        
        //NSData type used to hold the contents of the data that comes from JSON
        let jsonURLData = NSData(contentsOfURL:restURL)
        
        //print(jsonURLData)
        
        //if there is data that came in from JSON url, populate data into a dictionary
        if(jsonURLData != nil){
            
            
            let aDictionary: NSDictionary =
            //NSJSONSerialization converts NSData from one type to another
            (try! NSJSONSerialization.JSONObjectWithData(jsonURLData!, options: NSJSONReadingOptions.MutableContainers))as! NSDictionary
            
            print(aDictionary)
            
            //grab the JSON data of ALL universities
            let UniversityList = aDictionary["Universities"] as![[String: AnyObject]]
            
            //loop through all the items in the universtiyList
            for index in  1...UniversityList.count{
              
                //grab the university at position 
                var singleUniversity = UniversityList[index - 1]
                
                //pull the data from singleUniversity and set each value to a new variable
                let uName = singleUniversity["UniversityName"]! as? String
                let uAdd = singleUniversity["UniversityAddress"]! as? String
                let uURL = singleUniversity["UniversityURL"]! as? String
                let uCount = singleUniversity["UniversityStudentCount"]! as? Int
                let uImageUrl = singleUniversity["UniversityImageURL"]! as? String
                let uID = singleUniversity["UniversityID"]! as? Int
                
                //initialize a new university using data from signelUniversity
                let uni1 = UniversitiesClass(name:uName!, address:uAdd!, URL:uURL!, studentCount:uCount!, imageUrl:uImageUrl!, id:uID!)
                
                //add university to array of universities
                universitiesArray.append(uni1)
            }
            
            
    
        }
        
        return universitiesArray
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //call function to create univerisites and populate array of university objects
        UniversityObjectArray = createUniversitiesFromJSON()
        
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
                let selectedUniversity = UniversityObjectArray[indexPath.row] as UniversitiesClass
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

        let object = UniversityObjectArray[indexPath.row] as UniversitiesClass
        //main label wil show name of university
        cell.textLabel!.text = object.name
       
        //detail label will show address
        cell.detailTextLabel!.text = object.address
    
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

