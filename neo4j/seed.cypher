// ============================================================
// PathFinder: AI Design Navigator — Neo4j Seed Script
// HackWithBay 2.0 — March 30, 2026
// ============================================================
// Run this in Neo4j Aura Browser or via cypher-shell.
// Execute each section in order (constraints first, then nodes, then relationships).
// ============================================================

// --- CONSTRAINTS & INDEXES ---
CREATE CONSTRAINT IF NOT EXISTS FOR (s:DesignSkill) REQUIRE s.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (a:AICapability) REQUIRE a.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (r:Role) REQUIRE r.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (t:Tool) REQUIRE t.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (c:Course) REQUIRE c.id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (cert:Certification) REQUIRE cert.id IS UNIQUE;

CREATE INDEX IF NOT EXISTS FOR (s:DesignSkill) ON (s.name);
CREATE INDEX IF NOT EXISTS FOR (a:AICapability) ON (a.name);
CREATE INDEX IF NOT EXISTS FOR (r:Role) ON (r.name);

// ============================================================
// NODE CREATION
// ============================================================

// --- DESIGN SKILLS (50+) ---
CREATE (ds1:DesignSkill {id: 'ds-qual-analysis', name: 'Qualitative Analysis', category: 'Research', description: 'Analyzing qualitative data from interviews, observations, and open-ended surveys to identify patterns and insights'})
CREATE (ds2:DesignSkill {id: 'ds-user-interviews', name: 'User Interviews', category: 'Research', description: 'Planning and conducting structured and semi-structured interviews with users'})
CREATE (ds3:DesignSkill {id: 'ds-usability-testing', name: 'Usability Testing', category: 'Research', description: 'Designing and running usability tests to evaluate product effectiveness'})
CREATE (ds4:DesignSkill {id: 'ds-affinity-diag', name: 'Affinity Diagramming', category: 'Research', description: 'Organizing research findings into thematic clusters'})
CREATE (ds5:DesignSkill {id: 'ds-persona-creation', name: 'Persona Creation', category: 'Research', description: 'Developing evidence-based user personas to guide design decisions'})
CREATE (ds6:DesignSkill {id: 'ds-journey-mapping', name: 'Journey Mapping', category: 'Research', description: 'Mapping end-to-end user experiences across touchpoints'})
CREATE (ds7:DesignSkill {id: 'ds-info-arch', name: 'Information Architecture', category: 'Structure', description: 'Organizing and structuring content and navigation systems'})
CREATE (ds8:DesignSkill {id: 'ds-content-strategy', name: 'Content Strategy', category: 'Content', description: 'Planning, creating, and managing content across products and channels'})
CREATE (ds9:DesignSkill {id: 'ds-visual-hierarchy', name: 'Visual Hierarchy', category: 'Visual', description: 'Arranging elements to guide user attention and communicate priority'})
CREATE (ds10:DesignSkill {id: 'ds-wireframing', name: 'Wireframing', category: 'Visual', description: 'Creating low-fidelity layouts to explore structure and flow'})
CREATE (ds11:DesignSkill {id: 'ds-prototyping', name: 'Prototyping', category: 'Visual', description: 'Building interactive prototypes to test and communicate design concepts'})
CREATE (ds12:DesignSkill {id: 'ds-visual-design', name: 'Visual Design', category: 'Visual', description: 'Crafting aesthetics including color, typography, imagery, and layout'})
CREATE (ds13:DesignSkill {id: 'ds-interaction-design', name: 'Interaction Design', category: 'Visual', description: 'Designing meaningful interactions between users and digital products'})
CREATE (ds14:DesignSkill {id: 'ds-design-systems', name: 'Design Systems', category: 'Structure', description: 'Building and maintaining reusable component libraries and style guides'})
CREATE (ds15:DesignSkill {id: 'ds-accessibility', name: 'Accessibility Design', category: 'Structure', description: 'Designing inclusive experiences that meet WCAG standards'})
CREATE (ds16:DesignSkill {id: 'ds-stakeholder-pres', name: 'Stakeholder Presentations', category: 'Communication', description: 'Communicating design decisions and research findings to stakeholders'})
CREATE (ds17:DesignSkill {id: 'ds-design-thinking', name: 'Design Thinking', category: 'Process', description: 'Applying human-centered design methodology to problem solving'})
CREATE (ds18:DesignSkill {id: 'ds-survey-design', name: 'Survey Design', category: 'Research', description: 'Creating effective quantitative and qualitative survey instruments'})
CREATE (ds19:DesignSkill {id: 'ds-card-sorting', name: 'Card Sorting', category: 'Research', description: 'Running card sorting exercises to inform information architecture'})
CREATE (ds20:DesignSkill {id: 'ds-heuristic-eval', name: 'Heuristic Evaluation', category: 'Research', description: 'Evaluating interfaces against established usability principles'})
CREATE (ds21:DesignSkill {id: 'ds-a-b-testing', name: 'A/B Testing', category: 'Research', description: 'Designing and analyzing controlled experiments to compare design variants'})
CREATE (ds22:DesignSkill {id: 'ds-quant-analysis', name: 'Quantitative Analysis', category: 'Research', description: 'Analyzing numerical data, metrics, and statistical patterns'})
CREATE (ds23:DesignSkill {id: 'ds-motion-design', name: 'Motion Design', category: 'Visual', description: 'Creating animations and transitions that enhance user experience'})
CREATE (ds24:DesignSkill {id: 'ds-typography', name: 'Typography', category: 'Visual', description: 'Selecting and arranging typefaces for readability and brand expression'})
CREATE (ds25:DesignSkill {id: 'ds-color-theory', name: 'Color Theory', category: 'Visual', description: 'Applying color principles to create effective visual communication'})
CREATE (ds26:DesignSkill {id: 'ds-iconography', name: 'Iconography', category: 'Visual', description: 'Designing and selecting icons for clear visual communication'})
CREATE (ds27:DesignSkill {id: 'ds-responsive-design', name: 'Responsive Design', category: 'Structure', description: 'Designing layouts that adapt across screen sizes and devices'})
CREATE (ds28:DesignSkill {id: 'ds-ux-writing', name: 'UX Writing', category: 'Content', description: 'Crafting clear, concise microcopy that guides users through interfaces'})
CREATE (ds29:DesignSkill {id: 'ds-user-flows', name: 'User Flow Design', category: 'Structure', description: 'Mapping step-by-step paths users take to accomplish tasks'})
CREATE (ds30:DesignSkill {id: 'ds-competitive-analysis', name: 'Competitive Analysis', category: 'Research', description: 'Systematically evaluating competitor products and strategies'})
CREATE (ds31:DesignSkill {id: 'ds-workshop-facil', name: 'Workshop Facilitation', category: 'Communication', description: 'Leading collaborative design workshops and ideation sessions'})
CREATE (ds32:DesignSkill {id: 'ds-storyboarding', name: 'Storyboarding', category: 'Visual', description: 'Creating narrative sequences to illustrate user scenarios'})
CREATE (ds33:DesignSkill {id: 'ds-data-viz', name: 'Data Visualization', category: 'Visual', description: 'Presenting data through charts, graphs, and visual representations'})
CREATE (ds34:DesignSkill {id: 'ds-brand-design', name: 'Brand Design', category: 'Visual', description: 'Developing visual identity systems including logos, colors, and guidelines'})
CREATE (ds35:DesignSkill {id: 'ds-service-design', name: 'Service Design', category: 'Process', description: 'Designing end-to-end service experiences across channels and touchpoints'})
CREATE (ds36:DesignSkill {id: 'ds-systems-thinking', name: 'Systems Thinking', category: 'Process', description: 'Understanding complex interconnected systems and feedback loops'})
CREATE (ds37:DesignSkill {id: 'ds-ethnography', name: 'Ethnographic Research', category: 'Research', description: 'Conducting in-context observational research to understand user behaviors'})
CREATE (ds38:DesignSkill {id: 'ds-rapid-prototyping', name: 'Rapid Prototyping', category: 'Process', description: 'Quickly building and iterating on low-cost prototypes to test ideas'})
CREATE (ds39:DesignSkill {id: 'ds-cross-functional', name: 'Cross-functional Collaboration', category: 'Communication', description: 'Working effectively across engineering, product, and business teams'})
CREATE (ds40:DesignSkill {id: 'ds-design-critique', name: 'Design Critique', category: 'Communication', description: 'Giving and receiving constructive feedback on design work'})
CREATE (ds41:DesignSkill {id: 'ds-conversational-design', name: 'Conversational Design', category: 'Content', description: 'Designing dialogue flows for chatbots and voice interfaces'})
CREATE (ds42:DesignSkill {id: 'ds-illustration', name: 'Illustration', category: 'Visual', description: 'Creating custom illustrations for digital products'})
CREATE (ds43:DesignSkill {id: 'ds-photo-editing', name: 'Photo Editing', category: 'Visual', description: 'Editing and manipulating photographs for digital use'})
CREATE (ds44:DesignSkill {id: 'ds-3d-design', name: '3D Design', category: 'Visual', description: 'Creating three-dimensional models and environments'})
CREATE (ds45:DesignSkill {id: 'ds-front-end-basics', name: 'Front-end Basics', category: 'Technical', description: 'Understanding HTML, CSS, and basic JavaScript for design implementation'})
CREATE (ds46:DesignSkill {id: 'ds-analytics-interpret', name: 'Analytics Interpretation', category: 'Research', description: 'Reading and interpreting product analytics and user behavior data'})
CREATE (ds47:DesignSkill {id: 'ds-voice-ui', name: 'Voice UI Design', category: 'Content', description: 'Designing voice-based interactions and interfaces'})
CREATE (ds48:DesignSkill {id: 'ds-microcopy', name: 'Microcopy Writing', category: 'Content', description: 'Writing concise, effective UI text including buttons, labels, and error messages'})
CREATE (ds49:DesignSkill {id: 'ds-design-ops', name: 'DesignOps', category: 'Process', description: 'Optimizing design team workflows, tools, and processes'})
CREATE (ds50:DesignSkill {id: 'ds-inclusive-design', name: 'Inclusive Design', category: 'Process', description: 'Designing for diverse users across abilities, cultures, and contexts'});

