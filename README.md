# Chain Builder

<p align="center">
<a href="https://travis-ci.org/marty-suzuki/DuctTape"><img alt="CI Status" src="https://img.shields.io/travis/marty-suzuki/DuctTape.svg?style=flat"/></a>
<a href="https://swift.org/package-manager"><img alt="SwiftPM" src="https://img.shields.io/badge/SwiftPM-compatible-green.svg"/></a>
<a href="https://developer.apple.com/swift"><img alt="Swift5" src="https://img.shields.io/badge/language-Swift5-orange.svg"/></a>
</p>

Make everything ```chainable```, add just ```.chain``` and keep typing.

```swift
let label = UILabel().chain
    .numberOfLines(0)
    .textColor(.red)
    .text("Hello, World!!")
    .build()
```

Above is same as below definition.

```swift
let label: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textColor = .red
    label.text = "Hello, World!!"
    return label
}()
```

## Usage

```swift
let chain: Chain<UIView> = UIView().chain
```

If you access `.chain`, it returns `Chain` that provides setter of properties via KeyPath dynamicMemberLookup.

```swift
let view: UIView = UIView().chain
    .backgroundColor(.red)
    .translatesAutoresizingMaskIntoConstraints(false)
    .build()
```

Finally, if you call `.build()`, `Chain` returns instance that has set property values.

#### How to access methods

If you want to access methods of object which is building, `func reinforce(_ handler: (Base) -> Void) Chain<Base>` enable to access methods.

```swift
let collectionView = UICollectionView().chain
    .backgroundColor(.red)
    .reinforce { collectionView in
        collectionView.register(UITableViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    .build()
```

`Chain` has `func reinforce<T1, ...>(_ t1: T1, ..., handler: (Base) -> Void) Chain<Base>` methods.
In additional usage, be able to access outside object with `func reinforce` if passing objects as arguments.

```swift
lazy var collectionView = UICollectionView().chain
    .translatesAutoresizingMaskIntoConstraints(false)
    .reinforce(view) { collectionView, view in
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
    }
    .build()
```

#### How to use ChainBuilder with self-implemented classes

There are two ways to use DuctTape.

1. Use Chainable

```swift
class Dog: Chainable {
    var name: String
}

let dog = Dog().chain
    .name("Duggie")
    .build()
```

2. Use Chain directly

```swift
class Dog {
    var name: String
}

let dog = Chain(Dog())
    .name("Lassie")
    .build()
```

#### Sample Code

```swift
class ViewController: UIViewController {

    let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        .chain
        .minimumLineSpacing(10)
        .minimumInteritemSpacing(10)
        .itemSize(CGSize(width: 100, height: 100))
        .scrollDirection(.vertical)
        .build()

    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero,
                                                                 collectionViewLayout: flowLayout)
        .chain
        .dataSource(self)
        .delegate(self)
        .translatesAutoresizingMaskIntoConstraints(false)
        .reinforce {
            $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        }
        .build()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
    }
}
```

## Requirement

- Xcode 11
- macOS 10.10
- iOS 9.0
- tvOS 10.0
- watchOS 3.0

## Installation

#### CocoaPods
Removed, no longer need it. Use lovely SPM.

#### Carthage
Removed, no longer need it. Use lovely SPM.

#### Swift Package Manager
```
.package(url: "https://github.com/trevor-sonic/ChainBuilder.git", from: "1.0.0")
```

## License
ChainBuilder is released under the MIT License.
Originally forked from github "marty-suzuki/DuctTape"
I just removed useless Pod and Carthage installs and also renamed to my taste.

