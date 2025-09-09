**DIVE2025 - 주택도시보증공사**
# 데이터 분석 등을 통한 임대차계약 위험 예측 및 예방 서비스 모델 제안

### 1. 전세 사기 예측 모델을 활용한 위험성 진단
대위변제 여부를 기준으로 분석, 학습하여 위험도를 예측해주는 모델로 위험도 출력과 함께 GPT API를 활용하여 예측의 근거를 설명

https://github.com/junyoungnnn/DIVE2025_Predict_MODEL  
https://github.com/junyoungnnn/DIVE2025_Explanation_LLM  

### 2. 챗봇
GPT API를 활용한 RAG 기반 LLM 챗봇으로 임대차 계약, 전세 등과 관련된 내용을 더 전문적으로 대답할 수 있도록 구축

https://github.com/junyoungnnn/DIVE2025_LLM_withRAG

### 3. 신탁원부 발급 바로가기
신탁원부에는 해당 추택을 세입자가 전세, 월세 계약할 수 있는지 여부가 나타나 있어 신탁원부에 대한 안내와 링크를 추가

### 4. 재개발/재건축 지역 표시
재개발/재건축 지역은 권리 관계가 복잡하고, 전세금 회수 지연, 보증보험 가입 제약이 생길 수 있어 표시를 지도에 추가

### .env.sample
```
CHAT_BOT_SERVER_URL=챗봇_서버_주소
PREDICT_MODEL_SERVER_URL=예측_모델_서버_주소
```
1. .env.sample 을 .env 로 변경
2. 본인 키, 주소 넣기

**아이콘 출처**
```
https://www.flaticon.com/kr/free-icons/-
메뉴 아이콘 제작자: ariefstudio - Flaticon
홈 개요 아이콘 제작자: Grand Iconic - Flaticon
위치 아이콘 제작자: Andrean Prabowo - Flaticon
Designed by Freepik
"https://icons8.com/icon/11642/notification
