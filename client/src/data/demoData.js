// Sarah's demo data — matches the server /api/demo/sarah response format exactly.
// This enables fully offline demo mode.

export const DEMO_DATA = {
  formData: {
    currentRole: 'UX Researcher',
    skills: [
      'user-interviews',
      'usability-testing',
      'data-analysis',
      'research-synthesis',
      'stakeholder-management',
      'presentation-skills',
      'design-documentation',
    ],
    targetRole: 'AI Design Researcher',
  },
  resultsData: {
    alignment_score: 0.65,
    matched_skills: [
      {
        name: 'Qualitative Analysis',
        weight: 0.85,
        current_level: 'Advanced',
        transfers_to: 'Prompt Evaluation',
      },
      {
        name: 'Usability Testing',
        weight: 0.78,
        current_level: 'Advanced',
        transfers_to: 'AI Output Assessment',
      },
      {
        name: 'User Interviews',
        weight: 0.75,
        current_level: 'Advanced',
        transfers_to: 'Bias Detection',
      },
      {
        name: 'Stakeholder Presentations',
        weight: 0.70,
        current_level: 'Intermediate',
        transfers_to: 'Human-AI Collaboration',
      },
    ],
    transfer_skills: [
      {
        name: 'Research Synthesis → AI Taxonomy Design',
        weight: 0.72,
        time_to_proficiency: '1-2 weeks',
        learning_path: 'Build on existing analysis skills',
      },
      {
        name: 'Data Analysis → AI Output Assessment',
        weight: 0.80,
        time_to_proficiency: '2-3 weeks',
        learning_path: 'Apply existing methods to AI outputs',
      },
    ],
    gap_skills: [
      {
        name: 'AI Tool Proficiency',
        weight: 0.92,
        recommended_resources: [
          'Figma AI Workshop (Free, 1 week)',
          'UserTesting AI Features (2 weeks)',
        ],
        learning_path: 'Hands-on practice with AI research tools',
        time_to_proficiency: '2 weeks',
      },
      {
        name: 'Basic ML Literacy',
        weight: 0.85,
        recommended_resources: [
          'Machine Learning for Non-Technical People (IxDF, 3 weeks)',
          '"You Look Like a Thing and I Love You" (book)',
        ],
        learning_path: 'Self-paced course + reading',
        time_to_proficiency: '3 weeks',
      },
      {
        name: 'AI Ethics Evaluation',
        weight: 0.78,
        recommended_resources: [
          'AI Ethics for Design Professionals (Coursera, 2 weeks)',
          'Responsible AI practice exercises',
        ],
        learning_path: 'Short course + practice project',
        time_to_proficiency: '1 week',
      },
    ],
    narrative: `Sarah, you're already 65% aligned with the AI Design Researcher role. Your qualitative analysis and usability testing skills give you a strong foundation — these research methodologies transfer directly to evaluating AI outputs (85% confidence) and assessing AI system quality (78% confidence).

Here's your recommended path, in order of priority:

Priority 1 — AI Tool Proficiency (2 weeks): Start with the free Figma AI Workshop, then explore UserTesting's AI features. Your existing tool fluency means you'll pick this up fast.

Priority 2 — Basic ML Literacy (3 weeks): Take IxDF's non-technical ML course. You don't need to code — you need to understand how models work so you can evaluate their outputs intelligently.

Priority 3 — AI Ethics Evaluation (1 week): Complete Coursera's AI Ethics course. Your inclusive design mindset already gives you the right framework; you just need the AI-specific vocabulary and methods.

Total estimated time: 6 weeks of part-time learning. Not 6 months. Not "learn Python." Six focused weeks on exactly what matters for your transition.`,
    estimates: {
      total_time: '6 weeks (part-time)',
      breakdown: {
        'AI Tool Proficiency': '2 weeks',
        'Basic ML Literacy': '3 weeks',
        'AI Ethics Evaluation': '1 week',
      },
    },
    graph_data: {
      nodes: [
        // Current role
        { id: 'role-ux-researcher', label: 'UX Researcher\n(Current)', type: 'target', description: "Sarah's current role" },
        // User's matched design skills (green)
        { id: 'ds-qual-analysis', label: 'Qualitative\nAnalysis', type: 'matched', description: 'Core research skill — transfers to Prompt Evaluation (85%)' },
        { id: 'ds-usability-testing', label: 'Usability\nTesting', type: 'matched', description: 'Core research skill — transfers to AI Output Assessment (78%)' },
        { id: 'ds-user-interviews', label: 'User\nInterviews', type: 'matched', description: 'Core research skill — transfers to Bias Detection (75%)' },
        { id: 'ds-stakeholder-pres', label: 'Stakeholder\nPresentations', type: 'matched', description: 'Communication skill — transfers to Human-AI Collaboration (70%)' },
        // AI Capabilities the skills transfer to (orange)
        { id: 'ai-prompt-eval', label: 'Prompt\nEvaluation', type: 'transfer', description: 'AI capability — evaluate quality of AI-generated outputs' },
        { id: 'ai-output-assessment', label: 'AI Output\nAssessment', type: 'transfer', description: 'AI capability — systematically assess AI system quality' },
        { id: 'ai-bias-detect', label: 'Bias\nDetection', type: 'transfer', description: 'AI capability — detect bias in AI outputs (partial transfer from User Interviews)' },
        // Gap capabilities (red)
        { id: 'ai-tool-proficiency', label: 'AI Tool\nProficiency', type: 'gap', description: 'GAP — Hands-on experience with AI design tools (2 weeks)' },
        { id: 'ai-ml-literacy', label: 'Basic ML\nLiteracy', type: 'gap', description: 'GAP — Understanding how AI models work (3 weeks)' },
        { id: 'ai-ethics-eval', label: 'AI Ethics\nEvaluation', type: 'gap', description: 'GAP — Assessing AI for bias and fairness (1 week)' },
        // Courses (purple)
        { id: 'course-figma-ai', label: 'Figma AI\nWorkshop', type: 'course', description: 'Free — 1 week — Figma' },
        { id: 'course-ml-nontech', label: 'ML for\nNon-Tech', type: 'course', description: 'IxDF Subscription — 3 weeks' },
        { id: 'course-ai-ethics', label: 'AI Ethics\nCourse', type: 'course', description: 'Coursera $49 — 2 weeks' },
        // Tools (cyan)
        { id: 'tool-usertesting', label: 'UserTesting\nAI', type: 'tool', description: 'AI-powered user testing platform' },
        // Target role
        { id: 'role-ai-researcher', label: 'AI Design\nResearcher\n(Target)', type: 'target', description: "Sarah's target role — combines UX research with AI evaluation" },
      ],
      edges: [
        // Current role -> skills
        { from: 'role-ux-researcher', to: 'ds-qual-analysis', type: 'has_skill' },
        { from: 'role-ux-researcher', to: 'ds-usability-testing', type: 'has_skill' },
        { from: 'role-ux-researcher', to: 'ds-user-interviews', type: 'has_skill' },
        { from: 'role-ux-researcher', to: 'ds-stakeholder-pres', type: 'has_skill' },
        // TRANSFERS_TO edges (the money shots)
        { from: 'ds-qual-analysis', to: 'ai-prompt-eval', type: 'transfers_to', weight: 0.85 },
        { from: 'ds-usability-testing', to: 'ai-output-assessment', type: 'transfers_to', weight: 0.78 },
        { from: 'ds-user-interviews', to: 'ai-bias-detect', type: 'transfers_to', weight: 0.75 },
        { from: 'ds-usability-testing', to: 'ai-bias-detect', type: 'transfers_to', weight: 0.72 },
        // Transfer capabilities -> target
        { from: 'ai-prompt-eval', to: 'role-ai-researcher', type: 'enables', weight: 0.85 },
        { from: 'ai-output-assessment', to: 'role-ai-researcher', type: 'enables', weight: 0.78 },
        { from: 'ai-bias-detect', to: 'role-ai-researcher', type: 'enables', weight: 0.75 },
        // Gap capabilities -> target
        { from: 'ai-tool-proficiency', to: 'role-ai-researcher', type: 'requires' },
        { from: 'ai-ml-literacy', to: 'role-ai-researcher', type: 'requires' },
        { from: 'ai-ethics-eval', to: 'role-ai-researcher', type: 'requires' },
        // Courses teach gap skills
        { from: 'course-figma-ai', to: 'ai-tool-proficiency', type: 'teaches' },
        { from: 'course-ml-nontech', to: 'ai-ml-literacy', type: 'teaches' },
        { from: 'course-ai-ethics', to: 'ai-ethics-eval', type: 'teaches' },
        // Tools develop gap skills
        { from: 'tool-usertesting', to: 'ai-tool-proficiency', type: 'develops' },
      ],
    },
  },
};
