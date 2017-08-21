//
//  ViewController.swift
//  CloudsAPP
//
//  Created by mike on 2017/7/24.
//  Copyright © 2017年 mike. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    var apiGithubComJsonsGloss: [ApiGithubComJsonGloss] = []//用來放 completion 傳來的資料
    
    var helper = Helper.sharedInstance
    
    @IBOutlet weak var bigHeadPhotoImageView: UIImageView!
    @IBOutlet weak var nameTextFileld: UITextField!
    @IBOutlet weak var genderTextFileld: UITextField!
    @IBOutlet weak var birthTextFileld: UITextField!
    @IBOutlet weak var phoneTextFileld: UITextField!
    @IBOutlet weak var emailTextFileld: UITextField!
    @IBOutlet weak var addressTextFileld: UITextField!
    
    
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
            let name = nameTextFileld.text ?? "No data"
            let gender = genderTextFileld.text ?? "No data"
            let birth = birthTextFileld.text ?? "No data"
            let email = emailTextFileld.text ?? "No data"
            let phone = phoneTextFileld.text ?? "No data"
            let address = addressTextFileld.text ?? "No data"
            
            studentData = StudentData(name: name, gender: gender, birth: birth, photo: nil, stars: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let studentDataTmp = studentData else {
            //            fatalError("沒有傳進來的資料")//新增資料時會掛，改用 return
            return
        }
        
        nameTextFileld.delegate = self
        genderTextFileld.delegate = self
        birthTextFileld.delegate = self
        emailTextFileld.delegate = self
        phoneTextFileld.delegate = self
        addressTextFileld.delegate = self
        
        //點別處可以收起鍵盤
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //方法一
        view.endEditing(true)
        //方法二
//        nameTextFileld.resignFirstResponder()
//        genderTextFileld.resignFirstResponder()
//        birthTextFileld.resignFirstResponder()
//        emailTextFileld.resignFirstResponder()
//        phoneTextFileld.resignFirstResponder()
//        addressTextFileld.resignFirstResponder()
        
        return true
    }
    
    
    @IBAction func selectPhoto(_ sender: UITapGestureRecognizer)
    {
        let selectPhotoController = UIImagePickerController()
        selectPhotoController.sourceType = .photoLibrary
        selectPhotoController.delegate = self
        
        present(selectPhotoController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        guard let selectedPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage else
        {
            fatalError("解不出照片 - \(info)")
        }
        
        bigHeadPhotoImageView.image = selectedPhoto
        dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

