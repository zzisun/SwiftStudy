import UIKit

final class NewsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabelDesign()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ info: NewsInfo) {
        titleLabel.text = info.title
        contentLabel.text = info.content
    }
    
    private func setupLabelDesign() {
        titleLabel.layer.cornerRadius = 5
        titleLabel.layer.masksToBounds = true
    }
}
