//
//  ViewController.swift
//  interview
//
//  Created by Peter Fong on 7/14/21.
//

import UIKit

class InitialViewController: UIViewController {

    var timer = Timer()
    let hourHandImageView = UIImageView(image: UIImage(named: "hourhand"))
    let minuteHandImageView = UIImageView(image: UIImage(named: "minutehand"))
    let secondHandImageView = UIImageView(image: UIImage(named: "secondhand"))

    var testUIView = UIView()

    var frameCovering = UIView()

    private var second = 0
    private var minute = 0

    var secondCount: Int {
        set {
            if second >= 60 {
                minuteCount += 1
                second = 0
                self.minuteHandImageView.rotate(angle: 6)
            } else {
                second += 1
            }
        }
        get {
            return second
        }
    }

    var minuteCount: Int {
        set {
            if minute >= 60 {
                minute = 0
                self.hourHandImageView.rotate(angle: 6)
            } else {
                minute += 1
            }
        }
        get {
            return minute
        }
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        testUIView.backgroundColor = .systemBlue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupClockHands()
        //setupTestViewStuff()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("testUIView frame ", self.testUIView.frame)
    }

    func setupTestViewStuff() {
        frameCovering.isMultipleTouchEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        frameCovering.addGestureRecognizer(panGesture)
    }

    @objc func handlePan(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            print("begin")
        case .changed:
            //print(getCenterOfTouches(sender: sender))

            let centerPoint = getCenterOfTouches(sender: sender)
            let oldAnchorPoint = frameCovering.layer.anchorPoint
            let newAnchorPoint = CGPoint(x: centerPoint.x / frameCovering.bounds.width, y: centerPoint.y / frameCovering.bounds.height)
            let offSetFromMovingAnchorPointX = frameCovering.bounds.width * (newAnchorPoint.x - oldAnchorPoint.x)
            let offSetFromMovingAnchorPointY = frameCovering.bounds.width * (newAnchorPoint.y - oldAnchorPoint.y)

            frameCovering.transform = CGAffineTransform(translationX: offSetFromMovingAnchorPointX, y: offSetFromMovingAnchorPointY)
            frameCovering.layer.anchorPoint = newAnchorPoint
            //print("changed")
        case .cancelled:
            print("cancelled")
        case .ended:
            print("ended")
        default:
            break
        }
    }

    private func getCenterOfTouches(sender: UIPanGestureRecognizer) -> CGPoint {
        var touchesPoints = [CGPoint]()
        print ("sender.numberOfTouches ", sender.numberOfTouches )
        var midX: CGFloat = 0
        var midY: CGFloat = 0
        for touchIndex in 0..<sender.numberOfTouches {
            print("point ", sender.location(ofTouch: touchIndex, in: frameCovering))

            touchesPoints.append(sender.location(ofTouch: touchIndex, in: frameCovering))
        }


        for point in touchesPoints {
            midX += point.x
            midY += point.y
        }

        midX = midX / CGFloat(touchesPoints.count)
        midY = midY / CGFloat(touchesPoints.count)

        return CGPoint(x: midX, y: midY)
    }

    func setupClockHands() {
        hourHandImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        minuteHandImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        secondHandImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)


        frameCovering = UIView(frame: CGRect(x: 18.22330470336314, y: 245.2233047033631, width: 353.5533905932738, height: 353.55339059327383))
        frameCovering.backgroundColor = .systemRed

        self.view.addSubview(frameCovering)
        self.view.addSubview(testUIView)
        self.view.addSubview(hourHandImageView)
        self.view.addSubview(minuteHandImageView)
        self.view.addSubview(secondHandImageView)

        setupClockHandsConstraint()

        timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { [unowned self] timer in
            self.secondHandImageView.rotate(angle: 6)
            self.secondCount += 1
            if self.secondCount >= 60 {
                self.minuteCount += 1
                self.secondCount = 0
            }
        }
        //self.view.addSubview(minuteHand)
        //self.view.addSubview(secondHand)
    }

    private func setupClockHandsConstraint() {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.hourHandImageView.translatesAutoresizingMaskIntoConstraints = false
        self.minuteHandImageView.translatesAutoresizingMaskIntoConstraints = false
        self.secondHandImageView.translatesAutoresizingMaskIntoConstraints = false
        self.testUIView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addConstraint(NSLayoutConstraint(item: hourHandImageView, attribute:.centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: hourHandImageView, attribute:.centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))

        self.view.addConstraint(NSLayoutConstraint(item: minuteHandImageView, attribute:.centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: minuteHandImageView, attribute:.centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))

        self.view.addConstraint(NSLayoutConstraint(item: secondHandImageView, attribute:.centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: secondHandImageView, attribute:.centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))

        self.view.addConstraint(NSLayoutConstraint(item: testUIView, attribute:.centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: testUIView, attribute:.centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))

        self.testUIView.rotate(angle: 45)

        self.testUIView.addConstraint(NSLayoutConstraint(item: testUIView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250))
        self.testUIView.addConstraint(NSLayoutConstraint(item: testUIView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250))
    }
}

extension UIView {
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }
}
