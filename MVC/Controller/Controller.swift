//
//  Controller.swift
//  MVC
//
//  Created by KS on 2021/11/21.
//

import Foundation

class Controller {
    weak var myModel: Model?

    required init() {}
    @objc func onMinusTapped() { myModel?.countDown() }
    @objc func onPlusTapped() { myModel?.countUp() }

}
