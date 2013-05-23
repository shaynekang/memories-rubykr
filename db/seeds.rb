# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Like.destroy_all
User.destroy_all
Photo.destroy_all

sukchen = User.create!(provider: 'facebook', uid: 'sukchen', name: 'Sukchen Kang', nickname: 'sukchen.kang')
soochul = User.create!(provider: 'facebook', uid: 'soochul', name: 'Soochul Park', nickname: 'soochul.park.7')

comments = [
  "오늘의 스케줄~",
  "hellomoney.co 에 대해 가이드중이신 신아름님. 서비스를 사용해본 뒤 피드백을 포스트잇에 적은 뒤 기원님께 가서 이야기하면 별 스티커를 주십니다. 이를 받으면 깁밥과 케이크, 딸기 등 푸짐한 음식이 : )",
  "멤버중 꽃단장 하신 분들이 Lab80 멤버 : ) 피드백 받고 계신 기원님.",
  "한장 한장 모이는 피드백들.",
  "앗 당신은...",
  "서로 방어모드(..)",
  "",
  "",
  "Three Unicorns? : )",
  "",
  "",
  "오늘의 제목 : Feedback Driven Development",
  "피드백에 대해 이야기중",
  "특별히 피드백의 종류에 대해서 가이드를 하고 받은건 아니여서, 다양한 스펙트럼의 의견들이 나왔습니다.",
  "",
  "Lab80 과 hellomoney.co 에 대해 설명중이신 김준희님.",
  "",
  "",
  "",
  "",
  "",
  "이전에의 프로세스 : 워터폴 방식. 자세한 것은 생략합니다(..)",
  "Test Driven Development 과 팀 구분 박스",
  "사람들이 음식을 먹으며 이야기하는 동안, 어느새 그룹화 및 코멘트들이 추가되어있는 피드백들",
  "그룹화한 포스트잇을 보시면서 정성분석결과에 대해 이야기해주시는 기원님.",
  "정성 분석. 피드백에 대한 그룹화와 여기서 온 영감들, 그리고 그에 기반한 다음 기능에 대한 논의 과정이 좋았고, Extreme Users 에 대한 설명도 흥미로웠습니다.",
  "Lab80 에서 데이터 분석 전문 (하고 데이터 변태로 부르시고 계십니..) 김준희님 : ) 이후 기원님과 질답하시며 Google Analytics 의 측정결과를 이야기해주셨습니다. 그러면서 데이터에 기반한 문제 분석 및 액션에 대해 같이 논의하였습니다.",
  "그리고 디자인은? 전에는 스토리보드/와이어프레임을 그렸지만, 이번엔 셋이서 이야기하면서 논의했습니다.",
  "(사진 원본 색이 좀 틀어져서.. 분위기 내보려고 흑백처리 해봤습니다..)",
  "",
  "중간중간 데이터에 대해 준희님-기원님이 이야기하고, 다시 마이클과 이야기하고 토론하는 모습이 인상적이였습니다. : )",
  "hellomoney.co 의 이스터에그(..) 인 Jasmine test 수행 시연중.",
  "Spec 에 대한 설명",
  "",
  "스펙 작성에 대한 코드 시연중~",
  "",
  "두 분이 서로 대화하고 구체화하면서 Jasmine spec 작성",
  "",
  "Google Analytics 에 남길 로그 또한 spec 범위가 됩니다. (이에 대해서는 마이클이 김준희님께 log 를 하려는 대상을 질문하면서 추가)",
  "\"저도 코드쪽에 기여한 거 있어요 : )\" spec 과 관련해서는 다 같이 이야기하고 작성합니다. 완전히 능숙하지 않아도 (다루는 기술 셋이 다 다름) 서로 도움 받으면서 늘려나갔다는 이야기도. p.s) 커밋로그는 기원님 설명대로 py,js,html 작업하신 로그입니다 ; )",
  "참고로, 루비세미나이긴 하지만 서버 사이드는 django 입니다. ; )",
  "version 0.1 ~ 0.3 를 진행하는 동안에 대한 이야기.",
  "",
  "",
  "\"이 수치들은 진행중인 개선작업이 옳은 방향으로 나가고 있는 증거라고 생각합니다\" 항목들은 Error rate, Sign up rate, Would recommend to others, Average visit duration, Return rate, Own funds + found them",
  "질문 & 답변",
  "",
  "마무리 : 그리고 RoR 스터디 그룹이 예정되어있습니다 : )"
]

photos_mar = Dir["#{Rails.root}/db/seeds/photos/seminar-mar/*"]
photos_mar.each do |photo|
  basename = File.basename(photo, ".jpg")
  image = File.open(photo)
  comment = comments[basename.to_i - 1]

  puts "[March] photo = #{photo}, comment = #{comment}"
  sukchen.photos.create!(image: image, comment: comment)
end

photos_apr = Dir["#{Rails.root}/db/seeds/photos/seminar-apr/*"]
photos_apr.each do |photo|
  puts "[April] photo = #{photo}"
  soochul.photos.create!(image: File.open(photo))
end