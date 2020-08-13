//
//  ArticleViewModel.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/02/01.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit
import SwiftyUserDefaults
import RealmSwift

final class ArticleDetailViewModel: NSObject {

    func appendTagArray(tagArray: [String]) {
        tagArray.forEach { tag in
            Defaults.searchedTagArray.append(tag)
        }
    }
    
    func seveArticle(article: Article?) {
        guard let article = article else { return }
        
        let realm = try? Realm()
        
        try? realm?.write {
            let articleObject = ArticleRealmObject()
            articleObject.article = article
            realm?.add(articleObject)
        }
    }
}
