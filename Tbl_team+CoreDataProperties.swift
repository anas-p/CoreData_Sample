//
//  Tbl_team+CoreDataProperties.swift
//  coredata_test
//
//  Created by Anas P on 28/02/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import CoreData


extension Tbl_team {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tbl_team> {
        return NSFetchRequest<Tbl_team>(entityName: "Tbl_team");
    }

    @NSManaged public var team_name: String?
    @NSManaged public var employees: NSSet?

}

// MARK: Generated accessors for employees
extension Tbl_team {

    @objc(addEmployeesObject:)
    @NSManaged public func addToEmployees(_ value: Tbl_employee)

    @objc(removeEmployeesObject:)
    @NSManaged public func removeFromEmployees(_ value: Tbl_employee)

    @objc(addEmployees:)
    @NSManaged public func addToEmployees(_ values: NSSet)

    @objc(removeEmployees:)
    @NSManaged public func removeFromEmployees(_ values: NSSet)

}
