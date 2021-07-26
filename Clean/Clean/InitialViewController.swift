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
    }

    func setupClockHands() {
        hourHandImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        minuteHandImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        secondHandImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)

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
        print("testUIView frame ", testUIView.frame)

        self.testUIView.addConstraint(NSLayoutConstraint(item: testUIView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300))
        self.testUIView.addConstraint(NSLayoutConstraint(item: testUIView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300))
    }
}

extension UIView {
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }
}
