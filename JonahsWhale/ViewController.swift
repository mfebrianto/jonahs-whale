//
//  ViewController.swift
//  JonahsWhale
//
//  Created by michael febrianto on 21/08/2016.
//  Copyright © 2016 mfebrianto. All rights reserved.
//

import UIKit
import CoreData
import XCGLogger

class ViewController: UIViewController {
    
    @IBOutlet var consoleText: UITextView!
    
    let dataController = DataController().managedObjectContext
    let log = XCGLogger.defaultInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        seedProject()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func seedProject() {
        //2
        let entity =  NSEntityDescription.entityForName("Project",
                                                        inManagedObjectContext:dataController)
        
        let person = NSManagedObject(entity: entity!,
                                     insertIntoManagedObjectContext: dataController)
        
        //3
        person.setValue("test", forKey: "name")
        
        //4
        do {
            try dataController.save()
            //5
//            people.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func fetch(){
        let projectFetch = NSFetchRequest(entityName: "Project")
        
        do{
            let fetchedPerson = try dataController.executeFetchRequest(projectFetch) as! [Project]
            print(fetchedPerson.first!.name!)
        } catch {
            print("bad things happened")
        }

    }

    @IBAction func clickConfigureProjects(sender: AnyObject) {
        log.debug("getting new")
        
        ProjectService.getAll()
            .success { (value) in
                self.consoleText.text = value
                self.log.debug("will change to gallery view controller")
                self.performSegueWithIdentifier("segueGalleryViewController", sender: self)
                
            }
            .error { (error) in
                print("error = \(error)")
            }
    }

    @IBAction func clickGetAllObjects(sender: AnyObject) {
        log.debug("getting existing")
        
        let projects = ProjectController().getAllProjects()
        
        log.debug(projects.count)
        
        for project in projects {
            log.debug(project.name)
            self.consoleText.text = self.consoleText.text + "\n" + project.name!
        }
    }
}

