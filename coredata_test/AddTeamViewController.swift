//
//  AddTeamViewController.swift
//  coredata_test
//
//  Created by Anas P on 28/02/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit


class AddTeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var txtTeam: UITextField!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var team_tableView: UITableView!
    
    var employeeList:Array<Tbl_employee>?
    var selectedEmpList:Array<Tbl_employee>? = Array<Tbl_employee>()
    
    var teamList:Array<Tbl_team>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tbl_employee.shared.fetchEmployee(onComplete: { (response:[Tbl_employee]?) -> Void in
            if let empList = response, empList.count > 0{
                self.employeeList = empList
                self.tableView.reloadData()
            }
        })
        
        Tbl_team.shared.fetchTeam { (response:[Tbl_team]?) -> Void in
            if let teams = response, teams.count > 0{
                self.teamList = teams
                self.team_tableView.reloadData()
            }
        }
    }

    
    @IBAction func btnSaveOnClick(_ sender: UIButton) {
        if let teamName = self.txtTeam.text, teamName != "", (self.selectedEmpList!.count) > 0 {
            Tbl_team.shared.saveTeam(teamName: teamName, employeeList: self.selectedEmpList!, OnSuccess: { (status:Bool) -> Void in
                self.txtTeam.text = ""
                Tbl_team.shared.fetchTeam { (response:[Tbl_team]?) -> Void in
                    if let teams = response, teams.count > 0{
                        self.teamList = teams
                        self.team_tableView.reloadData()
                        self.selectedEmpList?.removeAll()
                        self.tableView.reloadData()
                    }
                }
            })
        }
    }
    
    //MARK: -UITableView Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0{
            if let empList = self.employeeList{
                return empList.count
            }
            else{
                return 0
            }
        }
        else
        {
            if let teams = self.teamList{
                return teams.count
            }
            else{
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        if tableView.tag == 0{
            if let empList = self.employeeList{
                cell.textLabel?.text = empList[indexPath.row].emp_name!
            }
            cell.accessoryType = .none
        }
        else{
            if let teams = self.teamList{
                cell.textLabel?.text = teams[indexPath.row].team_name!
            }
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    //MARK: -UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 0{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            self.selectedEmpList?.append(self.employeeList![indexPath.row])
        }
        else{
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeamDetailsViewController") as? TeamDetailsViewController {
                if let teamList = self.teamList, let empList = teamList[indexPath.row].employees{
                    vc.flag = 0
                    vc.employeeList = Array(empList) as? Array<Tbl_employee>
                    vc.title = teamList[indexPath.row].team_name!
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.tag == 0{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            if let selectedEmp = self.employeeList?[indexPath.row]{
                self.selectedEmpList = self.selectedEmpList?.filter { $0.emp_name != selectedEmp.emp_name }
            }
        }
    }
    
    
}
