//
//  CollectionViewDataSouce.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/04/02.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit

class TagCollectionViewDataSouce: NSObject {

    private var tagArray: [String] = []
    private var tagCollectionView: UICollectionView
    var tagAllWidth: CGFloat = 10
    
    init(tagCollectionView: UICollectionView) {
        self.tagCollectionView = tagCollectionView
    }
    
    func configure(tagArray: [String]) {
        self.tagArray = tagArray
        tagCollectionView.dataSource = self
        tagCollectionView.register(UINib(nibName: "TagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TagCollectionViewCell")
    }
}

extension TagCollectionViewDataSouce: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if let tagCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as? TagCollectionViewCell {
            tagCollectionViewCell.tagLabel.text = tagArray[indexPath.row]
            tagAllWidth += tagCollectionViewCell.tagLabel.frame.width + 10
            
            // CollectionViewに必要な高さが計算したらActionに流す
            if indexPath.row == tagArray.count - 1 {
                let rowCount = Int(tagAllWidth / tagCollectionView.frame.width) + 1
                let height = (tagCollectionViewCell.tagLabel.frame.height + 10) * CGFloat(rowCount) + 10
                ArticleAction.shared.informHeight(height: height)
            }
            cell = tagCollectionViewCell
        }
        return cell
    }
}
