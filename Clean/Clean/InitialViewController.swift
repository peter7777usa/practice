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
        case .changed:
                let point1 = sender.location(ofTouch: 0, in: square)
                let point2 = sender.location(ofTouch: 1, in: square)
                let midPoint = CGPoint(x: (point1.x + point2.x) / 2, y: (point1.y + point2.y) / 2)

                let oldAnchorPoint = square.layer.anchorPoint
                let newAnchorPoint = CGPoint(x: midPoint.x / square.bounds.width, y: midPoint.y / square.bounds.height)

                square.layer.anchorPoint = newAnchorPoint

                let offsetFromMovingAnchorPointX = square.bounds.width * (newAnchorPoint.x - oldAnchorPoint.x)
                let offsetFromMovingAnchorPointY = square.bounds.height * (newAnchorPoint.y - oldAnchorPoint.y)

               // square.transform = CGAffineTransform(translationX: offsetFromMovingAnchorPointX, y: offsetFromMovingAnchorPointY)



                square.rotate(radians: sender.rotation)

                print("in here ", midPoint,  sender.rotation)

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
}
