import Foundation
import Alamofire//需要在這用到網路傳輸套件的功能
import Gloss

struct  ApiStudentServer: Decodable {//使用 Gloss，並定義要解析的部份
    
    //必需使用 optional
    let id: String?
    let name: String?
    let gender: String?
    let birth: String?
    let email: String?
    let phone: String?
    let address: String?
    
    init?(json: JSON) {//必需定義 init
        self.id = "cID" <~~ json//告訴 Gloss 要解析什麼
        self.name = "cName" <~~ json
        self.gender = "cSex" <~~ json
        self.birth = "cBirthday" <~~ json
        self.email = "cEmail" <~~ json
        self.phone = "cPhone" <~~ json
        self.address = "cAddr" <~~ json
    }
}



extension ApiStudentServer {
    
    //需要定義成 static 才能在物件還沒初始化時，就可以使用 fetch() 這個方法
    //定義 completion handlers 來傳送資料，定義要傳送一種型態的陣列，無返回值
    //宣告 @esacping 才能將資料傳出
    static func fetch(completion: @escaping ([ApiStudentServer]) -> Void) {
        request("http://192.168.62.25:6080/api/read_data.php").responseJSON { response in
            
            //用 Gloss 直接解析 JSON 陣列，並回傳到 [ApiGithubComJsonGloss] 中放到 dataTransfer 準備回傳
            guard let dataTransfer = [ApiStudentServer].from(jsonArray: response.result.value as! [JSON])
                else {
                        return
                     }
            
//            var helper = Helper.sharedInstance
//            helper.apiStudentServer = dataTransfer
            
            completion(dataTransfer)//執行定義好的 completion handler 將資料傳出
        }
    }
}

