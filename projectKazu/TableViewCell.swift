//
//  TableViewCell.swift
//  projectKazu
//
//  Created by Apple on 2017/02/21.
//  Copyright © 2017年 Sasaki Kazuhiro. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //セル内の項目を定義
    @IBOutlet weak var inputDateLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var myTitleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var reChallengeButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var detailButton: UIButton!
    
    // inputDateは　yyyy/MM/dd mm:ssまで（配列のkeyデータとするため）
    
    // dueDateは　MM/ddまで
    
    // "\(score)点"
    
    // reChallenge は　score == 0 && complete == true の場合のみ、アクティブ
    
    // complete は　ユーザーが自分で登録するか、または、現在の日付 > dueDate の場合に　true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