// --- AI CAPABILITIES (30+) ---
CREATE (ai1:AICapability {id: 'ai-prompt-eng', name: 'Prompt Engineering', category: 'Core AI', description: 'Crafting effective prompts to get desired outputs from LLMs', difficulty: 'Beginner'})
CREATE (ai2:AICapability {id: 'ai-prompt-eval', name: 'Prompt Evaluation', category: 'Core AI', description: 'Assessing the quality, accuracy, and bias of AI-generated outputs', difficulty: 'Intermediate'})
CREATE (ai3:AICapability {id: 'ai-output-assessment', name: 'AI Output Assessment', category: 'Core AI', description: 'Systematically evaluating AI outputs against quality criteria', difficulty: 'Intermediate'})
CREATE (ai4:AICapability {id: 'ai-taxonomy-design', name: 'AI Taxonomy Design', category: 'Data & Structure', description: 'Designing classification systems and ontologies for AI applications', difficulty: 'Intermediate'})
CREATE (ai5:AICapability {id: 'ai-kg-design', name: 'Knowledge Graph Design', category: 'Data & Structure', description: 'Modeling domains as interconnected graphs for AI systems', difficulty: 'Advanced'})
CREATE (ai6:AICapability {id: 'ai-image-prompting', name: 'AI Image Prompt Crafting', category: 'Creative AI', description: 'Writing effective prompts for image generation models', difficulty: 'Beginner'})
CREATE (ai7:AICapability {id: 'ai-workflow-design', name: 'AI Workflow Design', category: 'Process', description: 'Designing end-to-end workflows that integrate AI capabilities', difficulty: 'Intermediate'})
CREATE (ai8:AICapability {id: 'ai-persona-agent', name: 'AI Persona/Agent Design', category: 'Core AI', description: 'Designing AI agent personalities, behaviors, and interaction patterns', difficulty: 'Intermediate'})
CREATE (ai9:AICapability {id: 'ai-tool-proficiency', name: 'AI Tool Proficiency', category: 'Tools', description: 'Hands-on experience using AI design tools (Figma AI, Midjourney, etc.)', difficulty: 'Beginner'})
CREATE (ai10:AICapability {id: 'ai-ml-literacy', name: 'Basic ML Literacy', category: 'Core AI', description: 'Understanding how AI models work at a conceptual level', difficulty: 'Beginner'})
CREATE (ai11:AICapability {id: 'ai-ethics-eval', name: 'AI Ethics Evaluation', category: 'Ethics', description: 'Assessing AI outputs for bias, fairness, and ethical implications', difficulty: 'Intermediate'})
CREATE (ai12:AICapability {id: 'ai-data-labeling', name: 'Data Labeling & Annotation', category: 'Data & Structure', description: 'Creating high-quality training data labels and annotations', difficulty: 'Beginner'})
CREATE (ai13:AICapability {id: 'ai-synthetic-users', name: 'Synthetic User Research', category: 'Research', description: 'Using AI-generated synthetic users for research and testing', difficulty: 'Intermediate'})
CREATE (ai14:AICapability {id: 'ai-conversational-ai', name: 'Conversational AI Design', category: 'Core AI', description: 'Designing conversational AI interfaces and dialogue systems', difficulty: 'Advanced'})
CREATE (ai15:AICapability {id: 'ai-content-gen', name: 'AI Content Generation', category: 'Creative AI', description: 'Using LLMs to generate and iterate on written content', difficulty: 'Beginner'})
CREATE (ai16:AICapability {id: 'ai-ux-ai-patterns', name: 'AI UX Patterns', category: 'Process', description: 'Applying established UX patterns for AI-powered interfaces', difficulty: 'Intermediate'})
CREATE (ai17:AICapability {id: 'ai-model-selection', name: 'AI Model Selection', category: 'Core AI', description: 'Choosing appropriate AI models for different design tasks', difficulty: 'Intermediate'})
CREATE (ai18:AICapability {id: 'ai-fine-tuning', name: 'Model Fine-tuning', category: 'Core AI', description: 'Customizing pre-trained models for specific use cases', difficulty: 'Advanced'})
CREATE (ai19:AICapability {id: 'ai-testing-ai', name: 'AI System Testing', category: 'Research', description: 'Testing AI systems for reliability, accuracy, and edge cases', difficulty: 'Intermediate'})
CREATE (ai20:AICapability {id: 'ai-rag', name: 'RAG System Design', category: 'Data & Structure', description: 'Designing retrieval-augmented generation systems', difficulty: 'Advanced'})
CREATE (ai21:AICapability {id: 'ai-multimodal', name: 'Multimodal AI Design', category: 'Creative AI', description: 'Designing experiences that combine text, image, audio, and video AI', difficulty: 'Advanced'})
CREATE (ai22:AICapability {id: 'ai-automation', name: 'Design Automation', category: 'Process', description: 'Automating repetitive design tasks using AI tools', difficulty: 'Beginner'})
CREATE (ai23:AICapability {id: 'ai-data-viz-ai', name: 'AI-Powered Data Visualization', category: 'Creative AI', description: 'Using AI to generate and enhance data visualizations', difficulty: 'Intermediate'})
CREATE (ai24:AICapability {id: 'ai-voice-ai', name: 'Voice AI Design', category: 'Core AI', description: 'Designing voice-based AI interactions and interfaces', difficulty: 'Intermediate'})
CREATE (ai25:AICapability {id: 'ai-personalization', name: 'AI Personalization Design', category: 'Process', description: 'Designing AI-driven personalized user experiences', difficulty: 'Intermediate'})
CREATE (ai26:AICapability {id: 'ai-gen-ui', name: 'Generative UI Design', category: 'Creative AI', description: 'Using AI to generate UI components, layouts, and design variations', difficulty: 'Intermediate'})
CREATE (ai27:AICapability {id: 'ai-accessibility-ai', name: 'AI Accessibility Testing', category: 'Ethics', description: 'Using AI to audit and improve product accessibility', difficulty: 'Beginner'})
CREATE (ai28:AICapability {id: 'ai-design-critique-ai', name: 'AI Design Critique', category: 'Process', description: 'Using AI tools to get feedback and critique on design work', difficulty: 'Beginner'})
CREATE (ai29:AICapability {id: 'ai-3d-gen', name: 'AI 3D Generation', category: 'Creative AI', description: 'Using AI to generate and manipulate 3D content', difficulty: 'Advanced'})
CREATE (ai30:AICapability {id: 'ai-agent-orchestration', name: 'AI Agent Orchestration', category: 'Core AI', description: 'Designing multi-agent AI systems and workflows', difficulty: 'Advanced'})
CREATE (ai31:AICapability {id: 'ai-prompt-chaining', name: 'Prompt Chaining', category: 'Core AI', description: 'Designing sequences of prompts that build on each other', difficulty: 'Intermediate'})
CREATE (ai32:AICapability {id: 'ai-human-ai-collab', name: 'Human-AI Collaboration Design', category: 'Process', description: 'Designing effective collaboration patterns between humans and AI', difficulty: 'Intermediate'});

