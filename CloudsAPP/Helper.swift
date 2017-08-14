//
//  Helper.swift
//  CloudsAPP
//
//  Created by Paul Hua on 2017/8/14.
//  Copyright © 2017年 mike. All rights reserved.
//

import Foundation


class Helper   //singleton pattern 的定義
{
    static let sharedInstance = Helper()  
    
    var apiGithubComJsons: [ApiGithubComJsonGloss]?
}
