//
//  TitleView.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/06.
//

import UIKit

final class MainTitleView: UIView {
    
    private var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var subLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .gray
        label.numberOfLines = 1
        label.text = "가까운 사람들끼리 쓰는 메신저"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var downButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.backgroundColor = .blue
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.setTitle("받기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayouts()
        setTitleData()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitleData() {
        guard let url = URL(string: "https://is2-ssl.mzstatic.com/image/thumb/Purple122/v4/c1/c6/b5/c1c6b509-8c75-7f84-412f-4a24bbfb4abd/AppIcon-0-0-1x_U007emarketing-0-0-0-5-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/512x512bb.jpg") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            titleImageView.image = UIImage(data: data)
        } catch {
            return
        }
    
        titleLabel.text = "비패밀리 메신저 Befamily Messenger"
    }
}

private extension MainTitleView {
    
    func configureLayouts() {
        addSubviews(titleImageView, titleLabel, subLabel, downButton)
        titleLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            titleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleImageView.topAnchor.constraint(equalTo: topAnchor),
            titleImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleImageView.widthAnchor.constraint(equalTo: titleImageView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            subLabel.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: 15),
            subLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            downButton.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: 15),
            downButton.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 10),
            downButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            downButton.widthAnchor.constraint(equalTo: subLabel.widthAnchor, multiplier: 0.35)
        ])
    }
}
