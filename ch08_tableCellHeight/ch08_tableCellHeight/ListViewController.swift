//
//  ListViewController.swift
//  ch08_tableCellHeight
//
//  Created by Kant on 2021/05/16.
//

import UIKit

class ListViewController: UITableViewController {
    
    var list = [String]() // 문자열 배열 변수를 담기 위한 객체 (테이블 뷰의 데이터를 저장하기 위함)
    
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "목록 입력", message: "추가될 글을 작성해주세요", preferredStyle: .alert)
        
        alert.addTextField { (tf) in
            tf.placeholder = "내용을 입력하세요"
        }
        
        let ok = UIAlertAction(title: "OK", style: .default) { (_) in
            if let title = alert.textFields?[0].text {
                self.list.append(title)
                self.tableView.reloadData()
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: false, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell 아이디를 가진 셀을 읽어와 옵셔널을 해제하되, 만약 그 값이 nil일 경우 UITableViewCell 인스턴스를 새로 생성한다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        
        cell.textLabel?.numberOfLines = 0
        
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let row = self.list[indexPath.row]
//
//        let height = CGFloat(60 + (row.count / 30) * 20)
//        return height
//    }
    
    override func viewDidLoad() {
        // 호핀 API 호출을 위한 URI 생성
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=1&count=10&genreId=&order=releasedateasc"
        
        let apiURI: URL! = URL(string: url)
        
        // REST API 호출
        let apiData = try! Data(contentsOf: apiURI)
        
        // 데이터 전송 결과를 로그로 출력
        let log = NSString(data: apiData, encoding: String.Encoding.utf8.rawValue) ?? ""
        NSLog("API Result = \(log)")
        
    }
}

