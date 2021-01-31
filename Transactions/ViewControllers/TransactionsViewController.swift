import UIKit


protocol TransactionsViewModelType {
    func fetchTransactions()
    var transactions: Bindable<[Transaction]?> { get}
}

class TransactionsViewController: UITableViewController, Storyboarded {

    private var transactions: [Transaction]?
    var viewModel: TransactionsViewModelType? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        self.reloadTableView()
    }
    
    private func setupBindings() {
        viewModel?.transactions.bind({ [unowned self] in
            guard let transactions = $0 else { return }
            self.transactions = transactions
            self.reloadTableView()
        })
    }
    
    private func reloadTableView() {
        performUIUpdatesOnMain { [unowned self] in
            self.tableView.reloadData()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBindings()
        let className = String(describing: TransactionViewCell.self)
        tableView.register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: TransactionViewCell.reuseIdentifier())
        tableView.rowHeight = 100.0
        tableView.allowsMultipleSelection = true
        let edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItems = [edit]
        tableView.tableFooterView = UIView()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! TransactionViewCell
        let transactionViewModelCell = TransactionViewModelCell(transactions: transactions?[indexPath.row])
        cell.viewModel = transactionViewModelCell
        cell.setSelected(true, animated: true)
        
        return cell
    }
    
    @objc
    func editTapped(_ sender: Any) {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            guard let transactions = transactions else { return }
            var items = [Transaction]()
            for indexPath in selectedRows  {
                items.append(transactions[indexPath.row])
            }
            
            for item in items {
                if let index = transactions.firstIndex(of: item) {
                    self.transactions?.remove(at: index)
                }
            }
            
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .automatic)
            tableView.endUpdates()
        }
    }
}
