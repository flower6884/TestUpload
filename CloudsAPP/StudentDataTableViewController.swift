//
//  StudentDataTableViewController.swift
//  CloudsAPP
//
//  Created by mike on 2017/8/7.
//  Copyright © 2017年 mike. All rights reserved.
//

import UIKit

class StudentDataTableViewController: UITableViewController {

    var studentDatas = [StudentData]()//存放從外部取得的學生資料
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //模擬從網路取得資料
        loadSampleStudentDatas()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //模擬從網路取得資料
    func loadSampleStudentDatas() {
        let studentData1 = StudentData(name: "mike1", gender: "male", birth: "1999-1-1")
        let studentData2 = StudentData(name: "mike2", gender: "male", birth: "1999-1-2")
        let studentData3 = StudentData(name: "mike3", gender: "male", birth: "1999-1-3")
        let studentData4 = StudentData(name: "mike4", gender: "male", birth: "1999-1-4")
        let studentData5 = StudentData(name: "mike5", gender: "male", birth: "1999-1-5")
        
        studentDatas += [studentData1, studentData2, studentData3, studentData4, studentData5]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1//需要設定才能顯示 table cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return studentDatas.count//根據資料筆數調整 table cell 數量
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "StudentDataTableViewCell"//要跟 Xcode 中 table cell 中設定的一致
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! StudentDataTableViewCell//解 cell 解作我們自己訂義的 cell 類別

        // Configure the cell...
        //根據目前 index 將資料放到 UI 中
        let studentData = studentDatas[indexPath.row]
        
        cell.nameLabel.text = studentData.name
        cell.genderLabel.text = studentData.gender
        cell.birthLabel.text = studentData.birth

        return cell
    }
    
    //以下方法讓 UI 介面可以找到要跳回去的地方
    @IBAction func unwindToStudentDataList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? ViewController,//解析 segue 的來源及資料
            let studentData = sourceViewController.studentData {
            let indexPath = IndexPath(row: studentDatas.count, section: 0)
            studentDatas.append(studentData)
            tableView.insertRows(at: [indexPath], with: .bottom)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
