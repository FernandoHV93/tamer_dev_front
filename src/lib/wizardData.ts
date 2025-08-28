import { type WizardStep as WizardStepType } from '../types/deepWizard'

// Secciones organizadas temáticamente
const wizardSteps: WizardStepType[] = [
  // ==================== SECCIÓN 1: AUDIENCE DISCOVERY ====================
  {
    id: 1,
    title: "General Audience Data",
    description: "Let's understand who your audience is",
    progress: 5,
    section: "audience",
    theme: {
      primary: "blue",
      secondary: "blue",
      gradient: "from-blue-500 to-blue-600"
    },
    fields: [
      {
        type: 'select',
        key: 'averageAge',
        label: 'What is the average age of your audience?',
        options: ['Under 18', '18-24', '25-34', '35-44', '45-54', '55-64', '65+'],
        placeholder: 'Select an option',
        required: true,
        tooltip: 'This helps tailor content to the right age group'
      },
      {
        type: 'radio',
        key: 'generation',
        label: 'Which generation does your ideal customer belong to?',
        options: ['Gen Z', 'Millennials', 'Gen X', 'Baby Boomers'],
        required: true,
        tooltip: 'Different generations have different communication preferences'
      },
      {
        type: 'select',
        key: 'predominantGender',
        label: 'What is the predominant gender of your audience?',
        options: ['Male', 'Female', 'Non-binary', 'Other', 'Prefer not to say'],
        placeholder: 'Select an option',
        required: true,
        tooltip: 'Understanding gender demographics helps personalize messaging'
      },
      {
        type: 'select',
        key: 'educationLevel',
        label: 'What is the educational level of your audience?',
        options: ['High School', 'Some College', 'Bachelor\'s Degree', 'Master\'s Degree', 'Doctorate', 'Other'],
        placeholder: 'Select an option',
        required: true,
        tooltip: 'Education level can influence communication style and vocabulary'
      },
      {
        type: 'text',
        key: 'primaryOccupation',
        label: 'What is the primary occupation of your audience?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Knowing occupations helps understand daily challenges and interests'
      }
    ],
    milestone: true
  },
  {
    id: 2,
    title: "Problems and Desires",
    description: "Understand the challenges and aspirations of your audience",
    progress: 9,
    section: "audience",
    theme: {
      primary: "blue",
      secondary: "blue",
      gradient: "from-blue-500 to-blue-600"
    },
    fields: [
      {
        type: 'textarea',
        key: 'mainProblems',
        label: 'What are the main problems your audience faces?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Identify pain points your brand can help solve'
      },
      {
        type: 'textarea',
        key: 'primaryDesires',
        label: 'What are the primary desires of your audience?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Understand what motivates and inspires your audience'
      }
    ]
  },
  {
    id: 3,
    title: "Motivations and Values",
    description: "Explore what drives your audience",
    progress: 14,
    section: "audience",
    theme: {
      primary: "blue",
      secondary: "blue",
      gradient: "from-blue-500 to-blue-600"
    },
    fields: [
      {
        type: 'textarea',
        key: 'purchasingMotivations',
        label: 'What motivates your audience to make purchasing decisions?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Understanding buying triggers helps craft persuasive messaging'
      }
    ]
  },
  {
    id: 8,
    title: "Audience Expectations",
    description: "Understand what your audience expects",
    progress: 36,
    section: "audience",
    theme: {
      primary: "blue",
      secondary: "blue",
      gradient: "from-blue-500 to-blue-600"
    },
    fields: [
      {
        type: 'textarea',
        key: 'brandExpectations',
        label: 'What expectations does your audience have of the brands they choose?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Understand the standards your audience holds for brands they support'
      }
    ]
  },

  // ==================== SECCIÓN 2: BEHAVIOR PATTERNS ====================
  {
    id: 4,
    title: "User Behavioral Patterns",
    description: "Analyze audience behavior",
    progress: 18,
    section: "behavior",
    theme: {
      primary: "green",
      secondary: "green",
      gradient: "from-green-500 to-green-600"
    },
    fields: [
      {
        type: 'textarea',
        key: 'behavioralPatterns',
        label: 'What are your audience\'s behavioral patterns?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Identify daily routines, habits, and online behaviors'
      }
    ]
  },
  {
    id: 6,
    title: "Content Consumption",
    description: "Understand content preferences",
    progress: 27,
    section: "behavior",
    theme: {
      primary: "green",
      secondary: "green",
      gradient: "from-green-500 to-green-600"
    },
    fields: [
      {
        type: 'textarea',
        key: 'contentTypes',
        label: 'What type of content does your audience consume?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Identify preferred content formats (blogs, videos, podcasts, etc.)'
      },
      {
        type: 'checkbox',
        key: 'contentPlatforms',
        label: 'Where does your audience consume this content?',
        options: ['Instagram', 'Blogs', 'TikTok', 'Newsletters', 'Others'],
        required: true,
        tooltip: 'Knowing platforms helps focus content distribution efforts'
      }
    ]
  },
  {
    id: 15,
    title: "Desired User Behavior",
    description: "Define how you want users to interact with your brand",
    progress: 68,
    section: "behavior",
    theme: {
      primary: "green",
      secondary: "green",
      gradient: "from-green-500 to-green-600"
    },
    fields: [
      {
        type: 'textarea',
        key: 'honestPerception',
        label: 'How can you ensure your brand is perceived as honest?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Build trust through transparent and authentic communication'
      },
      {
        type: 'textarea',
        key: 'friendlyElements',
        label: 'What elements make a brand friendly to your audience?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Identify characteristics that create approachability and warmth'
      },
      {
        type: 'textarea',
        key: 'valuedCharacteristics',
        label: 'What characteristics do users value most in a brand\'s behavior?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Understand what behavioral traits resonate with your audience'
      }
    ]
  },

  // ==================== SECCIÓN 3: PROBLEMS & FRUSTRATIONS ====================
  {
    id: 5,
    title: "Fears, Frustrations, and Obstacles",
    description: "Understand the challenges your audience faces",
    progress: 23,
    section: "problems",
    theme: {
      primary: "purple",
      secondary: "purple",
      gradient: "from-purple-500 to-purple-600"
    },
    fields: [
      {
        type: 'textarea',
        key: 'mainFears',
        label: 'What are the main fears of your audience?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Addressing fears can build trust and connection'
      },
      {
        type: 'textarea',
        key: 'commonFrustrations',
        label: 'What are the most common frustrations of your audience?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Understanding frustrations helps position your brand as a solution'
      },
      {
        type: 'textarea',
        key: 'audienceObstacles',
        label: 'What obstacles does your audience face?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Identify barriers that prevent your audience from achieving goals'
      }
    ]
  },

  // ==================== SECCIÓN 4: BRAND IDENTITY ====================
  {
    id: 9,
    title: "Competitor Analysis",
    description: "Analyze your competition",
    progress: 41,
    section: "brand",
    theme: {
      primary: "orange",
      secondary: "orange",
      gradient: "from-orange-500 to-orange-600"
    },
    fields: [
      {
        type: 'textarea',
        key: 'competitorCommunication',
        label: 'How do your main competitors communicate?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Analyze competitor messaging to identify gaps and opportunities'
      },
      {
        type: 'select',
        key: 'competitorTone',
        label: 'What tone do your competitors use?',
        options: ['Formal', 'Informal', 'Professional', 'Casual', 'Friendly', 'Authoritative'],
        placeholder: 'Select an option',
        required: true,
        tooltip: 'Understand the competitive landscape of brand voices'
      },
      {
        type: 'checkbox',
        key: 'competitorPersonality',
        label: 'What type of personality do your competitors project?',
        options: ['Reliable', 'Innovative', 'Fun', 'Serious', 'Luxurious', 'Affordable'],
        required: true,
        tooltip: 'Identify personality traits your competitors emphasize'
      },
      {
        type: 'textarea',
        key: 'brandDifferentiation',
        label: 'What makes your brand different from others?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Articulate your unique value proposition and differentiation'
      },
      {
        type: 'textarea',
        key: 'desiredPerception',
        label: 'How do you want your brand to be perceived in comparison to competitors?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Define how you want to stand out in the competitive landscape'
      },
      {
        type: 'textarea',
        key: 'voiceStrategy',
        label: 'Should you adopt a similar voice or differentiate radically? Why?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Strategic decision about positioning relative to competitors'
      }
    ],
    milestone: true
  },
  {
    id: 10,
    title: "Brand Identity",
    description: "Define your brand's core elements",
    progress: 45,
    section: "brand",
    theme: {
      primary: "orange",
      secondary: "orange",
      gradient: "from-orange-500 to-orange-600"
    },
    fields: [
      {
        type: 'textarea',
        key: 'brandVision',
        label: 'What is your brand\'s vision?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'The long-term aspiration and purpose of your brand'
      },
      {
        type: 'textarea',
        key: 'brandMission',
        label: 'What is your brand\'s mission?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'The daily purpose and reason for your brand\'s existence'
      },
      {
        type: 'textarea',
        key: 'coreValues',
        label: 'What are your brand\'s core values?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'The fundamental beliefs that guide your brand\'s behavior'
      },
      {
        type: 'textarea',
        key: 'valuesAlignment',
        label: 'How do these values align with your audience\'s values?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Ensure your values resonate with your target audience'
      },
      {
        type: 'textarea',
        key: 'socialProblem',
        label: 'What social or emotional problem is your brand committed to solving?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'The deeper purpose your brand serves beyond products/services'
      },
      {
        type: 'textarea',
        key: 'brandImpact',
        label: 'How do you want to impact the world or your customers\' lives?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'The positive change your brand aims to create'
      }
    ]
  },
  {
    id: 11,
    title: "Brand Personality",
    description: "Define your brand's character traits",
    progress: 50,
    section: "brand",
    theme: {
      primary: "orange",
      secondary: "orange",
      gradient: "from-orange-500 to-orange-600"
    },
    fields: [
      {
        type: 'select',
        key: 'agePersonality',
        label: 'Is your brand young or mature?',
        options: ['Young', 'Mature', 'Both'],
        placeholder: 'Select an option',
        required: true,
        tooltip: 'The perceived age and energy level of your brand'
      },
      {
        type: 'select',
        key: 'traditionPersonality',
        label: 'Is it traditional or avant-garde?',
        options: ['Traditional', 'Avant-garde', 'Balanced'],
        placeholder: 'Select an option',
        required: true,
        tooltip: 'How your brand approaches innovation and tradition'
      },
      {
        type: 'select',
        key: 'stylePersonality',
        label: 'Is it classic or modern?',
        options: ['Classic', 'Modern', 'Timeless'],
        placeholder: 'Select an option',
        required: true,
        tooltip: 'The aesthetic and stylistic approach of your brand'
      },
      {
        type: 'select',
        key: 'socialPersonality',
        label: 'Is it introverted or extroverted?',
        options: ['Introverted', 'Extroverted', 'Ambivert'],
        placeholder: 'Select an option',
        required: true,
        tooltip: 'How your brand engages with others and the world'
      },
      {
        type: 'select',
        key: 'innovationPersonality',
        label: 'Is it conservative or innovative?',
        options: ['Conservative', 'Innovative', 'Evolutionary'],
        placeholder: 'Select an option',
        required: true,
        tooltip: 'Your brand\'s approach to change and innovation'
      },
      {
        type: 'select',
        key: 'moodPersonality',
        label: 'Is it reflective or playful?',
        options: ['Reflective', 'Playful', 'Both'],
        placeholder: 'Select an option',
        required: true,
        tooltip: 'The emotional tone and mood of your brand'
      },
      {
        type: 'select',
        key: 'conventionPersonality',
        label: 'Is it conventional or rebellious?',
        options: ['Conventional', 'Rebellious', 'Disruptive'],
        placeholder: 'Select an option',
        required: true,
        tooltip: 'How your brand relates to established norms and conventions'
      },
      {
        type: 'select',
        key: 'accessPersonality',
        label: 'Is it exclusive or open?',
        options: ['Exclusive', 'Open', 'Inclusive'],
        placeholder: 'Select an option',
        required: true,
        tooltip: 'The accessibility and inclusivity of your brand'
      },
      {
        type: 'textarea',
        key: 'brandAsPerson',
        label: 'If your brand were a person, how would you describe it?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Personify your brand to make it more relatable and human'
      },
      {
        type: 'textarea',
        key: 'brandAsFamousPerson',
        label: 'If your brand were a famous person, who would it be?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Use celebrity archetypes to define brand personality'
      }
    ]
  },
  {
    id: 12,
    title: "Fundamental Values",
    description: "Define your core brand values",
    progress: 55,
    section: "brand",
    theme: {
      primary: "orange",
      secondary: "orange",
      gradient: "from-orange-500 to-orange-600"
    },
    fields: [
      {
        type: 'textarea',
        key: 'valuesMeaning',
        label: 'What does each value mean for your brand: intelligence, strength, creativity, order, fun, freedom?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Define how abstract values translate to concrete brand behaviors'
      },
      {
        type: 'textarea',
        key: 'valuesPriority',
        label: 'Which of these values are essential and which are secondary?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Establish a hierarchy of values for decision-making'
      },
      {
        type: 'textarea',
        key: 'valuesCommunication',
        label: 'How can you convey these values through communication?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Translate values into actionable communication guidelines'
      }
    ]
  },
  {
    id: 13,
    title: "Brand Archetypes",
    description: "Define your brand's archetypal identity",
    progress: 59,
    section: "brand",
    theme: {
      primary: "orange",
      secondary: "orange",
      gradient: "from-orange-500 to-orange-600"
    },
    fields: [
      {
        type: 'select',
        key: 'brandArchetype',
        label: 'Which brand archetype best reflects your purpose?',
        options: [
          'Innocent', 'Sage', 'Explorer', 'Outlaw', 
          'Magician', 'Hero', 'Lover', 'Jester', 
          'Everyman', 'Caregiver', 'Ruler', 'Creator'
        ],
        placeholder: 'Select an option',
        required: true,
        tooltip: 'Choose an archetype that aligns with your brand\'s core purpose'
      },
      {
        type: 'textarea',
        key: 'archetypeMotivation',
        label: 'What is the main motivation of the chosen archetype, and how does it align with your brand?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Connect archetype motivations to your brand\'s driving forces'
      },
      {
        type: 'textarea',
        key: 'archetypeConnection',
        label: 'How can you use this archetype to connect emotionally with your audience?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Leverage archetypal patterns to create emotional resonance'
      },
      {
        type: 'textarea',
        key: 'desiredEmotions',
        label: 'What emotions do you want your brand to evoke?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Define the specific emotional responses you want to trigger'
      },
      {
        type: 'textarea',
        key: 'archetypeCombination',
        label: 'Can you combine archetypes to make your brand voice more unique? Which ones?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Create a unique brand voice by blending archetypal characteristics'
      }
    ]
  },
  {
    id: 14,
    title: "Brand Dimensions",
    description: "Define your brand's key characteristics",
    progress: 64,
    section: "brand",
    theme: {
      primary: "orange",
      secondary: "orange",
      gradient: "from-orange-500 to-orange-600"
    },
    fields: [
      {
        type: 'textarea',
        key: 'sincerityPerception',
        label: 'How do you want your brand to be perceived in terms of sincerity?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Define the authenticity and genuineness of your brand'
      },
      {
        type: 'textarea',
        key: 'emotionalCharacteristics',
        label: 'What emotional characteristics do you want to convey?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'The emotional qualities and temperament of your brand'
      },
      {
        type: 'textarea',
        key: 'competenceConveyance',
        label: 'How do you want to convey competence?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'How your brand demonstrates expertise and capability'
      },
      {
        type: 'textarea',
        key: 'sophisticationLevel',
        label: 'What level of sophistication do you want to reflect?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'The refinement and elegance of your brand presentation'
      },
      {
        type: 'textarea',
        key: 'robustPerception',
        label: 'Should your brand be perceived as robust or strong? Why?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'The strength and resilience your brand projects'
      }
    ],
    milestone: true
  },

  // ==================== SECCIÓN 5: VOICE & TONE ====================
  {
    id: 7,
    title: "Tone and Language",
    description: "Define your communication style",
    progress: 32,
    section: "voice",
    theme: {
      primary: "red",
      secondary: "red",
      gradient: "from-red-500 to-red-600"
    },
    fields: [
      {
        type: 'textarea',
        key: 'audienceTone',
        label: 'What tone and language does your audience use in daily life? (formality, expressions, style)',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Match your brand\'s tone to your audience\'s natural communication style'
      },
      {
        type: 'textarea',
        key: 'problemDescription',
        label: 'How does your audience describe their problems?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Use the same language your audience uses to describe their challenges'
      },
      {
        type: 'textarea',
        key: 'brandSolution',
        label: 'How would your brand help solve those problems?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Articulate your value proposition using audience-centric language'
      }
    ]
  },
  {
    id: 16,
    title: "Tone and Style",
    description: "Define your brand's voice characteristics",
    progress: 73,
    section: "voice",
    theme: {
      primary: "red",
      secondary: "red",
      gradient: "from-red-500 to-red-600"
    },
    fields: [
      {
        type: 'select',
        key: 'formalityLevel',
        label: 'How formal or informal should your brand tone be?',
        options: ['Very Formal', 'Formal', 'Neutral', 'Informal', 'Very Informal'],
        placeholder: 'Select an option',
        required: true,
        tooltip: 'Set the level of formality for your brand communications'
      },
      {
        type: 'select',
        key: 'seriousnessLevel',
        label: 'How serious or playful should your brand be?',
        options: ['Very Serious', 'Serious', 'Balanced', 'Playful', 'Very Playful'],
        placeholder: 'Select an option',
        required: true,
        tooltip: 'Define the emotional weight and playfulness of your tone'
      },
      {
        type: 'textarea',
        key: 'brandVocabulary',
        label: 'What vocabulary best represents your brand?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Curate a distinctive vocabulary that reflects your brand personality'
      },
      {
        type: 'textarea',
        key: 'sensitiveTopics',
        label: 'How does your brand communicate bad news or sensitive topics?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Establish guidelines for handling difficult communications'
      },
      {
        type: 'textarea',
        key: 'platformTones',
        label: 'What is the appropriate tone for each platform or channel?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Adapt your tone for different communication channels'
      }
    ]
  },
  {
    id: 17,
    title: "Brand Voice Guide",
    description: "Create guidelines for consistent communication",
    progress: 77,
    section: "voice",
    theme: {
      primary: "red",
      secondary: "red",
      gradient: "from-red-500 to-red-600"
    },
    fields: [
      {
        type: 'textarea',
        key: 'brandExpressions',
        label: 'What expressions and words should always be used to represent your brand voice?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Define signature phrases and terminology that embody your brand'
      },
      {
        type: 'textarea',
        key: 'avoidedExpressions',
        label: 'What words or expressions should be avoided?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Identify language that contradicts your brand values'
      },
      {
        type: 'textarea',
        key: 'criticismResponse',
        label: 'How does your brand respond to criticism or unhappy customers?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Establish a consistent approach to handling feedback and complaints'
      },
      {
        type: 'textarea',
        key: 'gratitudeExpression',
        label: 'How does your brand express gratitude or recognition?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Define how your brand shows appreciation and acknowledgment'
      },
      {
        type: 'textarea',
        key: 'mediaDifferences',
        label: 'How does your brand communication differ between digital and print media?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Adapt your voice for different media formats while maintaining consistency'
      }
    ]
  },
  {
    id: 19,
    title: "Brand Storytelling",
    description: "Craft your brand's narrative",
    progress: 86,
    section: "voice",
    theme: {
      primary: "red",
      secondary: "red",
      gradient: "from-red-500 to-red-600"
    },
    fields: [
      {
        type: 'textarea',
        key: 'centralStory',
        label: 'What is the central story of your brand?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Define the core narrative that encapsulates your brand\'s journey and purpose'
      },
      {
        type: 'textarea',
        key: 'narrativeElements',
        label: 'What narrative elements should always be present in your communications?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Identify recurring themes and storytelling elements'
      },
      {
        type: 'textarea',
        key: 'storytellingHumanization',
        label: 'How can you use storytelling to make your brand more human and relatable?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Use storytelling techniques to create emotional connections'
      }
    ]
  },

  // ==================== SECCIÓN 6: IMPLEMENTATION ====================
  {
    id: 18,
    title: "Consistency and Adaptability",
    description: "Ensure consistent brand voice across all channels",
    progress: 82,
    section: "implementation",
    theme: {
      primary: "indigo",
      secondary: "indigo",
      gradient: "from-indigo-500 to-indigo-600"
    },
    fields: [
      {
        type: 'textarea',
        key: 'consistencyEnsurance',
        label: 'How do you ensure the consistency of your brand voice when multiple team members create content?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Establish processes for maintaining voice consistency across teams'
      },
      {
        type: 'textarea',
        key: 'consistencyGuidelines',
        label: 'What guidelines or processes should be established to maintain brand voice consistency?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Create clear guidelines and training for brand voice implementation'
      },
      {
        type: 'textarea',
        key: 'crisisAdaptation',
        label: 'How should your brand voice adapt during crises or major changes?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Plan for voice adaptation during challenging times while maintaining core values'
      }
    ]
  },
  {
    id: 20,
    title: "Voice Evaluation",
    description: "Measure and improve your brand voice",
    progress: 91,
    section: "implementation",
    theme: {
      primary: "indigo",
      secondary: "indigo",
      gradient: "from-indigo-500 to-indigo-600"
    },
    fields: [
      {
        type: 'textarea',
        key: 'effectivenessIndicators',
        label: 'What indicators can you use to measure the effectiveness of your brand voice?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Establish metrics to evaluate voice performance and impact'
      },
      {
        type: 'textarea',
        key: 'feedbackCollection',
        label: 'How do you collect feedback from your audience about your brand voice?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Create systems for gathering audience feedback on brand communications'
      },
      {
        type: 'textarea',
        key: 'voiceEvolution',
        label: 'How should your brand voice evolve over time?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Plan for voice evolution while maintaining core identity'
      },
      {
        type: 'textarea',
        key: 'culturalAdjustments',
        label: 'What adjustments should be made based on cultural or social changes affecting your audience?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Ensure your voice remains relevant amidst cultural shifts'
      }
    ]
  },
  {
    id: 21,
    title: "Implementation",
    description: "Put your brand voice into practice",
    progress: 95,
    section: "implementation",
    theme: {
      primary: "indigo",
      secondary: "indigo",
      gradient: "from-indigo-500 to-indigo-600"
    },
    fields: [
      {
        type: 'textarea',
        key: 'platformSpecificTone',
        label: 'How should your brand sound in an Instagram post versus a blog post?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Adapt your voice for different platforms while maintaining consistency'
      },
      {
        type: 'textarea',
        key: 'negativeResponse',
        label: 'How should your brand respond to a negative comment?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Establish protocols for handling negative feedback with grace'
      },
      {
        type: 'textarea',
        key: 'dosAndDonts',
        label: 'What examples of "dos" and "donts" are necessary to guide content creators?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Create clear examples of appropriate and inappropriate voice usage'
      },
      {
        type: 'textarea',
        key: 'customerJourneyTone',
        label: 'How does your brand voice apply at different stages of the customer journey?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Adapt your voice for different customer touchpoints and journey stages'
      }
    ]
  },
  {
    id: 22,
    title: "Brand Perception",
    description: "Visualize your brand's impact",
    progress: 100,
    section: "implementation",
    theme: {
      primary: "indigo",
      secondary: "indigo",
      gradient: "from-indigo-500 to-indigo-600"
    },
    fields: [
      {
        type: 'textarea',
        key: 'brandAsObject',
        label: 'If your brand were an object, what would it be and why?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Use metaphorical thinking to define brand essence and characteristics'
      },
      {
        type: 'textarea',
        key: 'internalSlogan',
        label: 'If your brand had an internal slogan or mantra, what would it be?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Create a guiding phrase that encapsulates your brand spirit'
      },
      {
        type: 'textarea',
        key: 'postInteractionFeeling',
        label: 'How do you want your customers to feel after interacting with your content?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Define the emotional experience you want to create for your audience'
      },
      {
        type: 'textarea',
        key: 'postPurchaseThought',
        label: 'What do you want customers to think about your brand after making a purchase?',
        placeholder: 'Type your answer here...',
        required: true,
        tooltip: 'Establish the lasting impression and brand perception post-purchase'
      }
    ],
    milestone: true
  }
];

export { wizardSteps };