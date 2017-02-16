//
//  secondViewController.swift
//  projectKazu
//
//  Created by Apple on 2017/02/15.
//  Copyright © 2017年 Sasaki Kazuhiro. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {

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
        let myComponetns = myCalendar.components(
            [
                NSCalendar.Unit.year,
                NSCalendar.Unit.month,
                NSCalendar.Unit.day,
                NSCalendar.Unit.weekday
            ],from: myDate)
        
        let weekdayStrings: Array = ["nil","日","月","火","水","木","金","土"]
        
        print("year: \(myComponetns.year)")
        print("month: \(myComponetns.month)")
        print("day: \(myComponetns.day)")
        print("weekday: \(weekdayStrings[myComponetns.weekday!])")
        
        //現在時間表示用のラベルを生成.
        //今日の日時・曜日をラベルに表示
        var myStr1: String = "今日は" + "\(myComponetns.year!)年" + "\(myComponetns.month!)月" + "\(myComponetns.day!)日[" + "\(weekdayStrings[myComponetns.weekday!])]" + "です！"
        
        myLabel1.text = myStr1
        
        //明日の日時・曜日をラベルに表示
        var myStr2: String = "明日は" + "\(myComponetns.year!)年" + "\(myComponetns.month!)月" + "\(myComponetns.day!)日[" + "\(weekdayStrings[myComponetns.weekday!])]" + "です！"
        myLabel2.text = myStr2
        
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