// --- ROLES (Current + Target, 15 total) ---
// Current roles
CREATE (r1:Role {id: 'role-ux-researcher', name: 'UX Researcher', type: 'current', description: 'Conducts user research to inform product design decisions'})
CREATE (r2:Role {id: 'role-ux-designer', name: 'UX Designer', type: 'current', description: 'Designs user interfaces and experiences for digital products'})
CREATE (r3:Role {id: 'role-visual-designer', name: 'Visual Designer', type: 'current', description: 'Creates visual elements including layout, color, and typography'})
CREATE (r4:Role {id: 'role-content-designer', name: 'Content Designer', type: 'current', description: 'Creates and manages content for digital products'})
CREATE (r5:Role {id: 'role-ia', name: 'Information Architect', type: 'current', description: 'Organizes and structures information in digital products'})
CREATE (r6:Role {id: 'role-product-designer', name: 'Product Designer', type: 'current', description: 'End-to-end product design from research to visual design'})
CREATE (r7:Role {id: 'role-graphic-designer', name: 'Graphic Designer', type: 'current', description: 'Creates visual content for print and digital media'})
// Target AI-augmented roles
CREATE (r8:Role {id: 'role-ai-design-researcher', name: 'AI Design Researcher', type: 'target', description: 'Combines UX research with AI evaluation and AI-powered research methodologies'})
CREATE (r9:Role {id: 'role-ai-ux-lead', name: 'AI UX Lead', type: 'target', description: 'Leads UX teams in designing AI-powered products and integrating AI into design processes'})
CREATE (r10:Role {id: 'role-conv-ui-designer', name: 'Conversational UI Designer', type: 'target', description: 'Designs conversational interfaces for AI chatbots and voice assistants'})
CREATE (r11:Role {id: 'role-ai-content-strategist', name: 'AI Content Strategist', type: 'target', description: 'Develops content strategies that leverage AI for creation, personalization, and optimization'})
CREATE (r12:Role {id: 'role-ai-product-designer', name: 'AI Product Designer', type: 'target', description: 'Designs AI-native products with deep understanding of AI capabilities and limitations'})
CREATE (r13:Role {id: 'role-ai-design-lead', name: 'AI Design Lead', type: 'target', description: 'Strategic design leadership role bridging design teams with AI capabilities'})
CREATE (r14:Role {id: 'role-ai-design-engineer', name: 'AI Design Engineer', type: 'target', description: 'Bridges design and engineering in AI product development'})
CREATE (r15:Role {id: 'role-ai-ethics-designer', name: 'AI Ethics Designer', type: 'target', description: 'Specializes in designing ethical, fair, and transparent AI experiences'});

