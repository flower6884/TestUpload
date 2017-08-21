//
//  StudentData.swift
//  CloudsAPP
//
//  Created by mike on 2017/8/7.
//  Copyright © 2017年 mike. All rights reserved.
//

import UIKit

struct StudentData {//存放學生資料
    
    var name: String
    var gender: String
    var birth: String
    
    var photo: UIImage?
    var stars: Int
    
    init?(name: String, gender: String, birth: String, photo: UIImage?, stars: Int)
    {
        if name.isEmpty
        {
            return nil
        }
        self.name = name
        self.gender = gender
        self.birth = birth
        self.photo = photo
        self.stars = stars
    }
    
    
}
