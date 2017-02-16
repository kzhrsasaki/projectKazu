//
//  secondViewController.swift
//  projectKazu
//
//  Created by Apple on 2017/02/15.
//  Copyright © 2017年 Sasaki Kazuhiro. All rights reserved.
//

import UIKit

class secondViewController: UIViewController, UITextFieldDelegate,UITextViewDelegate {

    @IBOutlet weak var formView: UIView!

    @IBOutlet weak var myLabel1: UILabel!
    @IBOutlet weak var myLabel2: UILabel!
    @IBOutlet weak var myTitle: UITextField!
    @IBOutlet weak var myContents: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //現在時刻を取得
        let myDate: Date = Date()
        
        //カレンダーを取得
        let myCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        //取得するコンポーネントを決める
        let myComponetns1 = myCalendar.components(
            [NSCalendar.Unit.year,NSCalendar.Unit.month,NSCalendar.Unit.day,NSCalendar.Unit.weekday],
            from: myDate)
        
        let weekdayStrings: Array = ["nil","日","月","火","水","木","金","土"]
        
        print("year: \(myComponetns1.year)")
        print("month: \(myComponetns1.month)")
        print("day: \(myComponetns1.day)")
        print("weekday: \(weekdayStrings[myComponetns1.weekday!])")
        
        //現在時間表示用のラベルを生成.
        //今日の日時・曜日をラベルに表示
        var myStr1: String = "今日は、" + "\(myComponetns1.year!)年" + "\(myComponetns1.month!)月" + "\(myComponetns1.day!)日[" + "\(weekdayStrings[myComponetns1.weekday!])]" + "です！"
        
        myLabel1.text = myStr1
        
        //明日の日時・曜日をラベルに表示
        //24時間後の時刻を取得
        let myDate2 = NSDate(timeInterval: 60 * 60 * 24 * 1, since: myDate)
        
        //取得するコンポーネントを決める.
        let myComponetns2 = myCalendar.components(
            [NSCalendar.Unit.year,NSCalendar.Unit.month,NSCalendar.Unit.day,NSCalendar.Unit.weekday],
            from: myDate2 as Date)
        
        let weekdayStrings2: Array = ["nil","日","月","火","水","木","金","土"]

        var myStr2: String = "明日は、" + "\(myComponetns2.year!)年" + "\(myComponetns2.month!)月" + "\(myComponetns2.day!)日[" + "\(weekdayStrings2[myComponetns2.weekday!])]" + "です！"
        myLabel2.text = myStr2
        
    }
        //タイトル（textField)が編集された際に呼ばれる
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string1: String) -> Bool {
        
        // 文字数最大を決める.
        let maxLength1: Int = 11
        
        // 入力済みの文字と入力された文字を合わせて取得.
        let str1 = textField.text! + string1
        
        // 文字数がmaxLength以下ならtrueを返し、超えていればアラートを表示させる
        if str1.characters.count < maxLength1 {
            return true
        } else {
            print("10文字を超えています")
            return false
            //アラートを作る
            let alertController = UIAlertController(title: "文字数エラー", message: "10文字を超えています", preferredStyle: .alert)
            
            //OKボタンを追加 handler...ボタンが押された時発動する処理を記述
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in print("OK")}))
            
            //アラートを表示する
            present(alertController,animated: true, completion: nil)
        }
            
        //内容（textView）が編集された際に呼ばれる
        func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {

            
//        func textView(textView: UITextView, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
        // 文字数最大を決める.
        let maxLength2: Int = 11
        // textViewの文字数と最大文字数との比較
        if text.characters.count < maxLength2 {
                
                return true
            } else {
                print("100文字を超えています")
                return false
                //アラートを作る
                let alertController = UIAlertController(title: "文字数エラー", message: "100文字を超えています", preferredStyle: .alert)
                
                //OKボタンを追加 handler...ボタンが押された時発動する処理を記述
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in print("OK")}))
                
                //アラートを表示する
                present(alertController,animated: true, completion: nil)
            }
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
