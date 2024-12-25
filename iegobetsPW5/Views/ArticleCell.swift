//
//  ArticleCell.swift
//  iegobetsPW5
//
//  Created by Ivan on 25.12.2024.
//

import UIKit

class ArticleCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        static let imageSize: CGFloat = 100
        static let titleFont: UIFont = .boldSystemFont(ofSize: 16)
        static let announceFont: UIFont = .systemFont(ofSize: 14)
        static let imageTopMargin: CGFloat = 8
        static let titleTopMargin: CGFloat = 8
        static let titleLeftMargin: CGFloat = 8
        static let announceTopMargin: CGFloat = 4
        static let announceLeftMargin: CGFloat = 8
        static let announceBottomMargin: CGFloat = 8
        static let titleRightMargin: CGFloat = 8
        static let announceRightMargin: CGFloat = 8
        static let numberOflinesTitle: Int = 1
        static let numnerOfLinesAnnounce: Int = 0
    }
    
    // MARK: - UI Components
    private let titleLabel: UILabel = UILabel()
    private let announceLabel: UILabel = UILabel()
    private let articleImageView: UIImageView = UIImageView()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure(with model: ArticleModel) {
        titleLabel.text = model.title
        announceLabel.text = model.announce
        
        if let imageContainer = model.img, let imageURL = imageContainer.url {
            loadImage(from: imageURL) { [weak self] image in
                self?.articleImageView.image = image
            }
        }
    }
    
    // MARK: - Private methods
    private func configureUI() {
        selectionStyle = .none
        contentView.addSubview(articleImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(announceLabel)
        
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.clipsToBounds = true
        
        articleImageView.pinLeft(to: contentView)
        articleImageView.pinTop(to: contentView, Constants.imageTopMargin)
        articleImageView.setWidth(mode: .equal, Constants.imageSize)
        articleImageView.setHeight(mode: .equal, Constants.imageSize)
        
        titleLabel.font = Constants.titleFont
        titleLabel.numberOfLines = Constants.numberOflinesTitle
        titleLabel.pinLeft(to: articleImageView, Constants.titleLeftMargin)
        titleLabel.pinTop(to: contentView, Constants.titleTopMargin)
        titleLabel.pinRight(to: contentView, Constants.titleRightMargin)
        
        announceLabel.font = Constants.announceFont
        announceLabel.numberOfLines = Constants.numnerOfLinesAnnounce
        announceLabel.pinLeft(to: articleImageView, Constants.announceLeftMargin)
        announceLabel.pinTop(to: titleLabel, Constants.announceTopMargin)
        announceLabel.pinRight(to: contentView, Constants.announceRightMargin)
        announceLabel.pinBottom(to: contentView, Constants.announceBottomMargin)
    }
    
    private func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = try? Data(contentsOf: url) {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
