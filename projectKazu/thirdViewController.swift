//
//  thirdViewController.swift
//  projectKazu
//
//  Created by Apple on 2017/02/15.
//  Copyright © 2017年 Sasaki Kazuhiro. All rights reserved.
//

import UIKit
import CoreData

class thirdViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    
    // tableViewの定義
    @IBOutlet weak var myTableView: UITableView!
  
    //辞書配列の定義（文字列で良いか？）
    var todoList:[String] = NSArray() as! [String]
    
    //過去履歴表示変更設定の各項目
    @IBOutlet weak var fromDate: UITextField!
    @IBOutlet weak var toDate: UITextField!
    @IBOutlet weak var myScore: UITextField!
    
    //datePickerを載せるView
    let baseView:UIView = UIView(frame: CGRect(x: 0, y: 720, width: 200, height: 250))
    
    //datePicker(日付編集時）
    let myDatePicker:UIDatePicker = UIDatePicker(frame: CGRect(x: 10, y: 20, width: 300, height: 220))
    
    //datePickerを隠すためのボタン
    let closeBtnDatePicker:UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //日付が変わった時のイベントをdatePickerに設定
        myDatePicker.addTarget(self, action: #selector(showDateSelected(sender:)), for: .valueChanged)
        
        //baseViewにdatePickerを配置
        baseView.addSubview(myDatePicker)
        
        //baseViewにボタンを配置
        //位置、大きさを決定
        closeBtnDatePicker.frame = CGRect(x: self.view.frame.width - 60, y: 0, width: 50, height: 20)

        //タイトルの設定
        closeBtnDatePicker.setTitle("Close", for: .normal)
        
        //イベントの追加
        closeBtnDatePicker.addTarget(self, action: #selector(closeDatePickerView(sender:)), for: .touchUpInside)
        
        //Viewに追加
        baseView.addSubview(closeBtnDatePicker)
        
        //下にぴったり配置（下から出したいので）、横幅ピッタリの大きさにしておく
        baseView.frame.origin = CGPoint(x: 0, y: self.view.frame.size.height)
        
        //横幅
        baseView.frame.size = CGSize(width: self.view.frame.width, height: baseView.frame.height)
        
        //背景色をGrayにセット
        baseView.backgroundColor = UIColor.gray
        
        //画面に追加
        self.view.addSubview(baseView)
        
        //Coredataからのdataを読み込む処理（後で関数を定義）
        read()
        
    }
    
    //既に存在するデータの読み込み
    func read(){
        //AppDelegateを使う
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext

        //どのエンティティからdataを取得してくるか設定
        let query: NSFetchRequest<ToDo> = ToDo.fetchRequest()
    
    do{
        //データを一括取得
        let fetchResults = try viewContext.fetch(query)
    
        //いったん配列を空っぽにする（初期化する）
        todoList = NSArray.self as! [String]

        //データを一件ずつ取得(result)
        for result: AnyObject in fetchResults{
            let inputDate: Date? = result.value(forKey: "inputDate") as? Date
            let dueDate: Date? = result.value(forKey: "dueDate") as? Date
            let myTitle: String? = result.value(forKey: "myTitle") as? String
            let myContents: String? = result.value(forKey: "myContents") as? String
            let score: Int?  = result.value(forKey: "score") as? Int
            let complete: Bool? = result.value(forKey: "complete") as? Bool
            let reChallenge: Bool? = result.value(forKey: "reChallenge") as? Bool
            let cancel: Bool? = result.value(forKey: "cancel") as? Bool
            let revise: Bool? = result.value(forKey: "revise") as? Bool
    
            //データを配列に追加する。どうやって？
            todoList.append("","","","","","","","","")
            }
        } catch {
        }
        //TableViewの再描画、書く場所が大事
        myTableView.reloadData()
    }
    
//    // 前の画面で登録ボタンが押された時にデータを新規登録する
//    
//        //AppDelegateを使う用意をしておく
//        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//    
//        //エンティティを操作するためのオブジェクトを作成（persistentContainerはAppDelegate.swiftにあり）、DB接続に類似
//        let viewContext = appDelegate.persistentContainer.viewContext
//    
//        //ToDoエンティティオブジェクトの作成（SQL文とは異なる、オブジェクト指向）
//        let ToDo = NSEntityDescription.entity(forEntityName: "ToDo", in: viewContext)
//    
//        //ToDoエンティティにレコード（行）を挿入するためのオブジェクトを作成
//        let newRecord = NSManagedObject(entity: ToDo!, insertInto: viewContext)
//    
//        //値のセット（論理値の値はどう取るのか？）
//        newRecord.setValue(Date(), forKey: "inputDate")
//        newRecord.setValue(Date(), forKey: "dueDate")
//        newRecord.setValue(myTitle.text, forKey: "myTitle")
//        newRecord.setValue(myContents.text, forKey: "myContents")
//        newRecord.setValue(bool, forKey: "score")
//        newRecord.setValue(bool, forKey: "complete")
//        newRecord.setValue(bool, forKey: "reChallenge")
//        newRecord.setValue(bool, forKey: "cancel")
//        newRecord.setValue(bool, forKey: "revise")
//    
//    do {
//    //レコード（行）の即時保存
//      try viewContext.save()
//    } catch {
//    }

    //Coredataからのdataを読み込む処理
    read()

    //削除ボタンが押されたとき（completeが完了していないデータのみ表示され、そのデータのみ削除される）
    @IBAction func tapDelete(_ sender: UIButton) {
        //AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        //どのエンティティからdataを取得してくるか設定　参考:let query: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        let request: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        do {
            //削除するdataを一括取得
            let fetchResults = try viewContext.fetch(request)
            //削除するdataを一件ずつ取得
            for result: AnyObject in fetchResults{
                let record = result as! NSManagedObject
                //1行ずつ削除
                viewContext.delete(record)
            }
            //削除した状態を保存
            try viewContext.save()
        } catch {
        }
        //削除されたデータをtableViewに反映させる
        read()
    }

    //TableViewの処理
    //行数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    //セルの表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //セルを表示するためのコード"\()"
        cell.textLabel?.text = "\(todoList[indexPath.row])"
        
        return cell
    }

    //textFieldにカーソルが当たったとき（入力開始）
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing 発動された")
        print(textField.tag)
    
        //日付のview（下で関数を書いておけば、１行で済む）
        displayDatePickerView()
        
        switch textField.tag{
        case 3:
            //得点
            //datePickerではなく、４択のpickerが必要
            hideDatePickerView()
            return true
        default:
            return true
        }
        
        return true
    }

    //DatePickerのViewを隠す
    func hideDatePickerView(){
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            
            self.baseView.frame.origin = CGPoint(x: 0, y: self.view.frame.size.height)
            
        },completion:{finished in print("DatePickerを隠しました")})
    }
    
    //datePickerのViewを表示する
    func displayDatePickerView(){
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            
            self.baseView.frame.origin = CGPoint(x: 0, y: self.view.frame.size.height -  self.baseView.frame.height)
        },completion:{finished in print("DatePickerが現れました")})
    }
    
    //DatePickerが載ったViewを隠す（先にメソッドをこちらで書いておく）、「datePickerViewの表示」のところをコピーしてy軸を修正）
    func closeDatePickerView(sender:UIButton){
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            
            self.baseView.frame.origin = CGPoint(x: 0, y: self.view.frame.size.height)
            
        },completion:{finished in print("DatePickerを隠しました")})
    }
    
    //DatePickerで選択している日付を変えた時、日付用のtextFieldに値を表示
    func showDateSelected(sender:UIDatePicker){
        
        //フォーマットを設定
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        
        //日付を文字列に変換
        let strSelectedDate = df.string(from: sender.date)
        
        //TextFieldに値を表示
        fromDate.text = strSelectedDate
        toDate.text = strSelectedDate
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


