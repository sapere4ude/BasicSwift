//
//  ListViewController.swift
//  ch08_tableCellHeight
//
//  Created by Kant on 2021/05/16.
//

import UIKit

class ListViewController: UITableViewController {
    
//    var list = [String]() // 문자열 배열 변수를 담기 위한 객체 (테이블 뷰의 데이터를 저장하기 위함)
    
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        
        return datalist
    }()
    
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
        
        let apiURI: URL! = URL(string: url)     // URL -> Foundation framework 에 정의된 객체
        
        // REST API 호출
        let apiData = try! Data(contentsOf: apiURI)
        
        // 데이터 전송 결과를 로그로 출력, NSString(data: <문자열로 변환할 Data 타입 객체>, encoding: <인코딩형식>)
        let log = NSString(data: apiData, encoding: String.Encoding.utf8.rawValue) ?? ""    // Foundation 에서 지원하는 NSString 타입의 문자열로 반환
        NSLog("API Result = \(log)")
        
        
        do {
            // JSON 객체를 파싱하여 NSDictionary 객체로 받음
            let apiDictionary = try JSONSerialization.jsonObject(with: apiData, options: []) as! NSDictionary
            
            // 데이터 구조에 따라 차례대로 캐스팅하며 읽어온다.
            let hoppin = apiDictionary["hoppin"] as! NSDictionary   // 키-값으로 구성된 데이터이므로 NSDictionary 타입으로 바꿔준다.
            let movies = apiDictionary["movies"] as! NSDictionary
            let movie = apiDictionary["movie"] as! NSArray  // 데이터 형식이 리스트 형태이므로 NSArray 로 타입을 바꿔준다.
            
            for row in movie {
                // 순회 상수를 NSDictionary 타입으로 캐스팅
                let r = row as! NSDictionary
                
                // 테이블 뷰 리스트를 구성할 데이터 형식
                let mvo = MovieVO()
                
                mvo.title = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail = r["thumbnailImage"] as? String
                mvo.detail = r["linkUrl"] as? String
                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
                
                self.list.append(mvo)
            }
        } catch {
            
        }
    }
}

