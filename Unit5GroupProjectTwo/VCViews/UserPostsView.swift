//
//  UserPostsView.swift
//  Unit5GroupProjectTwo
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
class UserPostsView: UIView {
    //Table view
    lazy var postTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "PostCell")
        return tableView
    }()
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "PrettyCat")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "PrettyCat")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "username"
        return label
    }()
    //#of postes calcualted
    lazy var NumberofPostsLabel: UILabel = {
        let label = UILabel()
        label.text = "numberofposts"
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // make profile image a circle
        profileImage.layer.cornerRadius = profileImage.bounds.width/2.0
        profileImage.layer.masksToBounds = true
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        backgroundColor = .white
        setupViews()
        constraints()
    }
    
    private func setupViews() {
        addSubview(postTableView)
        addSubview(profileImage)
        addSubview(userNameLabel)
        addSubview(NumberofPostsLabel)
    }
    
    
    private func constraints(){
        profileImage.layer.cornerRadius = profileImage.bounds.width/2.0
        profileImage.layer.masksToBounds = true
        profileImage.snp.makeConstraints { (make) in make.centerX.equalTo(snp.centerX)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.width.equalTo(snp.width).multipliedBy(0.30)
            make.height.equalTo(profileImage.snp.width)
            
        }
        userNameLabel.snp.makeConstraints { (name) in
            name.top.equalTo(profileImage.snp.bottom).offset(5)
            name.centerX.equalTo(self.snp.centerX)
        }
        NumberofPostsLabel.snp.makeConstraints { (posts) in
            posts.top.equalTo(userNameLabel.snp.bottom).offset(10)
            posts.centerX.equalTo(self.snp.centerX)
        }
        
        postTableView.snp.makeConstraints { (tableView) in
            tableView.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            tableView.right.left.equalTo(self)
            tableView.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.7)
            
        }
    }
}
