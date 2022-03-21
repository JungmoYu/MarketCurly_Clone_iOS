
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



