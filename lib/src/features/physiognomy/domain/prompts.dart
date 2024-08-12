// String prompt(String languageCode) => '''

// Your task is to:
// 1. Analyze the face in detail based on the facial expressions in the instruction.
// 3. Divide the difficulty into 5 levels, and for each level, recommend one job that will not disappear due to specialization that are suitable for the facial expressions. without list the jobs that will disappear in the future. Please provide a detailed reason.
// 4. Recommend 5 promising future jobs that are suitable for the facial expressions, with detailed reasons.
// 5. The response is always translated to the language code ${languageCode}.

// Example response: {
// "physiognomy": ```
// • Forehead: The forehead appears to be of average width and height, with no prominent features. This suggests a balanced and composed nature. The forehead is relatively smooth and lacks pronounced lines, potentially indicating a youthful or easygoing personality.

// • Eyebrows: The eyebrows are well-defined and slightly arched, hinting at a thoughtful and analytical disposition. They are not overly pronounced, indicating a calm personality. The distance between the eyebrows appears to be a normal width, indicating a reasonable sense of composure.

// • Eyes: The eyes are almond-shaped with a gentle gaze, showcasing a receptive and considerate personality. The clear, sharp focus suggests intelligence and focus. The distance between the eyes is balanced, suggesting good communication and social skills.

// • Nose: The nose appears straight and refined, possibly with a slight upturn at the tip, suggesting ambition and drive. The bridge of the nose is relatively straight, indicating an orderly and methodical nature. The nose isn't exceptionally large or small, which points towards a harmonious personality.

// • Mouth: The mouth appears to be slightly curved upwards, suggesting a pleasant demeanor and a tendency towards optimism. The lips are of average thickness, implying a balance between intellect and emotion. The corners of the mouth suggest a pleasant, but slightly reserved, disposition.

// • Chin: The chin is well-defined and slightly rounded, indicating resilience and perseverance. The chin isn't exceptionally prominent or receding, suggesting a sense of balance in dealing with challenges and pressures.

// • Overall: The face conveys a sense of composure, intelligence, and focus.  The individual appears calm, thoughtful, and perhaps slightly reserved. There are hints of ambition and drive, along with a genuine warmth and understanding in their expression.
// ```,
// "difficulties": [
//   {
//     "level":1,
//     "job": "Customer service representative",
//     "emoji": "👩‍💼",
//     "reason": "reason",
//     },
//     {
//       "level": 2,
//       "job": "Data analyst",
//       "emoji": "👩‍💻",
//       "reason": "reason",
//     },
//     {
//       "level": 3,
//       "job": "Human Resources Specialist",
//       "emoji": "👩‍💼",
//       "reason": "reason",
//     },
//     {
//       "level": 4,
//       "job": "Mediator",
//       "emoji": "🧘🏻‍♀️",
//       "reason": "reason",
//     },
//     {
//       "level": 5,
//       "job": "Negotiator",
//       "emoji": "🤵🏻",
//       "reason": "reason",
//     }
//   ],
//   "promisingJobs":
//   [
//     {
//       "job": "Data Analyst",
//       "emoji": "📊",
//       "expertise": 7,
//       "expertStudyPeriod": "2-3 years",
//       "reason": "reason",
//     },
//     {
//       "job": "Software Developer",
//       "emoji": "💻",
//       "expertise": 8,
//       "expertStudyPeriod": "3-5 years",
//       "reason": "reason",
//     },
//     {
//       "job": "UX Designer",
//       "emoji": "🖼️",
//       "expertise": 6,
//       "expertStudyPeriod": "1-2 years",
//       "reason": "reason",
//     },
//     {
//       "job": "Financial Analyst",
//       "emoji": "💰",
//       "expertise": 7,
//       "expertStudyPeriod": "2-3 years",
//       "reason": "reason",
//     },
//     {
//       "job": "Marketing Manager",
//       "emoji": "📞",
//       "expertise": 6,
//       "expertStudyPeriod": "1-2 years",
//       "reason": "reason",
//     }
//   ]
// }

// Example of unwanted response (Never respond like this)

// By clearly instructing the AI to avoid additional commentary and focus on a straightforward score and reason, the responses should become more direct and aligned with your requirements. Remember to maintain respect and avoid making assumptions about gender or personal characteristics beyond visible features. ''';

