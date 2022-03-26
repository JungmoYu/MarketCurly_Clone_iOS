
# MarketCurly - JM

## 1차 피드백 일정
22' 3/22 9:30 PM
## 2차 피드백 일정
22' 3/28 9:00 PM


### 22'3/19 - 1일차 개발 일지
1. 서버 개발자분과 개발 계획서 작성
2. Template 에 맞게 프로젝트 생성
3. 뼈대 레이아웃 잡기


### 22'3/20 - 2일차 개발 일지
1. 개발 계획서 수정(피드백에서 내용이 너무 많다고 하셔서, 1차 개발 완료 후 추가할 것 추가하기로 수정)
2. Main Tab 컨트롤러의 개략적인 뷰 완성시키기 완료(홈, 카테고리, 검색, 마이컬리)
3. 2. 에서 구현한 내용 중 미완성, 오작동 하는 기능들이 있음(search, collection view reloadData시 layout다시 그리기 불가 등)

질문 사항
1. HomeView내의 특정 CollectionView Cell에서 다시 viewController를 생성하여 'Tabman라이브러리 이용 -> 또다른 뷰 구성' 이 작업을 하고싶은데, 불가한 상태
2. SearchController를 NavigationController와 연동하지 않고(NavigationBar 바깥에서 사용) 사용해야 하는데, SearchBar클릭(활성화)시 Layout이 심각하게 깨지는 현상
3. CollectionView에서 reloadData를 수행했을 때, 데이터만 업데이트 하는것 이외에도 레이아웃도 다시 그렸으면 좋겠는데, 그럴 방법이 없는지 더 찾아봐야 하는 상태


<img width="150" alt="image" src="https://user-images.githubusercontent.com/86354361/159168921-f23af801-f060-4d5d-8521-c73c85eeee59.png">
<img width="150" alt="image" src="https://user-images.githubusercontent.com/86354361/159168977-62246981-cf06-4d7a-9adf-d0f2264506e2.png">
<img width="150" alt="image" src="https://user-images.githubusercontent.com/86354361/159168982-f07cdba5-763e-4990-aa82-c15a565a54fb.png">
<img width="150" alt="image" src="https://user-images.githubusercontent.com/86354361/159168985-7edad6a2-5405-4967-8cb2-f57840efa633.png">
<img width="150" alt="image" src="https://user-images.githubusercontent.com/86354361/159168994-02fca701-ea79-40a7-b71f-a95eaa430f9e.png">
<img width="150" alt="image" src="https://user-images.githubusercontent.com/86354361/159168932-e2012189-ef8f-419b-90d4-c2a38b98ca64.png">
<img width="150" alt="image" src="https://user-images.githubusercontent.com/86354361/159168946-a703a63a-fbdc-4d5b-b44c-83476c01b289.png">
<img width="150" alt="image" src="https://user-images.githubusercontent.com/86354361/159168954-5130a5f5-3c20-45a7-b9ea-f96033c86158.png">
<img width="150" alt="image" src="https://user-images.githubusercontent.com/86354361/159168962-a5c4c8a7-0d06-42db-9a9a-e8c883977110.png">
<img width="150" alt="image" src="https://user-images.githubusercontent.com/86354361/159168970-a9563f5f-e0c0-47d0-a9d6-1a508c3e7be8.png">


### 22'3/21 - 3일차 개발 일지
1. 회원가입 UI구성 (남은 부분 있음)
<img width="150" alt="image" src="https://user-images.githubusercontent.com/86354361/159175596-c707812a-6d6e-4ecc-aedb-aabdf507ec68.png">


질문 사항
1. NavigationBar의 색상을 상황에 따라 다르게 하고싶은데 appearance가 변경이 되지 않는 상황(회원가입 뷰)
  - 사진을 보면 회원가입 UI의 navigationBar background color가 실제 UI(흰색)고 다름



### 22'3/22 - 4일차 개발 일지
1. 회원가입 UI 남은 부분 구성
2. Category view 오류 수정 (같은 섹션의 셀을 선택할 시 접히는 코드가 잘못 구현되어있었음)


질문 사항
1. 버튼 클릭 시 tintColor만을 조절했는데도 불구하고, selected상태에서만 배경색이 생기는 현상(사진 첨부)
2. 내일 특정시간(예시 : 내일 아침 10시)을 데이터로 저장하는 방법..? (현재 시점 기준은 가능한데, 내일 특정시점을 잡을 수 있는지 ...?)

<img width="150" alt="image" src="https://user-images.githubusercontent.com/86354361/159310803-c55e9afd-9722-4b75-9a29-4995be8afb40.png">
<img width="150" alt="image" src="https://user-images.githubusercontent.com/86354361/159310867-17f54ed7-8d06-473a-b533-f6aad7c8eb91.png">
<img width="150" alt="image" src="https://user-images.githubusercontent.com/86354361/159310983-572f48c0-9851-4262-b4f6-3828893cdbab.png">


### 22'3/23 - 5일차 개발 일지
1. 회원가입 모두 동의하기 버튼을 통해 모든 버튼 클릭되도록 구현
2. 아이템 상세뷰 구현 시작


### 22'3/24 - 6일차 개발 일지
1. 아이테 상세 뷰 - 상품설명탭 구현 완료
2. Search controller 문서 확인하여 클리 시 view가 팽창하는 issue해결 예정(목표)

<img width="150" alt="image" src="https://user-images.githubusercontent.com/86354361/159532719-f272795c-e3e6-4c2c-af4d-eb6347ceeaa6.png">


잔여이슈 정리
1. 메인화면 - MD의 추천 메뉴를 개발하는데 Tabman라이브러리 활용시 viewcontroller에 viewcontroller를 삽입해야하는 이슈 -> 라이브러리 사용하지 않고 scrollview 구현 예정
2. 메인화면 - 타이머를 통해 일정 시간마다 광고UI(collectionview-collectionviewCell)를 paging 해주는데, paging시 해당 section으로 view가 무조건 이동하는 issue
3. 메인화면 - 정확한 자동 paging을 위해 scrollview delegate method를 활용해야 하는데, 현재 프로젝트에서 `scrollViewDidEndDecelerating` 메서드 활용시 에러 발생(접근제한에러)
5. 검색화면 - SearchController - Searchbar 클리 시 - 뷰가 팽창하는 문제 -> 옵션이 있는지 문서 확인해볼 예정
6. 회원가입화면 - 버튼 선택시 tintColor를 통해 색을 변경해주는데, addTarget: touchUpInside를 통한 이벤트 메서드에서 isSelected시 배경색이 tintColor로 변경되는 현상 발생

추가개발해야하는 UI 정리
1. 장바구니 목록 UI생성 -> 구매 flow
2. 카테고리 - 특정 셀 선택시 나타나는 카테고리뷰
3. 검색 - SearchController수정완료시 검새 전/후 다른 UI른 UI
4. 메인화면 - MD의 추천

### 22'3/25 - 7일차 개발 일지
1. User관련 API사용 - 회원가입
2. User관련 API사용 - 로그인
3. User관련 API사용 - 사용자 조회하여 정보 가져오기
4. User관련 API사용 - 사용자 정보 변경

### 22'3/26 - 8일차 개발 일지
1. Item관련 API사용 - Daily 상품 가져오기
2. Item관련 API사용 - 랜덤 추천 상품 가져오기
3. Item관련 API사용 - MD 추천 상품 가져오기
