//
//  PlanListViewController.swift
//  DateShare
//
//  Created by KokiHirokawa on 2018/10/20.
//  Copyright © 2018年 Imajin Kawabe. All rights reserved.
//

import UIKit

class PlanListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var plans: [PlanEntity] = [
        PlanEntity(id: 1, title: "京都ぶらぶらデート", imageUrlString: "https://s3-ap-northeast-1.amazonaws.com/sfcgs/%E3%81%B5%E3%82%8D%E3%82%93%E5%A4%AA.png"),
        PlanEntity(id: 2, title: "京都ぶらぶらデート", imageUrlString: "https://s3-ap-northeast-1.amazonaws.com/sfcgs/%E3%81%B5%E3%82%8D%E3%82%93%E5%A4%AA.png"),
        PlanEntity(id: 3, title: "京都ぶらぶらデート", imageUrlString: "https://s3-ap-northeast-1.amazonaws.com/sfcgs/%E3%81%B5%E3%82%8D%E3%82%93%E5%A4%AA.png"),
        PlanEntity(id: 4, title: "京都ぶらぶらデート", imageUrlString: "https://s3-ap-northeast-1.amazonaws.com/sfcgs/%E3%81%B5%E3%82%8D%E3%82%93%E5%A4%AA.png"),
        PlanEntity(id: 5, title: "京都ぶらぶらデート", imageUrlString: "https://s3-ap-northeast-1.amazonaws.com/sfcgs/%E3%81%B5%E3%82%8D%E3%82%93%E5%A4%AA.png"),
        PlanEntity(id: 6, title: "京都ぶらぶらデート", imageUrlString: "https://s3-ap-northeast-1.amazonaws.com/sfcgs/%E3%81%B5%E3%82%8D%E3%82%93%E5%A4%AA.png"),
        PlanEntity(id: 7, title: "京都ぶらぶらデート", imageUrlString: "https://s3-ap-northeast-1.amazonaws.com/sfcgs/%E3%81%B5%E3%82%8D%E3%82%93%E5%A4%AA.png"),
        PlanEntity(id: 8, title: "京都ぶらぶらデート", imageUrlString: "https://s3-ap-northeast-1.amazonaws.com/sfcgs/%E3%81%B5%E3%82%8D%E3%82%93%E5%A4%AA.png"),
        PlanEntity(id: 9, title: "京都ぶらぶらデート", imageUrlString: "https://s3-ap-northeast-1.amazonaws.com/sfcgs/%E3%81%B5%E3%82%8D%E3%82%93%E5%A4%AA.png"),
        PlanEntity(id: 10, title: "京都ぶらぶらデート", imageUrlString: "https://s3-ap-northeast-1.amazonaws.com/sfcgs/%E3%81%B5%E3%82%8D%E3%82%93%E5%A4%AA.png"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "PlanListCell", bundle: nil), forCellReuseIdentifier: "PlanListCell")
    }
    
    @IBAction func didPressRegisterLinkButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "PlanRegisterViewController", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! PlanRegisterViewController
        present(viewController, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PlanListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanListCell") as! PlanListCell
        cell.setupView(plans[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "PlanViewController", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! PlanViewController
        viewController.planID = plans[indexPath.row].id
        present(viewController, animated: true)
    }
}

struct PlanEntity {
    var id: Int
    var title: String
    var imageUrlString: String
}