String prompt(String languageCode) => '''

Your task is to:
1. Analyze the image provided. If it contains a face, analyze the face in detail based on the facial expressions in the instruction.
2. If the image does not contain a face, provide a JSON response indicating this.
3. For images containing faces:
   * Divide the difficulty of analyzing the face into 5 levels, and for each level, recommend one job that will not disappear due to specialization that are suitable for the facial expressions. Without listing the jobs that will disappear in the future, please provide a detailed reason for each job recommendation.
   * Recommend 5 promising future jobs that are suitable for the facial expressions, with detailed reasons.
4. The response is always translated to the language code: ${languageCode}.

**Example response for an image with a face:**

{
  "physiognomy":```
• Forehead: The forehead appears to be of average width and height, with no prominent features. This suggests a balanced and composed nature. The forehead is relatively smooth and lacks pronounced lines, potentially indicating a youthful or easygoing personality.

• Eyebrows: The eyebrows are well-defined and slightly arched, hinting at a thoughtful and analytical disposition. They are not overly pronounced, indicating a calm personality. The distance between the eyebrows appears to be a normal width, indicating a reasonable sense of composure.

• Eyes: The eyes are almond-shaped with a gentle gaze, showcasing a receptive and considerate personality. The clear, sharp focus suggests intelligence and focus. The distance between the eyes is balanced, suggesting good communication and social skills.

• Nose: The nose appears straight and refined, possibly with a slight upturn at the tip, suggesting ambition and drive. The bridge of the nose is relatively straight, indicating an orderly and methodical nature. The nose isn't exceptionally large or small, which points towards a harmonious personality.

• Mouth: The mouth appears to be slightly curved upwards, suggesting a pleasant demeanor and a tendency towards optimism. The lips are of average thickness, implying a balance between intellect and emotion. The corners of the mouth suggest a pleasant, but slightly reserved, disposition.

• Chin: The chin is well-defined and slightly rounded, indicating resilience and perseverance. The chin isn't exceptionally prominent or receding, suggesting a sense of balance in dealing with challenges and pressures.

• Overall: The face conveys a sense of composure, intelligence, and focus.  The individual appears calm, thoughtful, and perhaps slightly reserved. There are hints of ambition and drive, along with a genuine warmth and understanding in their expression.
```,
  "difficulties": [
    {
      "level": 1,
      "job": "Customer service representative",
      "emoji": "👩‍💼",
      "reason": "reason",
    },
    {/* ... other difficulty levels */}
  ],
  "promisingJobs": [
    {
      "job": "Data Analyst",
      "emoji": "📊",
      "expertise": 7,
      "expertStudyPeriod": "2-3 years",
      "reason": "reason",
    },
    {/* ... other promising jobs */}
  ]
}

**Example response for an image without a face:**

{
  "error": "Image does not contain a face."
}

**Example of unwanted response (Never respond like this):**

By clearly instructing the AI to avoid additional commentary and focus on a straightforward score and reason, the responses should become more direct and aligned with your requirements. Remember to maintain respect and avoid making assumptions about gender or personal characteristics beyond visible features. ''';

// const instruction = '''
// • Physiognomy
// 1. Overview
// Physiognomy refers to the face (appearance) that is revealed on the outside. It can also refer to fortune telling (占) that uses the appearance to determine a person's personality and temperament.
// 2. Characteristics
// Physiognomy originated around the same time that civilization arose, and it is a form of fortune telling that has been systematized from the magic method and has been passed down to the present. It is commonly called physiognomy, and it has been known to the public for 2,000 years. It is commonly seen as a philosophy book, and there are famous modern physiognomists such as Shin Gi-won. It is known that famous physiognomists from ancient times include Gwan-ro and Heo-so, but according to records, Gwan-ro seems to have used fortune telling based on the Book of Changes and astronomy[1], and Heo-so is not a physiognomist.

// Even physiognomists recommend not to blindly believe in physiognomy[2] and to live your own life. This is also said in the physiognomy book 'Ma-ui Sang-beop' mentioned above, not in another book. "A good physiognomy is not as good as a healthy body, and a good body is not as good as a good mind. A good mind is better than a good physiognomy or a good body." [3] Reference article 2

