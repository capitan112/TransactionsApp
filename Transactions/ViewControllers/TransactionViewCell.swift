import UIKit
import SDWebImage

protocol TransactionViewModelCellType {
    var transactions: Transaction? { get}
}

struct TransactionViewModelCell: TransactionViewModelCellType {
    var transactions: Transaction?
}

class TransactionViewCell: UITableViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var selectionView: UIView!
    
    var viewModel: TransactionViewModelCellType? {
        didSet {
            updateUI()
        }
    }
    
    class func reuseIdentifier() -> String {
        return "CellId"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    private func configUI() {
        self.selectionView.alpha = 0.4
        logoImageView.layer.cornerRadius = logoImageView.bounds.width / 2
        logoImageView.layer.masksToBounds = true
        logoImageView.layer.borderWidth = 1.0
        logoImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionView.backgroundColor = selected ? .red : .clear
    }
    
    private func updateUI() {
        guard  let viewModel = viewModel,
               let transactions = viewModel.transactions else { return }
        self.descriptLabel.text = transactions.description
        self.categoryLabel.text = transactions.category
        self.priceLabel.text = String(transactions.price)
        self.logoImageView.sd_setImage(with: URL(string: transactions.iconURL))
    }
}
