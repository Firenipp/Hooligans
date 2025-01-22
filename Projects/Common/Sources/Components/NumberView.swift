import UIKit


public class NumberView: UIStackView {
  private let numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

  let numberBox: UILabel = {
    let label = UILabel()
    label.frame = .zero
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .systemBlue

    for number in numbers {
      let label = UILabel(text: String(number))
//      label.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
      addArrangedSubview(label)
    }

    self.distribution = .fillEqually
    self.alignment = .center
    self.axis = .vertical
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

struct PreView: PreviewProvider {
    static var previews: some View {
        // Preview를 보고자 하는 ViewController를 넣으면 됩니다.
        NumberView().toPreview()
    }
}

extension UILabel {
  convenience init(text: String) {
    self.init(frame: .zero)
    self.bounds = .zero
    self.text = text
    self.translatesAutoresizingMaskIntoConstraints = false
  }
}


import SwiftUI

#if DEBUG
extension UIView {
    struct Preview: UIViewRepresentable {
        let view: UIView

        func makeUIView(context: Context) -> UIView {
            return view
        }

        func updateUIView(_ view: UIView, context: Context) {

        }
    }

    func toPreview() -> some View {
        Preview(view: self)
    }
}
#endif
