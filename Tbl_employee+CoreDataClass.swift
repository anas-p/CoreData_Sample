//
//  Tbl_employee+CoreDataClass.swift
//  coredata_test
//
//  Created by Anas P on 28/02/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Tbl_employee)
public class Tbl_employee: NSManagedObject {

    static let shared = Tbl_employee()
    
    func getContext() -> NSManagedObjectContext
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveEmployee(name: String, OnSuccess:(Bool) -> Void)
    {
        let context = self.getContext()
        let employeeEntity = NSEntityDescription.entity(forEntityName: "Tbl_employee", in: context)
        let newEmployee = Tbl_employee(entity: employeeEntity!, insertInto: context)
        newEmployee.emp_name = name
        do
        {
            try context.save()
            print("EMPLOYEE SAVED")
            OnSuccess(true)
        }
        catch
        {
            OnSuccess(false)
        }
    }
    
    
    func fetchEmployee(onComplete:([Tbl_employee]?) -> Void)
    {
        let context = self.getContext()
        context.shouldDeleteInaccessibleFaults = false

        let request = NSFetchRequest<NSFetchRequestResult> (entityName:  "Tbl_employee")
        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(request) as! [Tbl_employee]
            if results.count > 0
            {
                onComplete(results)
            }
            else
            {
                onComplete(nil)
            }
        }
        catch
        {
            //PROCESS ERROR
        }
    }
}
