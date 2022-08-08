# BefamilyAppStore

**Befamily 어플의 AppStore 상세 페이지 화면을 데모로 구현**
<br>
개발기간 : 2022.08.06 - 08.08 

## 🎯 프로젝트 목표

```
    1. MVVM + CleanArchitecture 적용
    2. RxSwift 및 Input/Output 패턴 적용
    3. RxCocoa, RxGesture 활용
```
<br>

## 📝 기능소개 
|   기본 요소    |   실제 앱스토어 이동   |
| :----------: | :--------: |
|  <img src="https://i.imgur.com/Zdy9Cl8.gif" width="200"> | <img src="https://i.imgur.com/4Otal3y.gif" width="200"> |
|   스크롤과 서브설명 셀 선택 시, 상세설명 이동    |   버튼 클릭 시, 앱스토어 이동 및 개요 화면 늘어남   |


## ⚙️ 개발 환경


[![Swift](https://img.shields.io/badge/swift-v5.5-orange?logo=swift)](https://developer.apple.com/kr/swift/)
[![Xcode](https://img.shields.io/badge/xcode-v13.2-blue?logo=xcode)](https://developer.apple.com/kr/xcode/)
[![rxswift](https://img.shields.io/badge/RxSwift-6.5.0-red)]()
<img src="https://img.shields.io/badge/UIkit-000000?style=flat&logo=UIkit" alt="uikit" maxWidth="100%">


<br>

## 🌟 고민과 해결

### 1. ScrollView 내에 구현된 CollectionView의 스크롤  문제
#### 문제점
ScrollView에 구현한 CollectionView가 스크롤되지 않고 일반 View처럼 고정되어 있는 문제가 발생

#### 해결
- 처음에는 scroll enable의 문제나 cell의 크기가 제대로 지정되지 않아 생긴 문제로 생각하고 접근하였으나, 해당 이슈와 관련된 부분들은 정상적으로 구현되어 있는 상태
- 그러던 중, 이전에 ScrollView의 content height ambiguous 관련 에러로 인해 비슷한 문제가 생겼던 기억이 떠올라 ContentView의 height를 적절하게 지정해주니 해당 문제가 해결됨
--------

### 2. DTO decode failure
#### 문제점
API의 response에 맞춰서 DTO 구조체를 구현하였으나, 정상적으로 디코딩이 되지 않아 에러가 발생

#### 해결
- CodingKeys 설정도 되어 있었기에 어떤 부분이 문제인지 확인하기 어려웠으나, Date 타입과 관련하여 포맷이 "yyyy-MM-dd'T'HH:mm:SSZ" 형태로 되어 있는 것을 확인
- 이전에 백엔드 사람들과 작업할 당시 위와 같이 iOS에서 바로 Date 타입으로 디코딩이 불가했던 것이 떠올랐고, 해당 요소는 String 타입으로 받아오도록 변경하여 정상 디코딩을 확인
--------

### 3. DTO or Entity UserDefault 저장
#### 고민요소
Image의 경우에는 Filemanager를 통해 cache하여 저장하고 있으니, DTO나 Entity 또한 UserDefault에 저장하여 바로 로컬에서 작업이 가능하게끔 구현하는 것이 어떨지에 대한 고민이 생김

#### 선택
- 먼저 Entity의 경우에는 Usecase에서 변환해주는 데이터 타입이다보니, 이를 꺼내올 때에도 Usecase에서 작업이 이루어져야 하는데 로컬에서 데이터를 빼오는 작업은 Repository 담당이니 서로의 역할이 무너질 수 있겠다는 판단을 내림
(저장만 Usecase에서 하고, Repository에서 Entity를 빼내는 형태를 고민했으나, 분기 처리와 리턴 타입으로 인해 더욱 복잡한 구조가 될 듯 하여 기각함)
- DTO를 저장해서 Repository에서 담당하는 형태로 구현하려고 했으나 해당 데이터는 언제든지 업데이트가 될 가능성이 높은데 로컬에 저장했을 경우, 업데이트되지 않은 데이터를 계속 사용할 수도 있게 되겠다는 생각이 듬
또한 업데이트가 언제 됐는지 알고 네트워크로 데이터를 받아올 지에 대한 분기 처리를 판단하기 어려워 결국 이미지만 로컬에 저장하는 형태로 구현 
--------


### 4. AutoLayout과 frame 값
#### 고민요소
ContentView의 높이 값은 모든 내부 View들의 fram.height 값을 더한 CGFloat 타입으로 설정하고 있음. 그러나 기존에 설정한 AutoLayout의 constraint를 변경하고 곧장 ContentView의 높이 값을 변경해주려고 하니 frame.height가 0으로 출력되어 변경 사항이 제대로 적용되지 않는 문제가 발생함.

문제 사항은 해결하였으나 문득 Autolayout으로 설정한 뒤 frame 값으로 반영되는 시점이 언제인지, frame 값이 설정된 이후에 호출해야하는 메서드가 있다면 언제 어떻게 호출해야되는지에 대한 의문이 듬.

여러 사이트를 돌아다니면서 서칭을 하였으나 이에 대한 명확한 정보가 없어 여전히 해결하지 못한 고민으로 남아있음.



