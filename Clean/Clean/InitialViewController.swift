//
//  ViewController.swift
//  interview
//
//  Created by Peter Fong on 7/14/21.
//

import UIKit

class InitialViewController: UIViewController {

    let square = UIView(frame: CGRect(x: 75, y: 200, width: 250, height: 250))

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        square.backgroundColor = UIColor.systemBlue
        self.view.addSubview(square)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        addSquarePanGesture()
    }

    private func addSquarePanGesture() {
        let squarePanGesture = UIRotationGestureRecognizer(target: self, action: #selector(squareRotate))
        square.addGestureRecognizer(squarePanGesture)
    }

    @objc private func squareRotate(sender: UIRotationGestureRecognizer) {
        switch sender.state {
        case .began:
            if sender.numberOfTouches == 2 {
                let point1 = sender.location(ofTouch: 0, in: square)
                let point2 = sender.location(ofTouch: 1, in: square)
                let midPoint = CGPoint(x: (point1.x + point2.x) / 2, y: (point1.y + point2.y) / 2)
                let newAnchorPoint = CGPoint(x: midPoint.x / square.bounds.width, y: midPoint.y / square.bounds.height)
                square.setAnchorPoint2(newAnchorPoint)
            }
        case .changed:
            if sender.numberOfTouches == 2 {
                square.rotate(radians: sender.rotation)
                sender.rotation = 0
            }

        case .ended:
            print("ended")
            square.setAnchorPoint2(CGPoint(x: 0.5, y: 0.5))

        default:
            print("default")
        }
    }
}

extension UIView {
    func rotate(radians: CGFloat) {
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }

    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }

    func setAnchorPoint2(_ point: CGPoint) {
        let oldAnchorPoint = self.layer.anchorPoint
        let newAnchorPoint = point

        let offsetFromMovingAnchorPointsX = self.bounds.width * (newAnchorPoint.x - oldAnchorPoint.x)
        let offsetFromMovingAnchorPointsY = self.bounds.height * (newAnchorPoint.y - oldAnchorPoint.y)

        self.layer.anchorPoint = newAnchorPoint

        self.transform = self.transform.translatedBy(x: offsetFromMovingAnchorPointsX, y: offsetFromMovingAnchorPointsY)
    }
}
