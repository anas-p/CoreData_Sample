//
//  ViewController.swift
//  coredata_test
//
//  Created by Anas P on 28/02/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var txtName: UITextField!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var tableView: UITableView!
    
    var employeeList:Array<Tbl_employee>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tbl_employee.shared.fetchEmployee(onComplete: { (response:[Tbl_employee]?) -> Void in
            if let empList = response, empList.count > 0{
                self.employeeList = empList
                self.tableView.reloadData()
            }
        })
    }

    
    //MARK: -ACTIONS
    @IBAction func btnSaveOnClick(_ sender: UIButton) {
        if let name = self.txtName.text, name != "" {
            Tbl_employee.shared.saveEmployee(name: name, OnSuccess: { (status:Bool) -> Void in
                if status {
                    self.txtName.text = ""
                    Tbl_employee.shared.fetchEmployee(onComplete: { (response:[Tbl_employee]?) -> Void in
                        if let empList = response, empList.count > 0{
                            self.employeeList = empList
                            self.tableView.reloadData()
                        }
                    })
                }
                else{
                    print("Name not saved!")
                }
            })
        }
    }
    
    //MARK: -UITableView Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let empList = self.employeeList{
            return empList.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        if let empList = self.employeeList{
            cell.textLabel?.text = empList[indexPath.row].emp_name!
        }
        return cell
    }
    
    //MARK: -UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let employee = self.employeeList?[indexPath.row]{
            if let teamList = employee.team{
                if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeamDetailsViewController") as? TeamDetailsViewController{
                    vc.flag = 1
                    vc.teamList = Array(teamList) as? [Tbl_team]
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    
}

