//
//  Model.swift
//  MVC
//
//  Created by KS on 2021/11/21.
//

import Foundation

// countが更新されたときにNortificationCenterに通知を送ることで監視できる状態を作り出す。countDown、upメソッドがcontorollerがcountを更新するたび起動
final class Model {
    let notificationCenter = NotificationCenter()

    private(set) var count = 0 {
        didSet {
            notificationCenter.post(name: .init(rawValue: "count"), object: nil, userInfo: ["count": count])
        }
    }

    func countDown() { count -= 1 }
    func countUp() { count += 1 }
}
