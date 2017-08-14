//
//  ViewController.swift
//  CloudsAPP
//
//  Created by mike on 2017/7/24.
//  Copyright © 2017年 mike. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    var apiGithubComJsonsGloss: [ApiGithubComJsonGloss] = []//用來放 completion 傳來的資料
    
    var helper = Helper.sharedInstance
    
    //UI 連結
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    //UI 連結
    @IBAction func okButton(_ sender: UIButton) {
    }
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func cancel(_ sender: UIBarButtonItem) {//2個 segue 跳回上一頁的方式不同
        
        let isPresentingInAddItem = presentingViewController is UINavigationController
        
        if isPresentingInAddItem {
            dismiss(animated: true, completion: nil)//原來的 navitation controller 方式，modal 頁面的方式
        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)//用 show 產生的頁面的方式
        } else {
            fatalError("沒有屬於任何 navigation controller")
        }
    }
    
    var studentData: StudentData!//用來在放要傳送的資料
    
    //使用 segue 跳回之前頁面時，可以準備一些要傳的資料
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)//有的類別會需要用到
        
        if saveButton === sender as? UIBarButtonItem {
            let name = nameLabel.text ?? "No data"
            let gender = genderLabel.text ?? "No data"
            let birth = birthLabel.text ?? "No data"
            let email = emailLabel.text ?? "No data"
            let phone = phoneLabel.text ?? "No data"
            let address = addressLabel.text ?? "No data"
            
            studentData = StudentData(name: name, gender: gender, birth: birth)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let studentDataTmp = studentData else {
            //            fatalError("沒有傳進來的資料")//新增資料時會掛，改用 return
            return
        }
        
        nameLabel.text = studentDataTmp.name//將收到的資料設定到 UI
        genderLabel.text = studentDataTmp.gender
        birthLabel.text = studentDataTmp.birth

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

