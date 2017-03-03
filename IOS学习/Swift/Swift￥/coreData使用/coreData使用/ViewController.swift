//
//  ViewController.swift
//  coreData使用
//
//  Created by yh on 16/4/5.
//  Copyright © 2016年 yh. All rights reserved.

import UIKit
import CoreData
class ViewController: UIViewController ,NSFetchedResultsControllerDelegate{

    var student:[Student] = []
    var fc:NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buf = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let person = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: buf) as! Student
        person.name = "nihao"
        do{
            try buf.save()
        }catch{
            
        }
        
        
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let request = NSFetchRequest(entityName:"Student")
        request.sortDescriptors = [NSSortDescriptor(key:"name" , ascending:true)]
        let buf = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        fc = NSFetchedResultsController(fetchRequest: request,managedObjectContext: buf,sectionNameKeyPath:nil ,cacheName: nil)
        do{
            try fc.performFetch()
            student = fc.fetchedObjects as! [Student]
        }catch{
            
        }
        
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
            
        case .Insert:
            if let _newIndexPath = newIndexPath{
                _newIndexPath
            }
        case .Delete:
            if let _indexPath = indexPath{
                _indexPath
            }
        case .Update:
            if let _indexPath = indexPath{
                _indexPath
            }
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

