//
//  ListSearchable.swift
//  OpenMarket
//
//  Created by 이영우 on 2021/05/13.
//

import Foundation

protocol ListSearchable: Decodable {
  associatedtype T
  
  var page: Int { get }
  var items: [T] { get }
}
