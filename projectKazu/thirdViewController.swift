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
    //var todoList:[String] = NSArray() as! [String]
    var todoList:[NSDictionary] = []
    
    //選択されたinputDateが格納される変数
    var selectedDate:String = String(describing: Date())
    
    //過去履歴表示変更設定の各項目
    @IBOutlet weak var fromDate: UITextField!
    @IBOutlet weak var toDate: UITextField!
    
    //datePickerを載せるView
    let baseView:UIView = UIView(frame: CGRect(x: 0, y: 720, width: 200, height: 250))
    //datePickerを生成(日付編集時）
    let myDatePicker:UIDatePicker = UIDatePicker(frame: CGRect(x: 10, y: 20, width: 300, height: 220))
    //datePickerを隠すためのボタン
    let closeBtnDatePicker:UIButton = UIButton(type: .system)
    
    //詳細画面とのセグエ連携のためのカウント用変数（初期値0)
    var detailCount = 0
    
    // 詳細画面から戻ってくる(unwind segue)
    @IBAction func back(Segue:UIStoryboardSegue){
    print("戻る")
    }
    
    // 履歴の削除機能（データを選んで複数まとめて削除が可能なようにする）
    
    
    
    
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
        closeBtnDatePicker.setTitle("閉じる", for: .normal)
        
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
        
        //ディクショナリー型に代入
        //AppDelegateへのアクセス準備
       let myApp = UIApplication.shared.delegate as! AppDelegate
       myApp.dic = NSDictionary()
        
        //TableViewで扱いやすい形を作成、.appendで追加
       //for(key,data) in myApp.dicTodoList{
         //   print(key)
         //  todoList.append(key as! NSString)
       // }
        
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
       // todoList = NSArray.self as! [String]

        //データを一件ずつ取得(result)
        for result: AnyObject in fetchResults{
            let inputDate: Date? = result.value(forKey: "inputDate") as? Date
            let dueDate: Date? = result.value(forKey: "dueDate") as? Date
            let myTitle: String? = result.value(forKey: "myTitle") as? String
            let score: Int?  = result.value(forKey: "score") as? Int
            let complete: Bool? = result.value(forKey: "complete") as? Bool
            let reChallenge: Bool? = result.value(forKey: "reChallenge") as? Bool
            let myContents: String? = result.value(forKey: "myContents") as? String
            let memo: String? = result.value(forKey: "memo") as? String
    
           //データを配列に追加する。どうやって？
            todoList.append(["inputDate":inputDate,"dueDate":dueDate,"myTitle":myTitle,"score":score,"complete":complete,"reChallenge":reChallenge,"myContents":myContents,"memo":memo])
            }
        } catch {
        }
        //TableViewの再描画、書く場所が大事
        myTableView.reloadData()
        
    }
    
    //TableViewの処理
    //行数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    //セルの表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        //セルを表示するためのコード"\()"
//        cell.textLabel?.text = "\(todoList[indexPath.row])"
        print(todoList[indexPath.row])
        
        var dic:NSDictionary = todoList[indexPath.row]
        
        let df = DateFormatter()
        df.dateFormat = "yy/MM/dd"
        
        //日付を文字列に変換
        cell.inputDateLabel.text = df.string(from: dic["inputDate"] as! Date)
        cell.dueDateLabel.text = df.string(from: dic["dueDate"] as! Date)
        cell.myTitleLabel.text = dic["myTitle"] as! String
        
        
        //cell.scoreLabel.text = "\(score)点"
        
        cell.reChallengeButton.setTitle("", for: .normal)
        
        var completeBtnTitle = "完了入力"
//          if (dic["complete"] as! String == "0"){
//             completeBtnTitle = "完了入力"
//          }
        
        cell.completeButton.setTitle(completeBtnTitle, for: .normal)
        
        return cell
    }
    
    //CompleteBtnを押したとき、CoreDateから該当のinputDateをキーとするデータを取り出して、complete = 1 に書き換える
    @IBAction func tapCompleteBtn(_ sender: UIButton) {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
       // let ToDo = NSEntityDescription.entity(forEntityName: "ToDo", in: viewContext)
        var dic:NSDictionary = todoList[]
        let df = DateFormatter()
        df.dateFormat = "yy/MM/dd"
           //データの更新
            let request: NSFetchRequest<ToDo> = ToDo.fetchRequest()
            var strSavedDate: String = df.string(from: dic["inputDate"] as! Date)
            var savedDate :Date = df.date(from: strSavedDate)!
            do{
              let namePredicte = NSPredicate(format: "created_at = %@", savedDate as CVarArg)
                request.predicate = namePredicte
                let fetchResults = try viewContext.fetch(request)
                //登録された日付を元に1件取得　新しい値を入れる
                for result: AnyObject in fetchResults {
                    let record = result as! NSManagedObject
                    
                }
                    
            }
    }
    
    
    //過去履歴表示設定変更
    //textFieldにカーソルが当たったとき（開始日、終了日）
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing 発動された")
            print(textField.tag)
        //日付のview（下で関数を書いておけば、１行で済む）
        myDatePicker.tag = textField.tag
        displayDatePickerView()
        
        return false
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
        
        //日付を文字列に変換（日付用のTextFieldが2つあるため、定数ではなくて変数）
        var strSelectedDate = df.string(from: sender.date)
        
        //TextFieldに値を表示
        switch sender.tag{
        case 1:
            fromDate.text = strSelectedDate
        case 2:
            toDate.text = strSelectedDate
        default: break

        }
        
    }

    //「詳細」ボタンが押されたときに発動
    @IBAction func touchDetailBtn(_ sender: UIButton) {
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("\((indexPath as IndexPath).row)行目を選択")
            //選択された行に表示された名前を格納
//            selectedDate = todoList[indexPath.row] as String
        
            //セグエを使って画面移動、identifierに入力済みのもの
            performSegue(withIdentifier: "showDetailView", sender: nil)
        }
    }
    
    //Segueで画面遷移する時発動
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //ダウンキャスティングで型変換
        let detailVC = segue.destination as! detailViewController
        
        //次の画面detailViewControllerに選択された日付と配列を渡す
        detailVC.scSelectedDate = selectedDate
        
        detailVC.todoList = todoList
        // デバッグエリアの情報をわかりやすく表示
        print("番号\(detailVC.scSelectedDate)を次の画面へ渡す")
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


