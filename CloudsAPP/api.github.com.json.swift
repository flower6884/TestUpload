import Foundation
import Alamofire//需要在這用到網路傳輸套件的功能
import Gloss

struct  ApiGithubComJsonGloss: Decodable {//使用 Gloss，並定義要解析的部份
    
    //必需使用 optional
    let id: Int?
    let name: String?
    let owner: ApiGithubComOwnerJsonGloss?
    
    init?(json: JSON) {//必需定義 init
        self.id = "id" <~~ json//告訴 Gloss 要解析什麼
        self.name = "name" <~~ json
        self.owner = "owner" <~~ json
    }
}

struct  ApiGithubComOwnerJsonGloss: Decodable {
    
    let login: String?
    let id: Int?
    let site_admin: Bool?
    
    init?(json: JSON) {
        self.login = "login" <~~ json
        self.id = "id" <~~ json
        self.site_admin = "site_admin" <~~ json
    }
}

extension ApiGithubComJsonGloss {
    
    //需要定義成 static 才能在物件還沒初始化時，就可以使用 fetch() 這個方法
    //定義 completion handlers 來傳送資料，定義要傳送一種型態的陣列，無返回值
    //宣告 @esacping 才能將資料傳出
    static func fetch(completion: @escaping ([ApiGithubComJsonGloss]) -> Void) {
        request("https://api.github.com/users/octocat/repos").responseJSON { response in
            
            //用 Gloss 直接解析 JSON 陣列，並回傳到 [ApiGithubComJsonGloss] 中放到 dataTransfer 準備回傳
            guard let dataTransfer = [ApiGithubComJsonGloss].from(jsonArray: response.result.value as! [JSON]) else {
                return
            }
            
            var helper = Helper.sharedInstance
            helper.apiGithubComJsons = dataTransfer
            
            completion(dataTransfer)//執行定義好的 completion handler 將資料傳出
        }
    }
}