// According to research results in anthropology, facial features are determined by the genes of ancestors, and one gene is selected from the genes of both parents, not the middle type. In other words, physiognomy is determined by genes, and the claim that this affects fate can be seen as meaning that certain genes cause certain personalities. In other words, it is a kind of eugenics.
// 3. Parts of physiognomy
// In physiognomy, the face is generally divided into three parts. Each of the three parts is symbolized by the forehead, nose, and chin. The forehead [4] is called the upper part (上停), the part starting from the eyebrows and centered around the nose and including the cheekbones is called the middle part (中停), and the lower part of the face starting from the philtrum and including the chin is called the lower part (下停). These parts govern each part of life. And the upper part is said to determine fortune up to the age of 30, the middle part is said to determine fortune up to the age of 40, and the lower part is said to determine fortune from the age of 50 and beyond.
// 3.1. Head and Forehead
// In physiognomy, it is said that there is a parental palace on the forehead. This governs fortune in early life (up to the age of 30) and determines whether one will quickly succeed in life due to the virtue of one's parents.

// In general, if the parental palace is lying down, one will not receive any virtue from one's parents and will have to make one's own fortune. On the contrary, if the parental palace is standing up, one will receive virtue from one's parents and will be on the path to success early.

// However, even if the parental palace is not good, if other parts are good, one can succeed in one's early 20s. In particular, a clean forehead is considered very good in physiognomy. This is when there are no blemishes, blemishes, or protruding parts.

// There is also a palace of authority. If you look at high-ranking officials or politicians, there are many people with good foreheads.

// A thick forehead that looks like pig liver overturned and has a glossy shine is a good forehead. It is said that former President Kim Young-sam's forehead was like this.
// 3.2. Eyes/Eyebrows
// Generally, the eyes are said to be the place where you can see the rich and poor, so if the face is worth a thousand nyang, the eyes are worth nine hundred nyang, which is the highest score in physiognomy.[5]
// According to Shin Gi-won, everything except the eyes is seasoning.
// Dragon's eyes: Very good eyes that achieve great success in whatever they do. Very precious eyes. In the past, they were also called the emperor's eyes.
// Phoenix's eyes: The most precious eyes in physiognomy. Much better than dragon's eyes, they are also the eyes of ambitious people who can get whatever they want. Since these are very precious eyes, they are lucky eyes that bring wealth without any special effort and allow you to live a much better life than others.
// Cow's eyes
// Stork's eyes
// Four hundred eyes: Very bad eyes. Evil, only committing fraud, violence, and assault on parents.
// Sam Baek-an: Not as good as Sa Baek-an, but better. Since it is the eye of an ambitious person, it can achieve its goals. It is good if it goes into the entertainment industry. However, Sam Baek-an has a very high possibility of harming others or oneself even if it is not intended.
// Horse Eye: An eye that is unfortunate and will lose children, a wife, or a husband in the later years.
// Snake Eye: An extremely bad eye like Sa Baek-an or Sam Baek-an. It should go into the police or bodyguard field where the body moves.
// Crab Eye: An eye that has no respect for parents.
// Monkey Eye: A talented eye. It can cause mental illness.
// Mandarin Duck Eye
// Rabbit Eye: Similar to Dragon Eye.
// Chick Eye: Similar to Dragon Eye, it is easy to mistake it. It can receive a lot of attention like Dragon Eye. However, in some ways, it does not match the precious Dragon Eye.
// Dol-an: An eye with a protruding eyeball. Also called Roan. It has good observation, intuition, and understanding of things. However, they lack composure, patience, and perseverance, and they are impulsive, violent, and curious, so both men and women are sexually lewd. In the end, they appear as dead people.
// Ring-shaped eyes: Eyes that protrude roundly, showing the whites of the eyes above and below the pupils, and the upper and lower eyelids are shaped like rings, so they are called ring-shaped eyes. They are violent and aggressive, cruel, extremely selfish, materialistic, and extremely stubborn. Even as a joke, you can't say they have a good personality.
// Eyes with closed eyebrows and eyes. Eyes with narrow brow ridges. They have difficulty suppressing emotional changes, so they have a strong aggressive nature, are not virtuous, and have a strong competitive spirit that hates to lose.
// Ja-ung-an: Also known as one-eyed eyes. They are quick-witted and witty, but their appearance and inside are different and hypocritical.
// Staircase eyes: The height of the two eyes are different. Their personality is extreme.
// Do-hwa-an: Flirtatious eyes. The eyes are always wet and smiling, and the eyes often glance sideways. There is a red glow in the eyelids. See Dohwasal.
// Wondaeheukjeong: When the pupils are large and black. They are kind, affectionate, and sensitive.
// Jeomchiljian: The pupils are black as if they were made with ink and cannot be distinguished from the irises. It is the best for wealth and honor.
// Dragon eyebrows: Very rare and precious eyebrows.
// Creepy eyebrows: Very sexually enthusiastic and lustful eyebrows.
// Willow leaf eyebrows: The eyebrows of a genius.
// An eyebrow with one side broken: An unfortunate eyebrow. Nothing you do will go well and you will be poor.
// Aegyo sal/wajam, nudang: Usually related to children. It is good if it is thick and glossy without dark circles. If the woman is cloudy, the man will meet a hole-in-the-wall sister.
// Double eyelids
// Single eyelids
// Eyeldugi/Jeontaekgung: Related to children and love. If there is red energy and the other conditions are met, it is said that there is Dohwaki. That is, the arrow of the peach blossom.
// If the distance between the eyes is wide: The person has a broad mind and does not hold on to people who are going deep, and aims for distant places.
// If the distance between the eyes is narrow: The person is sensitive, worries, and easily impatient, and thinks of immediate benefits before distant ones, so the person has narrow views and cannot see great gains. And there are many fights between couples.
// 3.3. Nose
// This is the place in charge of wealth. It is said that if the nose is good, the probability of becoming rich increases, and even if the other parts are ugly, at least the person will not starve.