// --- TOOLS (15) ---
CREATE (t1:Tool {id: 'tool-figma-ai', name: 'Figma AI', category: 'Design', url: 'https://figma.com'})
CREATE (t2:Tool {id: 'tool-midjourney', name: 'Midjourney', category: 'Image Generation', url: 'https://midjourney.com'})
CREATE (t3:Tool {id: 'tool-dalle', name: 'DALL-E', category: 'Image Generation', url: 'https://openai.com/dall-e'})
CREATE (t4:Tool {id: 'tool-chatgpt', name: 'ChatGPT', category: 'LLM', url: 'https://chat.openai.com'})
CREATE (t5:Tool {id: 'tool-claude', name: 'Claude', category: 'LLM', url: 'https://claude.ai'})
CREATE (t6:Tool {id: 'tool-adobe-firefly', name: 'Adobe Firefly', category: 'Image Generation', url: 'https://firefly.adobe.com'})
CREATE (t7:Tool {id: 'tool-usertesting-ai', name: 'UserTesting AI', category: 'Research', url: 'https://usertesting.com'})
CREATE (t8:Tool {id: 'tool-maze-ai', name: 'Maze AI', category: 'Research', url: 'https://maze.co'})
CREATE (t9:Tool {id: 'tool-stable-diffusion', name: 'Stable Diffusion', category: 'Image Generation', url: 'https://stability.ai'})
CREATE (t10:Tool {id: 'tool-copilot', name: 'GitHub Copilot', category: 'Code', url: 'https://github.com/features/copilot'})
CREATE (t11:Tool {id: 'tool-v0', name: 'v0 by Vercel', category: 'Code', url: 'https://v0.dev'})
CREATE (t12:Tool {id: 'tool-cursor', name: 'Cursor', category: 'Code', url: 'https://cursor.sh'})
CREATE (t13:Tool {id: 'tool-framer-ai', name: 'Framer AI', category: 'Design', url: 'https://framer.com'})
CREATE (t14:Tool {id: 'tool-relume', name: 'Relume', category: 'Design', url: 'https://relume.io'})
CREATE (t15:Tool {id: 'tool-galileo-ai', name: 'Galileo AI', category: 'Design', url: 'https://galileo.ai'});

// --- COURSES (20) ---
CREATE (c1:Course {id: 'course-ixdf-ai-design', name: 'AI for Designers (IxDF)', provider: 'Interaction Design Foundation', url: 'https://www.interaction-design.org/', duration_weeks: 4, cost: 'Subscription', level: 'Beginner'})
CREATE (c2:Course {id: 'course-coursera-prompt', name: 'Prompt Engineering for Creatives', provider: 'Coursera', url: 'https://coursera.org/', duration_weeks: 3, cost: '$49', level: 'Beginner'})
CREATE (c3:Course {id: 'course-nngroup-ai-ux', name: 'AI and UX: Design Guidelines', provider: 'NNGroup', url: 'https://www.nngroup.com/', duration_weeks: 1, cost: '$399', level: 'Intermediate'})
CREATE (c4:Course {id: 'course-figma-ai-workshop', name: 'Figma AI Workshop', provider: 'Figma', url: 'https://figma.com/', duration_weeks: 1, cost: 'Free', level: 'Beginner'})
CREATE (c5:Course {id: 'course-ml-nontech', name: 'Machine Learning for Non-Technical People', provider: 'IxDF', url: 'https://www.interaction-design.org/', duration_weeks: 3, cost: 'Subscription', level: 'Beginner'})
CREATE (c6:Course {id: 'course-ai-ethics', name: 'AI Ethics for Design Professionals', provider: 'Coursera', url: 'https://coursera.org/', duration_weeks: 2, cost: '$49', level: 'Intermediate'})
CREATE (c7:Course {id: 'course-conv-design', name: 'Conversational Design Masterclass', provider: 'Google', url: 'https://developers.google.com/actions/design', duration_weeks: 4, cost: 'Free', level: 'Intermediate'})
CREATE (c8:Course {id: 'course-midjourney-mastery', name: 'Midjourney Mastery for Designers', provider: 'Udemy', url: 'https://udemy.com/', duration_weeks: 2, cost: '$29', level: 'Beginner'})
CREATE (c9:Course {id: 'course-ai-research-methods', name: 'AI-Powered Research Methods', provider: 'NNGroup', url: 'https://www.nngroup.com/', duration_weeks: 2, cost: '$399', level: 'Intermediate'})
CREATE (c10:Course {id: 'course-design-systems-ai', name: 'Design Systems in the Age of AI', provider: 'Smashing Magazine', url: 'https://smashingmagazine.com/', duration_weeks: 1, cost: '$99', level: 'Intermediate'})
CREATE (c11:Course {id: 'course-data-viz-ai', name: 'AI-Powered Data Visualization', provider: 'Coursera', url: 'https://coursera.org/', duration_weeks: 3, cost: '$49', level: 'Intermediate'})
CREATE (c12:Course {id: 'course-genui-basics', name: 'Generative UI: From Concept to Code', provider: 'Udemy', url: 'https://udemy.com/', duration_weeks: 3, cost: '$39', level: 'Intermediate'})
CREATE (c13:Course {id: 'course-voice-ai-design', name: 'Designing for Voice AI', provider: 'IxDF', url: 'https://www.interaction-design.org/', duration_weeks: 3, cost: 'Subscription', level: 'Intermediate'})
CREATE (c14:Course {id: 'course-ai-content-strategy', name: 'AI Content Strategy', provider: 'Content Design Academy', url: 'https://contentdesign.london/', duration_weeks: 4, cost: '$199', level: 'Intermediate'})
CREATE (c15:Course {id: 'course-rag-basics', name: 'RAG Systems for Product People', provider: 'Coursera', url: 'https://coursera.org/', duration_weeks: 2, cost: '$49', level: 'Advanced'})
CREATE (c16:Course {id: 'course-human-ai-collab', name: 'Human-AI Collaboration Patterns', provider: 'IxDF', url: 'https://www.interaction-design.org/', duration_weeks: 3, cost: 'Subscription', level: 'Intermediate'})
CREATE (c17:Course {id: 'course-ai-persona-design', name: 'Designing AI Personas & Agents', provider: 'Udemy', url: 'https://udemy.com/', duration_weeks: 2, cost: '$34', level: 'Intermediate'})
CREATE (c18:Course {id: 'course-multimodal-ai', name: 'Multimodal AI for Creative Professionals', provider: 'Coursera', url: 'https://coursera.org/', duration_weeks: 4, cost: '$49', level: 'Advanced'})
CREATE (c19:Course {id: 'course-ai-accessibility', name: 'AI-Powered Accessibility Auditing', provider: 'Deque University', url: 'https://dequeuniversity.com/', duration_weeks: 2, cost: '$100', level: 'Intermediate'})
CREATE (c20:Course {id: 'course-prompt-chaining', name: 'Advanced Prompt Chaining for Designers', provider: 'Udemy', url: 'https://udemy.com/', duration_weeks: 2, cost: '$39', level: 'Intermediate'});

// ============================================================
// RELATIONSHIPS
// ============================================================

