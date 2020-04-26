//
//  CollectionViewFlowLayout.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/04/12.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import UIKit

final class TagCollectionViewFlowLayoutLeftAlign: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        // 表示領域のレイアウト属性を取得する。
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
//        // layoutAttributesForItemAtIndexPath(_:)で各レイアウト属性を書き換える
        var attributesToReturn:[UICollectionViewLayoutAttributes] = []
        attributesToReturn = attributes.map { ($0.copy() as? UICollectionViewLayoutAttributes ?? UICollectionViewLayoutAttributes()) }

        for (index, attribute) in attributes.enumerated() where attribute.representedElementCategory == .cell {
            attributesToReturn[index] = layoutAttributesForItem(at: attribute.indexPath) ?? UICollectionViewLayoutAttributes()
        }
        
        return attributesToReturn
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let currentAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes,
            let viewWidth = collectionView?.frame.width else { return nil }

        // sectionInsetの値を左端として取得。
        let sectionInsetsLeft = sectionInsets(at: indexPath.section).left

        // 先頭セルの場合はx座標を左端にして返す
        guard indexPath.item > 0 else {
            currentAttributes.frame.origin.x = sectionInsetsLeft
            return currentAttributes
        }

        // ひとつ前のセルを取得
        let prevIndexPath = IndexPath(row: indexPath.item - 1, section: indexPath.section)
        
        guard let prevFrame = layoutAttributesForItem(at: prevIndexPath)?.frame else { return nil }
        
        // 現在のセルの行内にひとつ前のセルが収まっているか比較する。収まっていなければx座標を左端にして返す
        let validWidth = viewWidth - sectionInset.left - sectionInset.right
        let currentColumnRect = CGRect(x: sectionInsetsLeft, y: currentAttributes.frame.origin.y, width: validWidth, height: currentAttributes.frame.height)
        
        guard prevFrame.intersects(currentColumnRect) else {
            currentAttributes.frame.origin.x = sectionInsetsLeft
            return currentAttributes
        }

        // 一つ前のセルからminimumInteritemSpacing分だけ離れた位置にx座標をずらす
        let prevItemTailX = prevFrame.origin.x + prevFrame.width
        currentAttributes.frame.origin.x = prevItemTailX + minimumInteritemSpacing(at: indexPath.section)
        
        return currentAttributes
    }

    // sectionInsetをdelegateメソッドから取得
    private func sectionInsets(at index: Int) -> UIEdgeInsets {
        guard let collectionView = collectionView,
            let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout else { return self.sectionInset }
        
        return delegate.collectionView?(collectionView, layout: self, insetForSectionAt: index) ?? self.sectionInset
    }

    // minimumInteritemSpacingをdelegateメソッドから取得
    private func minimumInteritemSpacing(at index: Int) -> CGFloat {
        guard let collectionView = collectionView,
            let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout else { return self.minimumInteritemSpacing }
        
        return delegate.collectionView?(collectionView, layout: self, minimumInteritemSpacingForSectionAt: index) ?? self.minimumInteritemSpacing
    }
}
