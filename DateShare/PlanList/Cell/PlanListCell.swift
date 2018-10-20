//
//  PlanListCell.swift
//  DateShare
//
//  Created by KokiHirokawa on 2018/10/20.
//  Copyright © 2018年 Imajin Kawabe. All rights reserved.
//

import UIKit

class PlanListCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView(_ plan: PlanEntity) {
        titleLabel.text = plan.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