// --- TRANSFERS_TO: Design Skills -> AI Capabilities (weighted) ---
// This is the core differentiator — hidden transferability
// Research skills
MATCH (ds:DesignSkill {id: 'ds-qual-analysis'}), (ai:AICapability {id: 'ai-prompt-eval'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.85, rationale: 'Qualitative analysis skills directly apply to evaluating AI output quality'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-qual-analysis'}), (ai:AICapability {id: 'ai-output-assessment'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.80, rationale: 'Pattern recognition in qualitative data maps to assessing AI outputs'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-usability-testing'}), (ai:AICapability {id: 'ai-output-assessment'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.78, rationale: 'Usability evaluation methodology applies to AI system evaluation'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-usability-testing'}), (ai:AICapability {id: 'ai-testing-ai'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.75, rationale: 'Test design skills transfer to AI system testing'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-affinity-diag'}), (ai:AICapability {id: 'ai-taxonomy-design'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.72, rationale: 'Thematic clustering skills map to designing AI classification systems'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-persona-creation'}), (ai:AICapability {id: 'ai-persona-agent'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.82, rationale: 'Persona development translates directly to AI agent personality design'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-journey-mapping'}), (ai:AICapability {id: 'ai-workflow-design'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.68, rationale: 'End-to-end journey thinking applies to AI workflow design'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-user-interviews'}), (ai:AICapability {id: 'ai-prompt-eng'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.65, rationale: 'Structured questioning techniques apply to prompt construction'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-user-interviews'}), (ai:AICapability {id: 'ai-synthetic-users'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.70, rationale: 'Interview methodology informs how to design and validate synthetic user research'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-survey-design'}), (ai:AICapability {id: 'ai-data-labeling'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.60, rationale: 'Survey instrument design skills transfer to creating annotation guidelines'}]->(ai);

// Structure & IA skills
MATCH (ds:DesignSkill {id: 'ds-info-arch'}), (ai:AICapability {id: 'ai-kg-design'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.80, rationale: 'Information architecture is foundational to knowledge graph design'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-info-arch'}), (ai:AICapability {id: 'ai-taxonomy-design'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.82, rationale: 'IA taxonomy skills directly apply to AI classification design'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-info-arch'}), (ai:AICapability {id: 'ai-rag'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.65, rationale: 'Information organization skills help design retrieval systems'}]->(ai);

// Content skills
MATCH (ds:DesignSkill {id: 'ds-content-strategy'}), (ai:AICapability {id: 'ai-prompt-eng'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.75, rationale: 'Structured writing expertise directly enables effective prompt engineering'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-content-strategy'}), (ai:AICapability {id: 'ai-content-gen'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.80, rationale: 'Content strategy skills guide effective use of AI content generation'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-ux-writing'}), (ai:AICapability {id: 'ai-prompt-eng'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.72, rationale: 'Concise, clear writing skills are core to prompt engineering'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-ux-writing'}), (ai:AICapability {id: 'ai-conversational-ai'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.70, rationale: 'Microcopy skills transfer to conversational AI dialogue writing'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-conversational-design'}), (ai:AICapability {id: 'ai-conversational-ai'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.88, rationale: 'Conversational design skills are directly applicable to AI dialogue systems'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-microcopy'}), (ai:AICapability {id: 'ai-prompt-eng'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.68, rationale: 'Precise language skills from microcopy transfer to prompt crafting'}]->(ai);

// Visual skills
MATCH (ds:DesignSkill {id: 'ds-visual-hierarchy'}), (ai:AICapability {id: 'ai-image-prompting'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.70, rationale: 'Understanding visual principles helps craft better image generation prompts'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-visual-design'}), (ai:AICapability {id: 'ai-image-prompting'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.72, rationale: 'Visual design vocabulary enables more precise AI image prompting'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-visual-design'}), (ai:AICapability {id: 'ai-gen-ui'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.65, rationale: 'Visual design judgment helps evaluate and refine AI-generated UI'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-color-theory'}), (ai:AICapability {id: 'ai-image-prompting'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.60, rationale: 'Color knowledge improves image generation prompt specificity'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-typography'}), (ai:AICapability {id: 'ai-gen-ui'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.55, rationale: 'Typography knowledge helps evaluate AI-generated UI designs'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-illustration'}), (ai:AICapability {id: 'ai-image-prompting'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.75, rationale: 'Illustration skills provide vocabulary and aesthetic judgment for AI image generation'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-3d-design'}), (ai:AICapability {id: 'ai-3d-gen'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.70, rationale: '3D design knowledge transfers to guiding AI 3D generation'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-motion-design'}), (ai:AICapability {id: 'ai-multimodal'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.55, rationale: 'Motion understanding helps design multimodal AI experiences'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-data-viz'}), (ai:AICapability {id: 'ai-data-viz-ai'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.82, rationale: 'Data visualization skills directly enhance AI-powered visualization work'}]->(ai);

// Process & systems skills
MATCH (ds:DesignSkill {id: 'ds-design-thinking'}), (ai:AICapability {id: 'ai-human-ai-collab'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.72, rationale: 'Human-centered design thinking frames effective human-AI collaboration'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-systems-thinking'}), (ai:AICapability {id: 'ai-agent-orchestration'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.68, rationale: 'Systems thinking helps design multi-agent AI orchestration'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-systems-thinking'}), (ai:AICapability {id: 'ai-workflow-design'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.72, rationale: 'Understanding complex systems helps design AI workflows'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-service-design'}), (ai:AICapability {id: 'ai-workflow-design'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.70, rationale: 'Service design maps end-to-end experiences, applicable to AI workflows'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-design-systems'}), (ai:AICapability {id: 'ai-gen-ui'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.68, rationale: 'Design system thinking helps structure and constrain generative UI'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-design-systems'}), (ai:AICapability {id: 'ai-automation'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.62, rationale: 'Systematic design component thinking enables design automation'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-prototyping'}), (ai:AICapability {id: 'ai-gen-ui'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.60, rationale: 'Prototyping skills help rapidly iterate with generative UI tools'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-interaction-design'}), (ai:AICapability {id: 'ai-ux-ai-patterns'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.75, rationale: 'Interaction design principles apply to AI interface patterns'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-interaction-design'}), (ai:AICapability {id: 'ai-conversational-ai'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.62, rationale: 'Interaction patterns inform conversational AI design'}]->(ai);

// Communication skills
MATCH (ds:DesignSkill {id: 'ds-stakeholder-pres'}), (ai:AICapability {id: 'ai-human-ai-collab'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.55, rationale: 'Stakeholder communication helps bridge human-AI collaboration gaps'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-workshop-facil'}), (ai:AICapability {id: 'ai-human-ai-collab'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.58, rationale: 'Facilitation skills help design human-AI collaboration sessions'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-design-critique'}), (ai:AICapability {id: 'ai-design-critique-ai'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.72, rationale: 'Critique methodology directly applies to AI-assisted design review'}]->(ai);

// Technical skills
MATCH (ds:DesignSkill {id: 'ds-front-end-basics'}), (ai:AICapability {id: 'ai-gen-ui'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.65, rationale: 'Front-end knowledge helps evaluate and customize AI-generated code'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-a-b-testing'}), (ai:AICapability {id: 'ai-testing-ai'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.70, rationale: 'Experiment design transfers to AI system evaluation'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-quant-analysis'}), (ai:AICapability {id: 'ai-output-assessment'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.72, rationale: 'Quantitative analysis skills help assess AI system performance metrics'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-analytics-interpret'}), (ai:AICapability {id: 'ai-personalization'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.60, rationale: 'Analytics interpretation informs AI personalization design'}]->(ai);

// Ethics & inclusion
MATCH (ds:DesignSkill {id: 'ds-accessibility'}), (ai:AICapability {id: 'ai-accessibility-ai'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.82, rationale: 'Accessibility expertise directly transfers to AI accessibility testing'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-accessibility'}), (ai:AICapability {id: 'ai-ethics-eval'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.60, rationale: 'Inclusive design mindset applies to AI ethics evaluation'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-inclusive-design'}), (ai:AICapability {id: 'ai-ethics-eval'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.70, rationale: 'Inclusive design principles apply to evaluating AI bias and fairness'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-heuristic-eval'}), (ai:AICapability {id: 'ai-output-assessment'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.74, rationale: 'Heuristic evaluation methodology applies to assessing AI outputs'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-voice-ui'}), (ai:AICapability {id: 'ai-voice-ai'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.80, rationale: 'Voice UI design skills transfer directly to voice AI design'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-voice-ui'}), (ai:AICapability {id: 'ai-conversational-ai'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.75, rationale: 'Voice interface design applies to conversational AI'}]->(ai);

// Prompt chaining
MATCH (ds:DesignSkill {id: 'ds-user-flows'}), (ai:AICapability {id: 'ai-prompt-chaining'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.70, rationale: 'User flow thinking maps to designing prompt chains'}]->(ai);
MATCH (ds:DesignSkill {id: 'ds-user-flows'}), (ai:AICapability {id: 'ai-workflow-design'}) CREATE (ds)-[:TRANSFERS_TO {weight: 0.72, rationale: 'User flow design skills apply to AI workflow design'}]->(ai);

// --- REQUIRES: Roles -> Skills/Capabilities ---
// UX Researcher
MATCH (r:Role {id: 'role-ux-researcher'}), (s:DesignSkill {id: 'ds-qual-analysis'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ux-researcher'}), (s:DesignSkill {id: 'ds-user-interviews'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ux-researcher'}), (s:DesignSkill {id: 'ds-usability-testing'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ux-researcher'}), (s:DesignSkill {id: 'ds-affinity-diag'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(s);
MATCH (r:Role {id: 'role-ux-researcher'}), (s:DesignSkill {id: 'ds-persona-creation'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(s);
MATCH (r:Role {id: 'role-ux-researcher'}), (s:DesignSkill {id: 'ds-journey-mapping'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(s);
MATCH (r:Role {id: 'role-ux-researcher'}), (s:DesignSkill {id: 'ds-stakeholder-pres'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(s);
MATCH (r:Role {id: 'role-ux-researcher'}), (s:DesignSkill {id: 'ds-survey-design'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(s);

// UX Designer
MATCH (r:Role {id: 'role-ux-designer'}), (s:DesignSkill {id: 'ds-wireframing'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ux-designer'}), (s:DesignSkill {id: 'ds-prototyping'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ux-designer'}), (s:DesignSkill {id: 'ds-interaction-design'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ux-designer'}), (s:DesignSkill {id: 'ds-user-flows'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ux-designer'}), (s:DesignSkill {id: 'ds-usability-testing'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(s);
MATCH (r:Role {id: 'role-ux-designer'}), (s:DesignSkill {id: 'ds-design-systems'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(s);

// Visual Designer
MATCH (r:Role {id: 'role-visual-designer'}), (s:DesignSkill {id: 'ds-visual-design'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-visual-designer'}), (s:DesignSkill {id: 'ds-visual-hierarchy'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-visual-designer'}), (s:DesignSkill {id: 'ds-typography'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-visual-designer'}), (s:DesignSkill {id: 'ds-color-theory'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-visual-designer'}), (s:DesignSkill {id: 'ds-brand-design'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(s);

// Content Designer
MATCH (r:Role {id: 'role-content-designer'}), (s:DesignSkill {id: 'ds-content-strategy'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-content-designer'}), (s:DesignSkill {id: 'ds-ux-writing'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-content-designer'}), (s:DesignSkill {id: 'ds-microcopy'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);

// Information Architect
MATCH (r:Role {id: 'role-ia'}), (s:DesignSkill {id: 'ds-info-arch'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ia'}), (s:DesignSkill {id: 'ds-card-sorting'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(s);
MATCH (r:Role {id: 'role-ia'}), (s:DesignSkill {id: 'ds-user-flows'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ia'}), (s:DesignSkill {id: 'ds-systems-thinking'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(s);

// Product Designer
MATCH (r:Role {id: 'role-product-designer'}), (s:DesignSkill {id: 'ds-design-thinking'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-product-designer'}), (s:DesignSkill {id: 'ds-prototyping'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-product-designer'}), (s:DesignSkill {id: 'ds-user-flows'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-product-designer'}), (s:DesignSkill {id: 'ds-visual-design'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(s);
MATCH (r:Role {id: 'role-product-designer'}), (s:DesignSkill {id: 'ds-qual-analysis'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(s);
MATCH (r:Role {id: 'role-product-designer'}), (s:DesignSkill {id: 'ds-cross-functional'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(s);

// AI Design Researcher (target)
MATCH (r:Role {id: 'role-ai-design-researcher'}), (s:DesignSkill {id: 'ds-qual-analysis'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ai-design-researcher'}), (s:DesignSkill {id: 'ds-usability-testing'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ai-design-researcher'}), (a:AICapability {id: 'ai-prompt-eval'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-ai-design-researcher'}), (a:AICapability {id: 'ai-output-assessment'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-ai-design-researcher'}), (a:AICapability {id: 'ai-synthetic-users'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);
MATCH (r:Role {id: 'role-ai-design-researcher'}), (a:AICapability {id: 'ai-tool-proficiency'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-ai-design-researcher'}), (a:AICapability {id: 'ai-ml-literacy'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);
MATCH (r:Role {id: 'role-ai-design-researcher'}), (a:AICapability {id: 'ai-ethics-eval'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);
MATCH (r:Role {id: 'role-ai-design-researcher'}), (a:AICapability {id: 'ai-testing-ai'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);

// AI UX Lead (target)
MATCH (r:Role {id: 'role-ai-ux-lead'}), (s:DesignSkill {id: 'ds-design-thinking'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ai-ux-lead'}), (s:DesignSkill {id: 'ds-stakeholder-pres'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ai-ux-lead'}), (a:AICapability {id: 'ai-ux-ai-patterns'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-ai-ux-lead'}), (a:AICapability {id: 'ai-human-ai-collab'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-ai-ux-lead'}), (a:AICapability {id: 'ai-ml-literacy'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);
MATCH (r:Role {id: 'role-ai-ux-lead'}), (a:AICapability {id: 'ai-prompt-eng'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);
MATCH (r:Role {id: 'role-ai-ux-lead'}), (a:AICapability {id: 'ai-tool-proficiency'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-ai-ux-lead'}), (a:AICapability {id: 'ai-workflow-design'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);

// Conversational UI Designer (target)
MATCH (r:Role {id: 'role-conv-ui-designer'}), (a:AICapability {id: 'ai-conversational-ai'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-conv-ui-designer'}), (a:AICapability {id: 'ai-prompt-eng'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-conv-ui-designer'}), (a:AICapability {id: 'ai-persona-agent'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-conv-ui-designer'}), (a:AICapability {id: 'ai-voice-ai'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);
MATCH (r:Role {id: 'role-conv-ui-designer'}), (s:DesignSkill {id: 'ds-conversational-design'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-conv-ui-designer'}), (s:DesignSkill {id: 'ds-ux-writing'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(s);
MATCH (r:Role {id: 'role-conv-ui-designer'}), (a:AICapability {id: 'ai-ml-literacy'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);

// AI Content Strategist (target)
MATCH (r:Role {id: 'role-ai-content-strategist'}), (s:DesignSkill {id: 'ds-content-strategy'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ai-content-strategist'}), (a:AICapability {id: 'ai-prompt-eng'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-ai-content-strategist'}), (a:AICapability {id: 'ai-content-gen'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-ai-content-strategist'}), (a:AICapability {id: 'ai-prompt-chaining'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);
MATCH (r:Role {id: 'role-ai-content-strategist'}), (a:AICapability {id: 'ai-ethics-eval'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);
MATCH (r:Role {id: 'role-ai-content-strategist'}), (a:AICapability {id: 'ai-personalization'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);

// AI Product Designer (target)
MATCH (r:Role {id: 'role-ai-product-designer'}), (s:DesignSkill {id: 'ds-design-thinking'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ai-product-designer'}), (s:DesignSkill {id: 'ds-prototyping'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ai-product-designer'}), (a:AICapability {id: 'ai-ux-ai-patterns'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-ai-product-designer'}), (a:AICapability {id: 'ai-prompt-eng'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-ai-product-designer'}), (a:AICapability {id: 'ai-ml-literacy'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);
MATCH (r:Role {id: 'role-ai-product-designer'}), (a:AICapability {id: 'ai-gen-ui'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);
MATCH (r:Role {id: 'role-ai-product-designer'}), (a:AICapability {id: 'ai-human-ai-collab'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);

// AI Design Lead (target)
MATCH (r:Role {id: 'role-ai-design-lead'}), (s:DesignSkill {id: 'ds-stakeholder-pres'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ai-design-lead'}), (s:DesignSkill {id: 'ds-design-thinking'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ai-design-lead'}), (s:DesignSkill {id: 'ds-cross-functional'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ai-design-lead'}), (a:AICapability {id: 'ai-human-ai-collab'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-ai-design-lead'}), (a:AICapability {id: 'ai-workflow-design'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-ai-design-lead'}), (a:AICapability {id: 'ai-ux-ai-patterns'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-ai-design-lead'}), (a:AICapability {id: 'ai-ml-literacy'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);
MATCH (r:Role {id: 'role-ai-design-lead'}), (a:AICapability {id: 'ai-model-selection'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);
MATCH (r:Role {id: 'role-ai-design-lead'}), (a:AICapability {id: 'ai-tool-proficiency'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);

// AI Design Engineer (target)
MATCH (r:Role {id: 'role-ai-design-engineer'}), (s:DesignSkill {id: 'ds-front-end-basics'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ai-design-engineer'}), (s:DesignSkill {id: 'ds-prototyping'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ai-design-engineer'}), (a:AICapability {id: 'ai-gen-ui'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-ai-design-engineer'}), (a:AICapability {id: 'ai-prompt-eng'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-ai-design-engineer'}), (a:AICapability {id: 'ai-ml-literacy'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);
MATCH (r:Role {id: 'role-ai-design-engineer'}), (a:AICapability {id: 'ai-automation'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);

// AI Ethics Designer (target)
MATCH (r:Role {id: 'role-ai-ethics-designer'}), (s:DesignSkill {id: 'ds-inclusive-design'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ai-ethics-designer'}), (s:DesignSkill {id: 'ds-accessibility'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(s);
MATCH (r:Role {id: 'role-ai-ethics-designer'}), (a:AICapability {id: 'ai-ethics-eval'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-ai-ethics-designer'}), (a:AICapability {id: 'ai-output-assessment'}) CREATE (r)-[:REQUIRES {importance: 'core'}]->(a);
MATCH (r:Role {id: 'role-ai-ethics-designer'}), (a:AICapability {id: 'ai-ml-literacy'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);
MATCH (r:Role {id: 'role-ai-ethics-designer'}), (a:AICapability {id: 'ai-accessibility-ai'}) CREATE (r)-[:REQUIRES {importance: 'secondary'}]->(a);

// --- LEADS_TO: Career Progression ---
MATCH (r1:Role {id: 'role-ux-researcher'}), (r2:Role {id: 'role-ai-design-researcher'}) CREATE (r1)-[:LEADS_TO {difficulty: 'moderate', typical_months: 3}]->(r2);
MATCH (r1:Role {id: 'role-ux-researcher'}), (r2:Role {id: 'role-ai-ux-lead'}) CREATE (r1)-[:LEADS_TO {difficulty: 'challenging', typical_months: 6}]->(r2);
MATCH (r1:Role {id: 'role-ux-designer'}), (r2:Role {id: 'role-ai-product-designer'}) CREATE (r1)-[:LEADS_TO {difficulty: 'moderate', typical_months: 4}]->(r2);
MATCH (r1:Role {id: 'role-ux-designer'}), (r2:Role {id: 'role-ai-ux-lead'}) CREATE (r1)-[:LEADS_TO {difficulty: 'challenging', typical_months: 6}]->(r2);
MATCH (r1:Role {id: 'role-ux-designer'}), (r2:Role {id: 'role-conv-ui-designer'}) CREATE (r1)-[:LEADS_TO {difficulty: 'moderate', typical_months: 4}]->(r2);
MATCH (r1:Role {id: 'role-visual-designer'}), (r2:Role {id: 'role-ai-product-designer'}) CREATE (r1)-[:LEADS_TO {difficulty: 'challenging', typical_months: 6}]->(r2);
MATCH (r1:Role {id: 'role-visual-designer'}), (r2:Role {id: 'role-ai-design-engineer'}) CREATE (r1)-[:LEADS_TO {difficulty: 'challenging', typical_months: 8}]->(r2);
MATCH (r1:Role {id: 'role-content-designer'}), (r2:Role {id: 'role-ai-content-strategist'}) CREATE (r1)-[:LEADS_TO {difficulty: 'moderate', typical_months: 3}]->(r2);
MATCH (r1:Role {id: 'role-content-designer'}), (r2:Role {id: 'role-conv-ui-designer'}) CREATE (r1)-[:LEADS_TO {difficulty: 'moderate', typical_months: 4}]->(r2);
MATCH (r1:Role {id: 'role-ia'}), (r2:Role {id: 'role-ai-product-designer'}) CREATE (r1)-[:LEADS_TO {difficulty: 'moderate', typical_months: 4}]->(r2);
MATCH (r1:Role {id: 'role-ia'}), (r2:Role {id: 'role-ai-design-engineer'}) CREATE (r1)-[:LEADS_TO {difficulty: 'challenging', typical_months: 6}]->(r2);
MATCH (r1:Role {id: 'role-product-designer'}), (r2:Role {id: 'role-ai-product-designer'}) CREATE (r1)-[:LEADS_TO {difficulty: 'easy', typical_months: 2}]->(r2);
MATCH (r1:Role {id: 'role-product-designer'}), (r2:Role {id: 'role-ai-design-lead'}) CREATE (r1)-[:LEADS_TO {difficulty: 'moderate', typical_months: 4}]->(r2);
MATCH (r1:Role {id: 'role-graphic-designer'}), (r2:Role {id: 'role-ai-product-designer'}) CREATE (r1)-[:LEADS_TO {difficulty: 'challenging', typical_months: 6}]->(r2);

// Cross-target progressions
MATCH (r1:Role {id: 'role-ai-product-designer'}), (r2:Role {id: 'role-ai-design-lead'}) CREATE (r1)-[:LEADS_TO {difficulty: 'moderate', typical_months: 6}]->(r2);
MATCH (r1:Role {id: 'role-ai-design-researcher'}), (r2:Role {id: 'role-ai-ux-lead'}) CREATE (r1)-[:LEADS_TO {difficulty: 'moderate', typical_months: 4}]->(r2);

// --- TEACHES: Courses -> Skills/Capabilities ---
MATCH (c:Course {id: 'course-ixdf-ai-design'}), (a:AICapability {id: 'ai-ml-literacy'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-ixdf-ai-design'}), (a:AICapability {id: 'ai-ux-ai-patterns'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-coursera-prompt'}), (a:AICapability {id: 'ai-prompt-eng'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-coursera-prompt'}), (a:AICapability {id: 'ai-prompt-chaining'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-nngroup-ai-ux'}), (a:AICapability {id: 'ai-ux-ai-patterns'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-nngroup-ai-ux'}), (a:AICapability {id: 'ai-human-ai-collab'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-figma-ai-workshop'}), (a:AICapability {id: 'ai-tool-proficiency'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-figma-ai-workshop'}), (a:AICapability {id: 'ai-gen-ui'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-ml-nontech'}), (a:AICapability {id: 'ai-ml-literacy'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-ai-ethics'}), (a:AICapability {id: 'ai-ethics-eval'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-conv-design'}), (a:AICapability {id: 'ai-conversational-ai'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-conv-design'}), (a:AICapability {id: 'ai-persona-agent'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-midjourney-mastery'}), (a:AICapability {id: 'ai-image-prompting'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-midjourney-mastery'}), (a:AICapability {id: 'ai-tool-proficiency'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-ai-research-methods'}), (a:AICapability {id: 'ai-synthetic-users'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-ai-research-methods'}), (a:AICapability {id: 'ai-testing-ai'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-design-systems-ai'}), (a:AICapability {id: 'ai-gen-ui'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-design-systems-ai'}), (a:AICapability {id: 'ai-automation'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-data-viz-ai'}), (a:AICapability {id: 'ai-data-viz-ai'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-genui-basics'}), (a:AICapability {id: 'ai-gen-ui'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-voice-ai-design'}), (a:AICapability {id: 'ai-voice-ai'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-ai-content-strategy'}), (a:AICapability {id: 'ai-content-gen'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-ai-content-strategy'}), (a:AICapability {id: 'ai-prompt-eng'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-rag-basics'}), (a:AICapability {id: 'ai-rag'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-human-ai-collab'}), (a:AICapability {id: 'ai-human-ai-collab'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-ai-persona-design'}), (a:AICapability {id: 'ai-persona-agent'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-multimodal-ai'}), (a:AICapability {id: 'ai-multimodal'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-ai-accessibility'}), (a:AICapability {id: 'ai-accessibility-ai'}) CREATE (c)-[:TEACHES]->(a);
MATCH (c:Course {id: 'course-prompt-chaining'}), (a:AICapability {id: 'ai-prompt-chaining'}) CREATE (c)-[:TEACHES]->(a);

// --- DEVELOPS: Tools -> AI Capabilities ---
MATCH (t:Tool {id: 'tool-figma-ai'}), (a:AICapability {id: 'ai-gen-ui'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-figma-ai'}), (a:AICapability {id: 'ai-tool-proficiency'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-midjourney'}), (a:AICapability {id: 'ai-image-prompting'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-midjourney'}), (a:AICapability {id: 'ai-prompt-eng'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-dalle'}), (a:AICapability {id: 'ai-image-prompting'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-chatgpt'}), (a:AICapability {id: 'ai-prompt-eng'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-chatgpt'}), (a:AICapability {id: 'ai-content-gen'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-claude'}), (a:AICapability {id: 'ai-prompt-eng'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-claude'}), (a:AICapability {id: 'ai-prompt-chaining'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-adobe-firefly'}), (a:AICapability {id: 'ai-image-prompting'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-adobe-firefly'}), (a:AICapability {id: 'ai-tool-proficiency'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-usertesting-ai'}), (a:AICapability {id: 'ai-synthetic-users'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-usertesting-ai'}), (a:AICapability {id: 'ai-testing-ai'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-maze-ai'}), (a:AICapability {id: 'ai-testing-ai'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-stable-diffusion'}), (a:AICapability {id: 'ai-image-prompting'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-copilot'}), (a:AICapability {id: 'ai-automation'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-v0'}), (a:AICapability {id: 'ai-gen-ui'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-cursor'}), (a:AICapability {id: 'ai-automation'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-framer-ai'}), (a:AICapability {id: 'ai-gen-ui'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-relume'}), (a:AICapability {id: 'ai-gen-ui'}) CREATE (t)-[:DEVELOPS]->(a);
MATCH (t:Tool {id: 'tool-galileo-ai'}), (a:AICapability {id: 'ai-gen-ui'}) CREATE (t)-[:DEVELOPS]->(a);

// ============================================================
// VERIFICATION QUERIES — Run these to confirm the graph loaded
// ============================================================
// MATCH (n) RETURN labels(n)[0] AS type, count(n) AS count ORDER BY count DESC;
// MATCH ()-[r]->() RETURN type(r) AS relationship, count(r) AS count ORDER BY count DESC;
// MATCH (ds:DesignSkill)-[t:TRANSFERS_TO]->(ai:AICapability) RETURN ds.name, t.weight, ai.name ORDER BY t.weight DESC LIMIT 10;
