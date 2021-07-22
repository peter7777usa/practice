//
//  CountingTableViewCell.swift
//  interview
//
//  Created by Peter Fong on 7/16/21.
//

import UIKit

class CountingTableViewCell: UITableViewCell {

    var timer : Timer?
    var counter: Double = 0

    var index = -1

    static var identifier = "CountingTableViewCellIdentifier"
    let countingTimeLabel = UILabel()

    var isCounting = true

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(countingTimeLabel)
        countingTimeLabel.text = String(format: "%.2f", counter)
        countingTimeLabel.frame = CGRect(x: self.frame.origin.x + 30, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height)
        timerStuff()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        counter = 0
    }

    private func timerStuff() {
        timer = Timer.scheduledTimer(timeInterval:0, target:self, selector:#selector(prozessTimer), userInfo: nil, repeats: true)
    }

    @objc func prozessTimer() {
        counter += 0.01
        countingTimeLabel.text = String(format: "%.2f", counter)

    }

    func flipFlopTimer(_ sender: AnyObject) {
        if isCounting == true {
            timer?.invalidate()
            timer = nil
            isCounting = false
        } else {
            timerStuff()
            isCounting = true
        }
    }
}
