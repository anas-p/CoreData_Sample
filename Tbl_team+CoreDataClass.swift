//
//  Tbl_team+CoreDataClass.swift
//  coredata_test
//
//  Created by Anas P on 28/02/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Tbl_team)
public class Tbl_team: NSManagedObject {

    static let shared = Tbl_team()
    
    func getContext() -> NSManagedObjectContext
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveTeam(teamName: String, employeeList:Array<Tbl_employee>, OnSuccess:(Bool) -> Void)
    {
        let context = self.getContext()
        let teamEntity = NSEntityDescription.entity(forEntityName: "Tbl_team", in: context)
        let newTeam = Tbl_team(entity: teamEntity!, insertInto: context)
        newTeam.team_name = teamName
        newTeam.employees = NSSet(array: employeeList)
        do
        {
            try context.save()
            print("TEAM SAVED")
            OnSuccess(true)
        }
        catch{
            OnSuccess(false)
        }
    }
    
    func fetchTeam(onComplete:([Tbl_team]?) -> Void)
    {
        let context = self.getContext()
        let request = NSFetchRequest<NSFetchRequestResult> (entityName:  "Tbl_team")
        request.returnsObjectsAsFaults = false
        do
        {
            let results = try context.fetch(request) as! [Tbl_team]
            
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
