//
//  QueueItem.swift
//  wearbear
//
//  Created by Benhur on 17/10/24.
//

import Foundation

struct QueueItem: Decodable {
    let robotId: Int
    let locationId: Int
    let status: String
}
