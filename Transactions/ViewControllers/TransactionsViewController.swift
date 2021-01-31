import UIKit

protocol TransactionsViewModelType {
    var transactions: Bindable<[Transaction]?> { get }
    func fetchTransactions()
}

class TransactionsViewController: UITableViewController, Storyboarded {
    var transactions: [Transaction]?
    private var doneButton: UIBarButtonItem!
    private var editButton: UIBarButtonItem!
    var viewModel: TransactionsViewModelType?

    private func setupBindings() {
        viewModel?.transactions.bind { [unowned self] in
            guard let transactions = $0 else { return }
            self.transactions = transactions
            self.reloadTableView()
            self.setDoneMode()
        }
    }

    private func setDoneMode() {
        performUIUpdatesOnMain { [unowned self] in
            self.updateStateForMode(isEditMode: false)
        }
    }

    private func reloadTableView() {
        performUIUpdatesOnMain { [unowned self] in
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        configTableView()
        configToolBar()
        configBarButtonItem()
        updateStateForMode(isEditMode: false)
    }

    @IBAction func refreshControllerDidChange(_ sender: UIRefreshControl) {
        viewModel?.fetchTransactions()
        reloadTableView()
        sender.endRefreshing()
    }

    private func configBarButtonItem() {
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
    }

    private func configTableView() {
        let className = String(describing: TransactionViewCell.self)
        tableView.register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: TransactionViewCell.reuseIdentifier())
        tableView.rowHeight = 80.0
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
    }

    private func configToolBar() {
        let removeButton = UIBarButtonItem(title: "Remove", style: .plain, target: self, action: #selector(removeSelectedCellTapped))
        removeButton.tintColor = .white
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbarItems = [spacer, removeButton, spacer]
        navigationController?.toolbar.barTintColor = .red
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return transactions?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = TransactionViewCell.reuseIdentifier()
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TransactionViewCell
        if let transactions = transactions {
            let transactionViewModelCell = TransactionViewModelCell(transaction: transactions[indexPath.row])
            cell.viewModel = transactionViewModelCell
        }

        cell.setSelected(cell.isSelected, animated: true)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt _: IndexPath) {
        let isCellsSelected = tableView.indexPathsForSelectedRows?.count ?? 0 > 0
        toolBarAnimate(isHiden: !isCellsSelected)
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt _: IndexPath) {
        let isCellsDeselected = tableView.indexPathsForSelectedRows?.count ?? 0 > 0
        toolBarAnimate(isHiden: !isCellsDeselected)
    }

    // MARK: - Handle selections

    func updateStateForMode(isEditMode: Bool) {
        tableView.allowsMultipleSelection = isEditMode
        if isEditMode {
            navigationItem.rightBarButtonItems = [doneButton]
        } else {
            navigationItem.rightBarButtonItems = [editButton]
            toolBarAnimate(isHiden: true)
        }

        deselectRowAllCells()
    }

    @objc
    func doneTapped(_: Any) {
        updateStateForMode(isEditMode: false)
    }

    @objc
    func editTapped(_: Any) {
        updateStateForMode(isEditMode: true)
    }

    private func toolBarAnimate(isHiden: Bool) {
        navigationController?.setToolbarHidden(isHiden, animated: true)
    }

    private func deselectRowAllCells() {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            selectedRows.forEach {
                self.tableView.deselectRow(at: $0, animated: true)
            }
        }
    }

    @objc
    func removeSelectedCellTapped(_: Any) {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            var transactionsToRemove = [Transaction]()

            for indexPath in selectedRows {
                if let transactions = transactions {
                    transactionsToRemove.append(transactions[indexPath.row])
                }
            }

            for transactionToRemove in transactionsToRemove {
                if let index = transactions?.firstIndex(where: { $0 == transactionToRemove }) {
                    transactions?.remove(at: index)
                }
            }

            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .automatic)
            tableView.endUpdates()
            updateStateForMode(isEditMode: false)
        }
    }
}
