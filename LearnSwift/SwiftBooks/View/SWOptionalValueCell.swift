//
//  SWOptionalValueCell.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/9/23.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWOptionalValueCell: UITableViewCell {

    @IBOutlet weak var nameLab: UILabel!
    
    
    @IBOutlet weak var sexLab: UILabel!
    
    
    @IBOutlet weak var contentLab: UILabel!
    
    
    func set(name:String,sex:String,content:String)  {
        nameLab.text = name
        sexLab.text  = sex
        contentLab.text = content
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}