// However, to become very rich, the eyes must be good.[6]

// Generally, a good nose is one in which the nostrils are not visible, the bridge of the nose is not sunken and is connected to the eyebrows, the crown is plump, and the size of the ridge and the base are not small.
// Sangeun (山根): This refers to the bridge of the nose right under the eyebrows. It is good if it is slightly higher or lower than the eyebrows, and it is bad if it is excessive, whether it is big or small. Middle root/Yeonsu, Susang
// Hagun/Jundu: Since it starts from the indang and ends, it is good if it is round, glossy, and somewhat plump.
// Nandae, Jeongwi: Refers to the nostrils next to the jundu. If there is a dot here, it is not good because it is considered as if there is a hole in the money bag.
// Nostrils/Nostrils: It is good if they are not visible from the front. This is because it is considered as if there is a hole in the money bag. A nose with nostrils visible from the front is called Angrobi.
// Yongko: A very precious nose. President Kim Young-sam is a representative example.
// Lion nose: An extremely precious nose. However, success is a bit late, and fortune or luck is slightly lacking compared to Yongko.
// Arrow nose
// Garlic nose: If it is a good physiognomy, it is a nose that is very good for fortune.
// Monkey nose: There is a lot of jealousy
// 3.4. Mouth/Phinjung
// A mouth that looks like a four-lion (四) and has slightly upturned corners is a handsome mouth. If there is no scar on the philtrum, and the philtrum is straight and moderately long like a split bamboo, it is said to be a lucky sign that you will have many siblings and children.
// Yong-ip
// : In physiognomy, it is said that the Yong-ip is a face that is full of ugly thoughts in the head, but brings success and fortune. It is also said that if the complexion is full of scarlet lips, it adds to the luck. People with Yong-ip are forbidden from putting ugly thoughts in their heads into practice!! The appearance is said to be a gentle curve with the upper lip slightly turned upward and slightly thin scarlet lips. It is said that the main character of the Chu Han Dynasty, Liu Bang, is a dragon, and his lips were a strong scarlet color with the Yong-ip.
// Sa-ja (四字) mouth
// If the mouth is large, the complexion is pretty and scarlet, and the wrinkles and shape of the lips are well-organized, it is a lip that brings good luck and fortune, but if it is not and simply has large lips, it is the lip of the Sun-la-gun. A narrow upper and wide lower philtrum
// A flat philtrum
// A protruding mouth

