//
//  PlanListCell.swift
//  DateShare
//
//  Created by KokiHirokawa on 2018/10/20.
//  Copyright © 2018年 Imajin Kawabe. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PlanListCell: UITableViewCell {

    @IBOutlet weak var planImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView(_ plan: PlanEntity) {
        guard let imageUrl = URL(string: plan.imageUrlString) else {
            return
        }
        planImageView.af_setImage(withURL: imageUrl)
        titleLabel.text = plan.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
