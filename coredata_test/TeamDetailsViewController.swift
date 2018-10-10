//
//  TeamDetailsViewController.swift
//  coredata_test
//
//  Created by Anas P on 28/02/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit

class TeamDetailsViewController: UIViewController, UITableViewDataSource {

    var employeeList:Array<Tbl_employee>?
    var teamList: Array<Tbl_team>?
    
    var flag:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    //MARK: -UITableView Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if flag == 0{
            if let empList = self.employeeList{
                return empList.count
            }
            else{
                return 0
            }
        }
        else
        {
            if let teamsList = self.teamList{
                return teamsList.count
            }
            else{
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        if flag == 0{
            if let empList = self.employeeList{
                cell.textLabel?.text = empList[indexPath.row].emp_name!
            }
        }
        else
        {
            if let teamsList = self.teamList{
                cell.textLabel?.text = teamsList[indexPath.row].team_name!
            }
        }
        
        return cell
    }
    

}
