//
//  View.swift
//  MVC
//
//  Created by KS on 2021/11/21.
//

import Foundation
import UIKit


class ViewController: UIViewController {

    private lazy var myView = View()

    override func loadView() {
        view = myView
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // ここで外部から View に Model を渡しているとイメージしてください。
        myView.myModel = Model()
    }
}

class View: UIView {

    let label = UILabel()
    let minusButton = UIButton()
    let plusButton = UIButton()

    var defaultControllerClass: Controller.Type = Controller.self
    private var myController: Controller?

    var myModel: Model? {
        didSet { // Controller生成と、Model監視を開始する
            registerModel()
        }
    }

    deinit {
        myModel?.notificationCenter.removeObserver(self)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    private func setSubviews() {

        addSubview(label)
        addSubview(minusButton)
        addSubview(plusButton)

        label.textAlignment = .center

        label.backgroundColor = .clear
        minusButton.backgroundColor = .systemBlue
        plusButton.backgroundColor = .systemGreen

        minusButton.setTitle("-1", for: .normal)
        plusButton.setTitle("+1", for: .normal)

    }

    private func setLayout() {

        label.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.translatesAutoresizingMaskIntoConstraints = false

        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: minusButton.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: plusButton.topAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: minusButton.heightAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: plusButton.heightAnchor).isActive = true
        minusButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        plusButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        minusButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        minusButton.rightAnchor.constraint(equalTo: plusButton.leftAnchor).isActive = true
        plusButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        minusButton.widthAnchor.constraint(equalTo: plusButton.widthAnchor).isActive = true

    }

    private func registerModel() {

        guard let model = myModel else { return }

        let controller = defaultControllerClass.init()
        controller.myModel = model
        myController = controller

        label.text = model.count.description

        minusButton.addTarget(controller, action: #selector(Controller.onMinusTapped), for: .touchUpInside)
        plusButton.addTarget(controller, action: #selector(Controller.onPlusTapped), for: .touchUpInside)

        model.notificationCenter.addObserver(forName: .init(rawValue: "count"),object: nil, queue: nil, using: { [unowned self] notification in
            if let count = notification.userInfo?["count"] as? Int { self.label.text = count.description }
        })
    }
}
