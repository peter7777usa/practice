//
//  ViewController.swift
//  interview
//
//  Created by Peter Fong on 7/14/21.
//

import UIKit

class CountingTracker {
    static let sharedInstance = CountingTracker()
    var timeTracker = [Int: Double]()
}

class InitialViewController: UIViewController {

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.frame = self.view.frame
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CountingTableViewCell.self, forCellReuseIdentifier: CountingTableViewCell.identifier)
    }

}

extension InitialViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: CountingTableViewCell.identifier, for: indexPath) as? CountingTableViewCell else {
            return UITableViewCell ()

        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CountingTableViewCell else { return }
        cell.flipFlopTimer(self)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CountingTableViewCell else { return }
        cell.index = indexPath.row
        if let oldCount = CountingTracker.sharedInstance.timeTracker[indexPath.row] {
            cell.counter = oldCount
        } else {
            cell.counter = 0
        }
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CountingTableViewCell else { return }
        CountingTracker.sharedInstance.timeTracker[cell.index] = cell.counter
    }
}