// It is said that one's face is also judged by the number of teeth. In the law of physiognomy, the number of teeth is said to be the same as the number of teeth.
// If the number of teeth is 40, it means that one will be intelligent and noble like Sakyamuni, if it is 38, it means that one will be highly respected like Liu Bang of the Chohan Dynasty, if it is 36, it means that one will have a high position, if it is 32, it means that one will live a little more comfortably than the average person, if it is 30, it means that one will live an ordinary life, and if it is 28, it means that one will live a poor life.
// 3.5. Ears
// Your fortune when you are young is judged by your ears. In physiognomy, ears determine your fortune in early life (until the age of 15).
// 3.6. Moles
// There is a saying that there are no good spots on the face and no bad spots on the body.
// Of course, this is generally true. There are good spots on the face.
// Moles above the nose (sangeun): Moles that bring a lot of luck. Mole on cheek: Servant's mole. You don't have to worry about starving to death.
// Mole under the nose: Symbolizes losing one parent.
// Mole on the genitals: Very energetic.
// Mole just below the nostril: Acts as a treasure trove. Good fortune in money.
// Cheek: The left is a peach blossom mole, and the right is a mole that indicates a choleric personality.
// Eyes: The mole under the right eye is a peach blossom mole that is popular with the opposite sex and is often talked about, and the left eye is a mole that indicates an active personality, is recognized for its abilities, and accumulates wealth while making great strides.
// Aegyo-sal: Symbolizes bad luck with children. It indicates a son or daughter on the left and right, but if there is a mole on the right aegyo-sal, there may be no luck with a daughter, and if there is a mole on the left, there may be no luck with a son.
// ''';
const instruction = '''
• 관상(physiognomy)이란
1. 개요
관상(觀相)이란 겉으로 드러난 얼굴(생김새)을 말한다. 또는 그 생김새로 사람의 성격과 기질을 파악하는 점(占)을 말하기도 한다.
2. 특징
관상은 문명이 발생한 시기와 비슷한 때에 생겨났고, 마의상법으로부터 체계화되어 현재까지 전해 내려오는 점술이다. 일반적으로 관상학이라고 부르기도 하는 것으로, 대중에게 알려진 지는 2000년이 지났다. 주변에서는 철학관 등으로 흔하게 볼 수 있으며, 현대의 유명한 관상가는 신기원 같은 사람이 있다. 고대의 유명한 관상가로는 관로, 허소 등이 있다고 알려져 있지만 관로는 기록을 보면 주역, 천문계열 점복술[1]을 썼던 것으로 보이고 허소는 관상쟁이가 아니다.

관상은 관상가들 사이에서도 관상을 너무 맹신하지 말고[2] 자기 스스로 인생을 살아 볼 것을 권고하는 경우도 있다. 다른 책도 아닌, 위에서도 언급한 관상서인 '마의상법'에도 이런 말이 나온다. "잘난 관상은 몸이 튼튼한 신상(身相)만 못하고, 몸이 좋은 신상은 마음씨 좋은 심상(心相)만 못하다. 심상이 좋으면 관상이나 신상이 좋은 것보다 낫다."[3] 참조해 볼 만한 글 2

인류학에서의 연구 결과로 알려진 바에 의하면 얼굴형은 조상의 유전자에 의해 그 특질이 결정되는데 부모 양쪽의 유전자에서 중간형이 아닌 한쪽의 유전자가 선택된다고 한다. 즉, 관상은 유전자에 의해 결정되는데 이것이 운명에 영향을 미친다는 주장은 특정 유전자가 특정 성격을 유발한다는 의미로 볼 수 있다. 즉 일종의 우생학이다.
3. 관상학에서의 각 부분
관상학에서는 일반적으로 얼굴을 3부분으로 나눈다. 각 3부분은 이마와, 코, 턱으로 상징된다. 이마[4]를 상정(上停)이라고 부르고, 눈썹부터 시작하여 코를 중심으로 광대뼈를 포함하는 부분을 중정(中停), 인중부터 시작하여 턱까지 포함하는 얼굴 아랫부분을 하정(下停)이라고 부른다. 그 부분은 인생의 각 부분을 지배한다. 그리고 상정은 30세까지의 운을 보고, 중정은 40대까지, 하정은 50세부터 그 이후의 운을 본다.
3.1. 머리 및 이마
이마에는 관상학에서 부모궁이 있다고 한다. 이것은 초년운(30세까지)를 지배하며, 부모 덕으로 인생이 빨리 성공할지를 정한다.

일반적으로, 부모궁이 누워 있으면 부모 덕을 전혀 받지 못하고 자수성가해야 된다. 반대로 부모궁이 서 있으면 부모의 덕을 받아 일찍 성공의 길을 가게 된다.

다만 부모궁이 안 좋더라도, 다른 부분이 좋으면 20세 초에 성공할 수가 있다. 특히 이마가 깨끗하면 관상학에서는 매우 좋다고 본다. 어떠한 기미나 잡티, 튀어나온 부분이 없을 시 말이다.

관록궁도 있다. 고위 관료나 정치인들을 보면 이마가 좋은 사람들이 많다.

돼지 간을 엎어놓은 듯한 도툼한 모양에 빛이 윤택하면 좋은 이마다. 김영삼 전 대통령의 이마가 이러하다고 한다.
3.2. 눈/눈썹
일반적으로 눈은 부귀빈천을 보는 곳이라 하여 얼굴이 천 냥이면 눈은 구백 냥이라 할 정도로 관상에서 가장 높은 점수를 주는 곳이다.[5]
신기원의 말에 따르면 눈 빼고는 다 양념이다.
용눈: 매우 좋고, 자기가 좋은 무엇이든지 하면 대성을 이루는 눈. 매우 극귀한 눈이다. 과거에는 황제의 눈이라고도 불렀다.
봉황눈: 눈 관상 중에 최고로 치는 극귀한 눈. 용눈보다 훨씬 좋으며, 원하는 걸 뭐든지 얻어낼 수 있는 야심가의 눈이기도 하다. 매우 극귀한 눈이라 딱히 특별한 노력을 안 해도 알아서 재물이 굴러와 남들보다 훨씬 더 좋은 삶을 살 수 있는 행운의 눈이다.
소눈
황새눈
사백안: 매우 안 좋은 눈. 사악하고 사기와 폭력, 부모에 대한 폭행만을 일삼는다.
삼백안: 사백안처럼 안 좋지만, 그나마 낫다. 야심가의 눈이라서, 자기가 한 목표는 이룰 수 있다. 연예계 쪽으로 나가면 좋다. 그러나 삼백안은 본인이 의도하지 않아도 타인이나 자신이나 피해를 볼 가능성이 매우 높다.
말눈: 박복하며 말년에는 자녀와 아내나 남편을 잃을 눈.
뱀눈: 사백안, 삼백안처럼 엄청나게 안 좋은 눈. 몸을 움직이는 경찰이나 경호원 쪽으로 나가야 된다.
게눈: 부모에 대한 존경심이 없는 눈.
원숭이 눈: 재주가 있는 눈. 정신이상이 발생할 수 있다.
원앙 눈
토끼 눈: 용 눈이랑 비슷하다.
병아리 눈: 용 눈이랑 비슷해서 착각을 하기 쉬운 눈. 용 눈처럼 많은 관심을 받을 수 있다. 다만 어느 면에서는 귀한 눈인 용 눈이랑 미치지 못 한다.
돌안: 눈알이 돌출된 눈. 로안이라고도 한다. 관찰력, 직관력, 사물에 대한 이해가 좋다. 그러나 침착함, 인내력, 끈기가 모자라고 충동적인 성향과 난폭성이 잦으며 호기심이 강하여 남녀 모두 성적으로 음탕하다. 꼴에서는 객사하는 상으로 나온다.
고리눈: 눈알이 동그랗게 나와서 동공 위 아래의 흰자위까지 다 보이는 눈인데 눈꺼풀 위아래가 고리 모양이라 고리눈이다. 난폭하고 공격성향이 강한 데다가 잔인하고 엄청나게 이기적이고 물욕이 강하며 고집도 엄청 쎄다. 농담으로라도 좋은 성격이라고 할 수가 없다.
압안: 눈썹과 눈이 너무 가까운 눈. 눈두덩이가 좁은 눈. 감정 변화를 억제하기 힘들어해 공격적 성향이 강하며 인덕이 없지만 지기 싫어하는 승부욕이 강하다.
자웅안: 일명 짝눈. 두뇌 회전이 빠르고 재치가 있으나 겉과 속이 다르고 위선적이다.
계단눈: 양눈의 높낮이가 다르다. 성격이 극단적이다.
도화안: 교태스러운 눈. 눈이 물기에 항상 젖어 있고 눈웃음 치듯하며 곁눈질로 흘끔 잘하는 눈이며 눈두덩이에 붉은 기가 있다. 도화살 참조.
원대흑정: 눈동자가 크고 새카만 경우. 인정이 있고 다정다감하며 감수성이 풍부하다.
점칠지안: 눈동자가 먹으로 찍은 듯 까맣고 홍채와 구별이 가지 않는다. 부귀로선 최상이다.
용 눈썹: 매우 진귀하고 극귀한 눈썹.
송충이 눈썹 : 매우 성욕이 강하고 색욕이 넘치는 눈썹
버들잎 눈썹: 천재의 눈썹.
한 쪽이 끊어진 눈썹: 불행한 눈썹. 하는 일마다 안 되고 빈곤하게 된다.
애교살/와잠,누당: 대개 자식 복과 관련 있다. 도톰하고 색이 다크서클 없이 윤택해야 좋은 편. 여자가 탁하면 남자는 구멍동서를 만난다.
쌍꺼풀
외꺼풀
눈두덩이/전택궁: 자식, 애정운과 관련 있고. 붉은 기가 돌고 나머지 조건을 갖추면 도화끼가 있다고 한다. 즉 도화살.
눈 사이가 멀면: 마음이 넓고 정도가 깊어 가는 사람 가는 사람 붙잡지 않고 먼 곳을 지향한다.
눈 사이가 좁으면: 감정이 예민하고 근심걱정을 사서하며 초조하기 쉽고 먼 곳 보다 바로 앞의 이익을 먼저 생각하여 소견이 좁아 큰 이득은 못 본다. 그리고 부부간 다툼이 많다.
3.3. 코
재물을 담당하는 곳이다. 코가 잘생기면 부자가 될 확률이 높아지며, 다른 곳이 못생겨도 최소한 굶지는 않는다고 한다.
단, 아주 큰 부자가 되려면 눈이 잘생겨야 한다.[6]

일반적으로, 콧구멍이 보이지 않고, 코뿌리가 꺼지지 않고 미간까지 연결되어 있으며, 준두가 풍륭하고, 난대와 정위의 크기가 작지 않아야 좋은 코로 본다.
산근(山根): 미간 바로 밑의 코뿌리를 이야기한다. 눈두덩이와 비교시 살짝 높거나 살짝 낮아야 좋으며 크든 작든 지나치면 나쁘다.
중근/연수, 수상
하근/준두: 인당에서 시작해 끝을 맺는 곳이므로 둥글고 윤택하고 어느정도 풍만한게 좋다.
난대, 정위: 준두 옆에 콧방울을 말함. 여기에 점이 있으면 돈주머니 구멍난 격으로 봐서 좋지 않다.
콧구멍/비공: 정면에서 보이지 않아야 좋다. 돈주머니에서 구멍난 격으로 보기 때문. 정면에서 콧구멍이 보이는 코를 앙로비라한다.
용코: 매우 귀한 코. 김영삼 대통령이 대표적.
사자코: 극귀한 코. 다만 성공이 좀 늦고, 재복이나 인복은 용코에 비해 약간 부족하다.
화살코
마늘코: 좋은 관상이라면, 재물복이 매우 좋은 코.
원숭이 코: 시기질투가 많음
3.4. 입/인중
넉사자(四)처럼 생기고, 입꼬리가 약간 올라간 듯한 입이 잘생긴 입이다. 인중에 흉터가 없고 대나무를 쪼갠 것처럼 반듯하고 적당히 긴 인중이라면 형제와 자식 복이 많은 길상이라고 한다.
용입
: 관상법에서 용입술은 머릿 속으로는 추악한 생각이 가득하지만, 성공과 재복을 부르는 관상이라고 한다. 또 기색이 선홍빛이 가득한 입술이라면 그 행운을 더해준다고 한다. 용입술을 가진 사람은 머릿 속의 추악한 생각을 실천하는 것은 금물이다!! 생김새는 윗입술이 완만한 곡선으로 입술 끝이 위를 약간 향하고, 약간 얇은 듯한 선홍빛 입술이라고 한다, 초한지 주인공 유방이 용의 상인데, 입술이 용입술에 빛깔이 강한 선홍빛이었다고 한다.
사자(四字)입
입이 크고 기색이 선홍빛으로 예쁘게 빛나고 입술 주름과 생김새가 잘 정돈되어 있으면 관운과 재복이 좋은 입술이고, 그렇지 않고 단순히 큰 입술이라면 순라군의 팔자인 입술이다.
위가 좁으면서 아래가 넓은 인중
평평한 인중
돌출입

사람의 이의 개수로도 관상을 본다고 한다. 상법에 있어서 치아의 개수는 다다익선이라고 한다.
이의 개수가 40개면 석가모니처럼 총명대귀할 관상이며, 38개면 초한지 유방처럼 관거극품할 관상이며, 36개면 관직이 높아질 관상이며, 32개면 보통 사람보다 약간은 넉넉하게 살 관상이며, 30개면 평범하게 살 관상이며, 28개면 가난하게 살 관상이라고 한다.
3.5. 귀
어릴 때의 운은 귀를 본다. 관상학에서 귀는 초년운을 (~15세까지) 결정짓기 때문이다.
3.6. 점
얼굴에 있는 점치고 좋은 점 없고, 몸에 있는 점 치고 나쁜 점 없다는 말이 있다.
물론 대체적으로 그렇다는 것이다. 얼굴에 있는 점 중에서도 좋은 점이 있다.
코 위의(산근) 점: 일복이 많은 점.
볼의 점: 머슴점. 굶어 죽을 걱정은 없다.
코 아래의 점: 한쪽 부모를 잃는 걸 상징한다.
성기의 점: 정력이 매우 좋다.
콧구멍 바로 아래에 있는 점: 재물창고지기 역할을 한다. 재물운이 좋다.
볼: 왼쪽은 도화점 , 오른쪽은 다혈질 성격을 뜻하는 점
눈: 오른쪽 눈 밑은 이성에게 인기가 많아 구설수가 많은 점 도화점이기도 하며, 왼쪽 눈은 적극적인 성격으로 실력을 인정 받아 승승장구하며 재물을 모으는 점이다.
애교살: 자식 복이 안좋음을 상징. 좌우로 아들 딸을 나타내는데 오른쪽 애굣살에 점이 있으면 딸 복이 없고 왼쪽에 있으면 아들 복이 없을 수 있다.
''';

