//
//  ViewController.swift
//  ch05_SubmitValue
//
//  Created by Kant on 2021/05/07.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var resultEmail: UILabel!
    @IBOutlet var resultUpdate: UILabel!
    @IBOutlet var resultInterval: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:- AppDelegate 객체의 인스턴스 가져오기
        
//        let ad = UIApplication.shared.delegate as? AppDelegate
//
//        if let email = ad?.paramEmail {
//            resultEmail.text = email
//        }
//
//        if let update = ad?.paramUpdate {
//            resultUpdate.text = update == true ? "자동갱신" : "자동갱신안함"
//        }
//
//        if let interval = ad?.paramInterval {   // 갱신 주기 표시
//            resultInterval.text = "\(Int(interval))분마다"
//        }
        
        //MARK:- UserDefaluts 객체의 인스턴스 가져오기
  
        let ud = UserDefaults.standard
        
        if let email = ud.string(forKey: "email") {
            resultEmail.text = email
        }
        
        let update = ud.bool(forKey: "isUpdate")
        resultUpdate.text = (update == true ? "자동갱신" : "자동갱신안함")
        
        let interval = ud.double(forKey: "interval")
        resultInterval.text = "\(Int(interval))분마다"
        
    }


}

