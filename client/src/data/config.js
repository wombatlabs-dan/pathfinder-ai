// Role and skill IDs match the Neo4j seed data exactly

export const ROLES = [
  // Current roles
  { id: 'role-ux-researcher', label: 'UX Researcher', type: 'current' },
  { id: 'role-ux-designer', label: 'UX Designer', type: 'current' },
  { id: 'role-visual-designer', label: 'Visual Designer', type: 'current' },
  { id: 'role-content-designer', label: 'Content Designer', type: 'current' },
  { id: 'role-ia', label: 'Information Architect', type: 'current' },
  { id: 'role-product-designer', label: 'Product Designer', type: 'current' },
  { id: 'role-graphic-designer', label: 'Graphic Designer', type: 'current' },

  // Target AI-augmented roles
  { id: 'role-ai-design-researcher', label: 'AI Design Researcher', type: 'target' },
  { id: 'role-ai-ux-lead', label: 'AI UX Lead', type: 'target' },
  { id: 'role-conv-ui-designer', label: 'Conversational UI Designer', type: 'target' },
  { id: 'role-ai-content-strategist', label: 'AI Content Strategist', type: 'target' },
  { id: 'role-ai-product-designer', label: 'AI Product Designer', type: 'target' },
  { id: 'role-ai-design-lead', label: 'AI Design Lead', type: 'target' },
  { id: 'role-ai-design-engineer', label: 'AI Design Engineer', type: 'target' },
  { id: 'role-ai-ethics-designer', label: 'AI Ethics Designer', type: 'target' },
];

export const SKILLS_BY_CATEGORY = {
  'Research': [
    { id: 'ds-qual-analysis', label: 'Qualitative Analysis' },
    { id: 'ds-user-interviews', label: 'User Interviews' },
    { id: 'ds-usability-testing', label: 'Usability Testing' },
    { id: 'ds-affinity-diag', label: 'Affinity Diagramming' },
    { id: 'ds-persona-creation', label: 'Persona Creation' },
    { id: 'ds-survey-design', label: 'Survey Design' },
    { id: 'ds-heuristic-eval', label: 'Heuristic Evaluation' },
    { id: 'ds-a-b-testing', label: 'A/B Testing' },
    { id: 'ds-quant-analysis', label: 'Quantitative Analysis' },
    { id: 'ds-ethnography', label: 'Ethnographic Research' },
    { id: 'ds-competitive-analysis', label: 'Competitive Analysis' },
    { id: 'ds-analytics-interpret', label: 'Analytics Interpretation' },
  ],
  'Visual': [
    { id: 'ds-visual-design', label: 'Visual Design' },
    { id: 'ds-visual-hierarchy', label: 'Visual Hierarchy' },
    { id: 'ds-wireframing', label: 'Wireframing' },
    { id: 'ds-prototyping', label: 'Prototyping' },
    { id: 'ds-typography', label: 'Typography' },
    { id: 'ds-color-theory', label: 'Color Theory' },
    { id: 'ds-iconography', label: 'Iconography' },
    { id: 'ds-motion-design', label: 'Motion Design' },
    { id: 'ds-illustration', label: 'Illustration' },
    { id: 'ds-data-viz', label: 'Data Visualization' },
    { id: 'ds-3d-design', label: '3D Design' },
    { id: 'ds-storyboarding', label: 'Storyboarding' },
  ],
  'Content': [
    { id: 'ds-content-strategy', label: 'Content Strategy' },
    { id: 'ds-ux-writing', label: 'UX Writing' },
    { id: 'ds-microcopy', label: 'Microcopy Writing' },
    { id: 'ds-conversational-design', label: 'Conversational Design' },
    { id: 'ds-voice-ui', label: 'Voice UI Design' },
  ],
  'Structure': [
    { id: 'ds-info-arch', label: 'Information Architecture' },
    { id: 'ds-design-systems', label: 'Design Systems' },
    { id: 'ds-responsive-design', label: 'Responsive Design' },
    { id: 'ds-accessibility', label: 'Accessibility Design' },
    { id: 'ds-user-flows', label: 'User Flow Design' },
  ],
  'Process': [
    { id: 'ds-design-thinking', label: 'Design Thinking' },
    { id: 'ds-service-design', label: 'Service Design' },
    { id: 'ds-systems-thinking', label: 'Systems Thinking' },
    { id: 'ds-rapid-prototyping', label: 'Rapid Prototyping' },
    { id: 'ds-design-ops', label: 'DesignOps' },
    { id: 'ds-inclusive-design', label: 'Inclusive Design' },
  ],
  'Communication': [
    { id: 'ds-stakeholder-pres', label: 'Stakeholder Presentations' },
    { id: 'ds-workshop-facil', label: 'Workshop Facilitation' },
    { id: 'ds-cross-functional', label: 'Cross-functional Collaboration' },
    { id: 'ds-design-critique', label: 'Design Critique' },
    { id: 'ds-journey-mapping', label: 'Journey Mapping' },
  ],
  'Technical': [
    { id: 'ds-front-end-basics', label: 'Front-end Basics (HTML/CSS/JS)' },
    { id: 'ds-photo-editing', label: 'Photo Editing' },
    { id: 'ds-brand-design', label: 'Brand Design' },
    { id: 'ds-interaction-design', label: 'Interaction Design' },
    { id: 'ds-card-sorting', label: 'Card Sorting' },
  ],
};

export const ROLE_SKILL_MAPPING = {
  'role-ux-researcher': [
    'ds-qual-analysis', 'ds-user-interviews', 'ds-usability-testing',
    'ds-affinity-diag', 'ds-persona-creation', 'ds-journey-mapping',
    'ds-stakeholder-pres', 'ds-survey-design',
  ],
  'role-ux-designer': [
    'ds-wireframing', 'ds-prototyping', 'ds-interaction-design',
    'ds-user-flows', 'ds-usability-testing', 'ds-design-systems',
  ],
  'role-visual-designer': [
    'ds-visual-design', 'ds-visual-hierarchy', 'ds-typography',
    'ds-color-theory', 'ds-brand-design',
  ],
  'role-content-designer': [
    'ds-content-strategy', 'ds-ux-writing', 'ds-microcopy',
  ],
  'role-ia': [
    'ds-info-arch', 'ds-card-sorting', 'ds-user-flows', 'ds-systems-thinking',
  ],
  'role-product-designer': [
    'ds-design-thinking', 'ds-prototyping', 'ds-user-flows',
    'ds-visual-design', 'ds-qual-analysis', 'ds-cross-functional',
  ],
  'role-graphic-designer': [
    'ds-visual-design', 'ds-typography', 'ds-color-theory',
    'ds-illustration', 'ds-brand-design', 'ds-photo-editing',
  ],
};

// All skills flat list
export const ALL_SKILLS = Object.values(SKILLS_BY_CATEGORY).flat();

export const SKILL_MAP = ALL_SKILLS.reduce((acc, skill) => {
  acc[skill.id] = skill.label;
  return acc;
}, {});
