import SDWebImage
import UIKit

protocol TransactionViewModelCellType {
    var description: String { get }
    var category: String { get }
    var currencyISO: String { get }
    var price: String { get }
    var iconURL: URL? { get }
}

class TransactionViewCell: UITableViewCell {
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var descriptLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var selectionView: UIView!

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
        selectionView.alpha = 0.4
        logoImageView.layer.cornerRadius = logoImageView.bounds.width / 2
        logoImageView.layer.masksToBounds = true
        logoImageView.layer.borderWidth = 1.0
        logoImageView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionView.backgroundColor = selected ? .red : .clear
    }

    private func updateUI() {
        guard let viewModel = viewModel else { return }
        descriptLabel.text = viewModel.description
        categoryLabel.text = viewModel.category
        priceLabel.text = viewModel.price
        logoImageView.sd_setImage(with: viewModel.iconURL, placeholderImage: UIImage(named: "placeholder"))
    }
}
