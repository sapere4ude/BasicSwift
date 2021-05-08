//
//  ViewController.swift
//  ch06_AlertController
//
//  Created by Kant on 2021/05/08.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 메세지 창을 처리하기 부적절한 위치 (아직 뷰가 화면에 구현되기 이전)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 메세지 창을 처리하기 적절한 위치 (뷰가 완전히 화면에 표현되고 난 다음에 호출되기 때문에 메세지 창을 띄우기 위한 present 메소드를 실행하는데 문제되는 것 X)
    }

    
    
    
    
    @IBAction func alert(_ sender: Any) {
        let alert = UIAlertController(title: "선택", message: "항목을 선택해주세요", preferredStyle: .alert)
        
        // 취소 버튼
        let cancel = UIAlertAction(title: "취소", style: .cancel) {(_) in
            self.result.text = "취소 버튼을 클릭했습니다"
        }
        
        // 확인 버튼
        let ok = UIAlertAction(title: "확인", style: .default) {(_) in
            self.result.text = "확인 버튼을 클릭했습니다"
        }
        
        // 실행 버튼
        let exec = UIAlertAction(title: "실행", style: .destructive) {(_) in
            self.result.text = "실행 버튼을 클릭했습니다"
        }
        
        // 중지 버튼
        let stop = UIAlertAction(title: "중지", style: .default) {(_) in
            self.result.text = "중지 버튼을 클릭했습니다"
        }
        
        // 버튼을 컨트롤러에 등록
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addAction(exec)
        alert.addAction(stop)
        
        // 메세지창 실행
        self.present(alert, animated: false)
    }
    
    
    @IBAction func login(_ sender: Any) {
        let title = "iTunes Store에 로그인"
        let message = "사용자의 Apple ID kant@gmail.com 의 암호를 입력하십시오"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            // 확인 버튼을 눌렀을 경우 처리할 내용
            if let tf = alert.textFields?.first {
                print("입력된 값은 \(tf.text!)입니다.")
            } else {
                print("입력된 값이 없습니다.")
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        // 텍스트 필드 추가
        alert.addTextField { (tf) in
            // 텍스트 필드의 속성 추가
            tf.placeholder = "암호" // 안내 메세지
            tf.isSecureTextEntry = true // 비밀번호 처리
        }
        
        self.present(alert, animated: false)
    }
    
    @IBAction func auth(_ sender: Any) {
        let msg = "로그인"
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) {
            (_) in
            // 확인 버튼을 클릭했을 때 처리할 내용
            let loginId = alert.textFields?[0].text
            let loginPw = alert.textFields?[1].text
            
            if loginId == "sqlpro" && loginPw == "1234" {
                self.result.text = "인증되었습니다"
            } else {
                self.result.text = "인증에 실패하였습니다"
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        //MARK:- 아랫줄부터 클로저의 다양한 표현 형식을 확인할 수 있음
        
        // 텍스트 필드 추가 - 아이디
        alert.addTextField(configurationHandler: {(tf) in
            // 텍스트필드의 속성설정
            tf.placeholder = "아이디" // 안내 메세지
            tf.isSecureTextEntry = false // 비밀번호 처리 안함
        })

        // 텍스트 필드 추가 - 비밀번호
        alert.addTextField(configurationHandler: { (tf) in
            // 텍스트필드의 속성설정
            tf.placeholder = "비밀번호" // 안내 메세지
            tf.isSecureTextEntry = true // 비밀번호 처리
        })
        
        self.present(alert, animated: false)
        
        alert.addTextField() {
            $0.placeholder = "비밀번호"
            $0.isSecureTextEntry = true
        }
    }
}

