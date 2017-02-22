//
//  detailViewController.swift
//  projectKazu
//
//  Created by Apple on 2017/02/22.
//  Copyright © 2017年 Sasaki Kazuhiro. All rights reserved.
//

import UIKit
import CoreData

class detailViewController: UIViewController {

    @IBOutlet weak var myContents: UITextView!    
    @IBOutlet weak var myMemo: UITextView!
    
    //配列を前の画面から引き継ぐ
    var todoList:[NSDictionary] = []
    
    //リストから選ばれた名前
    var scSelectedDate = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        //データを渡せているかどうかの確認
        print(scSelectedDate)
        
        // AppDelegeteにアクセスするための準備
        let myApp = UIApplication.shared.delegate as! AppDelegate
        
        for(key,data) in myApp.dicTodoList{
            var dicForData:NSDictionary = data as! NSDictionary
            
            if((key as! String) as String == scSelectedDate){
                navigationItem.title = scSelectedDate
                myContents.text = dicForData["myContents"] as! String
                }
        }
    }

    // myMemo（ふり返り）をcompleteがtrue以降にのみ入力可にする
    
    // myMemo(ふり返り）を100文字以内の入力とする
    
    // 保存ボタンを押したらthirdViewControllerに戻り、かつ、coreDateにmyMemoのデータを新規登録する
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
