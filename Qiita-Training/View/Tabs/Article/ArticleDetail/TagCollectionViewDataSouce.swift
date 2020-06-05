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
            tagCollectionViewCell.configure(tagText: tagArray[indexPath.row])
            cell = tagCollectionViewCell
        }
        
        return cell
    }
}
