//
//  DetailViewController.swift
//  ch09_Network
//
//  Created by Kant on 2021/05/22.
//

import Foundation
import WebKit

class DetailViewController: UIViewController {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var wv: WKWebView!
    
    var mvo: MovieVO! // 목록 화면에서 전달하는 영화 정보를 받을 변수
    
    override func viewDidLoad() {
        // WKNavigationDelegate의 델리게이트 객체를 지정
        self.wv.navigationDelegate = self
        
        NSLog("link Url = \(self.mvo.detail!), title = \(self.mvo.title!)")
        
        let navibar = self.navigationItem
        navibar.title = self.mvo?.title
        
        
        if let url = self.mvo.detail {
            // URL Request 생성
            if let urlObj = URL(string: url) {
                let url = URL(string: (self.mvo.detail)!)
                let req = URLRequest(url: url!)
                self.wv.load(req)
            } else {
                // URL 형식이 잘못되었을 경우 예외처리
                let alert = UIAlertController(title: "오류", message: "잘못된 URL 입니다.", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
                    _ = self.navigationController?.popViewController(animated: true)
                }
                
                alert.addAction(cancelAction)
                self.present(alert, animated: false, completion: nil)
            }
        } else {
            // URL 값이 전달되지 않았을 경우 예외처리
            let alert = UIAlertController(title: "오류", message: "필수 파라미터가 누락되었습니다.", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
                _ = self.navigationController?.popViewController(animated: true)
                
            }
            alert.addAction(cancelAction)
            self.present(alert, animated: false, completion: nil)
        }
    }
}

//MARK:- WKNavigationDelegate 프로토콜 구현
extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.spinner.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.spinner.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating()
        
//        let alert = UIAlertController(title: "오류", message: "상세페이지를 읽어오지 못했습니다", preferredStyle: .alert)
//
//        let cancelAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
//            _ = self.navigationController?.popViewController(animated: true)
//        }
//
//        alert.addAction(cancelAction)
//        self.present(alert, animated: false, completion: nil)
        
        self.alert("상세 페이지를 읽어오지 못했습니다.")
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating()
        self.alert("상세 페이지를 읽어오지 못했습니다.") {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
}

extension UIViewController {
    func alert(_ message: String, onClick: (()-> Void)? = nil) {
        let controller = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .cancel) { (_) in
            onClick?()
        })
        DispatchQueue.main.async {
            self.present(controller, animated: false)
        }
    }
}