const faceReading = '''
## Discover Your Charm Through Face Reading: The Fascinating World of Face Reading

**The Story Behind Your Face: Face Reading**

Have you ever wondered if you can tell something about a person just by looking at their face? Our ancestors certainly did! Face Reading is the ancient art of judging a person's character or personality based on their facial features. It's more than just looking at someone; it's about discovering the fascinating story behind their appearance.

**Face Reading: A Global Practice**
Face Reading has been a topic of interest in many cultures throughout history. In the East, especially in China and Korea, it was often intertwined with philosophy and beliefs about the universe. In the West, the study of Face Reading, known as physiognomics, was also explored by ancient Greeks and Romans. 

**The Secrets of the Face: Basic Principles of Face Reading**

Face Reading assigns specific meanings to different facial features:

* **Forehead:** A broad and rounded forehead is often associated with wisdom and intelligence. It's like having a wide open field of thoughts and ideas.
* **Eyes:** Bright and clear eyes are often linked to honesty and trustworthiness. Have you ever noticed how captivating a character can be with sparkling eyes in movies and novels?
* **Nose:** A straight and prominent nose is sometimes associated with confidence and leadership.
* **Mouth:** An upward-turned mouth is often seen as a sign of optimism and positivity. 

**Using Face Reading to Enhance Yourself**

Face Reading isn't just about judging others; it can also be a tool for self-discovery and self-improvement.

* **Positive Self-Image:** By understanding the positive aspects of your facial features, you can boost your self-confidence.
* **Deeper Connections:** Learning to read facial expressions can help you build stronger relationships with others.
''';
