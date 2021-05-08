//
//  FormViewController.swift
//  ch05_SubmitValue
//
//  Created by Kant on 2021/05/08.
//

import UIKit

class FormViewController: UIViewController {
    
    @IBAction func onSubmit(_ sender: Any) {
        //MARK:- AppDelegate 객체의 인스턴스 가져오기
//            let ad = UIApplication.shared.delegate as? AppDelegate
        
        // 값 저장
//            ad?.paramEmail = self.email.text
//            ad?.paramUpdate = self.isUpdate.isOn
//            ad?.paramInterval = self.interval.value
        
        
        //MARK:- UserDefaults 사용
        let ud = UserDefaults.standard
        
        ud.set(self.email.text, forKey: "email")
        ud.set(self.isUpadte.isOn, forKey: "isUpdate")
        ud.set(self.interval.value, forKey: "interval")
        
        
        // 이전 화면으로 복귀
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}
