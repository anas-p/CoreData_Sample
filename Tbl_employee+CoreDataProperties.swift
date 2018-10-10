//
//  Tbl_employee+CoreDataProperties.swift
//  coredata_test
//
//  Created by Anas P on 28/02/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import CoreData


extension Tbl_employee {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tbl_employee> {
        return NSFetchRequest<Tbl_employee>(entityName: "Tbl_employee");
    }

    @NSManaged public var emp_name: String?
    @NSManaged public var team: NSSet?    
}

// MARK: Generated accessors for team
extension Tbl_employee {

    @objc(addTeamObject:)
    @NSManaged public func addToTeam(_ value: Tbl_team)

    @objc(removeTeamObject:)
    @NSManaged public func removeFromTeam(_ value: Tbl_team)

    @objc(addTeam:)
    @NSManaged public func addToTeam(_ values: NSSet)

    @objc(removeTeam:)
    @NSManaged public func removeFromTeam(_ values: NSSet)

}
