//
//  Decodable.swift
//  Qiita-Training
//
//  Created by 城島一輝 on 2020/05/04.
//  Copyright © 2020 城島一輝. All rights reserved.
//

import Foundation

extension Decodable {
    
    static func decode(json data: Data) throws -> Self {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(Self.self, from: data)
    }
}
