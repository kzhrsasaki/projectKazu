//
//  secondViewController.swift
//  projectKazu
//
//  Created by Apple on 2017/02/15.
//  Copyright © 2017年 Sasaki Kazuhiro. All rights reserved.
//

import UIKit

class secondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var formView: UIView!

    @IBOutlet weak var myLabel1: UILabel!
    @IBOutlet weak var myLabel2: UILabel!
    @IBOutlet weak var myTitle: UITextField!
    @IBOutlet weak var myContents: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //現在時刻を取得.
        let myDate: Date = Date()
        
        //カレンダーを取得.
        let myCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        //取得するコンポーネントを決める.
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 文字数最大を決める.
        let maxLength: Int = 6
        
        // 入力済みの文字と入力された文字を合わせて取得.
        let str = textField.text! + string
        
        // 文字数がmaxLength以下ならtrueを返す.
        if str.characters.count < maxLength {
            return true
        }
        print("6文字を超えています")
        return false
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
