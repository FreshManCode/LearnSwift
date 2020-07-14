//
//  SWDifferentCell.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/6/18.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit
import SnapKit

let cellID = "SWDifferentCellID"
class SWDifferentCell: UITableViewCell {
    
    class  func cellWithTableView(text:String,tableView:UITableView) -> UITableViewCell {
        tableView.register(self, forCellReuseIdentifier: cellID)
        let cell : SWDifferentCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! SWDifferentCell
        cell.textLab.text = text;
        return cell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.contentView.addSubview(self.textLab);
        self.p_addConstraints();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func p_addConstraints() -> Void {
        self.textLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }
    }
    
    lazy var textLab:UILabel = {
        let lablel = UILabel.init(frame: CGRect.init(x: 10, y: 10, width: 200, height: 20));
        lablel.textColor = UIColor.lightGray;
        lablel.font = UIFont.systemFont(ofSize: 15);
        return lablel
    }()
    
}
