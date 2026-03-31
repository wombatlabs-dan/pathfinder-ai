require('dotenv').config();
const express = require('express');
const cors = require('cors');
const neo4j = require('neo4j-driver');
const { OpenAI } = require('openai');
const path = require('path');

// RocketRide integration — currently disabled to prevent startup crashes
// Will reconnect when pipeline is running in Antigravity
let rrReady = false;

const initializeRocketRide = () => {
  console.log('RocketRide SDK integration available but not active (start pipeline in Antigravity to enable)');
};

const callRocketRidePipeline = async (currentRole, skills, targetRole) => {
  console.log('RocketRide: pipeline not active, skipping');
  return null;
};

const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

let driver = null;
let neo4jConnected = false;

const initializeNeo4j = async () => {
  try {
    if (!process.env.NEO4J_URI || !process.env.NEO4J_USER || !process.env.NEO4J_PASSWORD) {
      console.log('Neo4j credentials not configured. Using demo mode only.');
      return;
    }

    driver = neo4j.driver(
      process.env.NEO4J_URI,
      neo4j.auth.basic(process.env.NEO4J_USER, process.env.NEO4J_PASSWORD),
      {
        maxConnectionPoolSize: 10,
        disableLosslessIntegers: true,
      }
    );

    await driver.verifyConnectivity();
    neo4jConnected = true;
    console.log('Connected to Neo4j Aura');
  } catch (error) {
    console.error('Neo4j connection failed:', error.message);
    console.log('Falling back to demo mode');
    neo4jConnected = false;
  }
};

const initializeLLM = () => {
  const apiKey = process.env.LLM_API_KEY || process.env.OPENAI_API_KEY;
  const baseURL = process.env.LLM_BASE_URL || 'https://api.openai.com/v1';

  if (!apiKey || apiKey === 'YOUR_GMI_API_KEY_HERE') {
    console.log('LLM API key not configured. Using fallback plan generation.');
    return null;
  }
  console.log(`LLM configured: ${baseURL} (model: ${process.env.LLM_MODEL || 'default'})`);
  return new OpenAI({ apiKey, baseURL });
};

let openaiClient = null; // actually GMI Cloud via OpenAI-compatible SDK

const generateLearningPlan = async (analysis) => {
  if (!openaiClient) {
    return generateFallbackLearningPlan(analysis);
  }

  try {
    const prompt = `You are an expert career coach specializing in AI and design.

Analyze this career transition data and generate a personalized learning plan narrative:

Current Role: ${analysis.currentRole}
Target Role: ${analysis.targetRole}
Current Alignment: ${(analysis.alignment_score * 100).toFixed(1)}%

Skills User Already Has:
${analysis.matched_skills.map(s => `- ${s.name || s.label} (transferable to: ${Array.isArray(s.transfers_to) ? s.transfers_to.join(', ') : s.transfers_to || 'direct match'})`).join('\n')}

Skills/Capabilities User Needs to Develop:
${analysis.gap_skills.map(s => `- ${s.name || s.label}`).join('\n')}

Recommended Courses:
${analysis.recommended_courses.slice(0, 3).map(c => `- ${c.label}`).join('\n')}

Generate a concise, motivating 2-3 paragraph learning plan that:
1. Validates their existing skills and how they transfer to AI design
2. Outlines specific skill gaps and their importance
3. Recommends a clear learning progression
4. Ends with an encouraging note about their career path

Be specific, actionable, and encouraging. Reference actual skills and roles mentioned above.`;

    const response = await openaiClient.chat.completions.create({
      model: process.env.LLM_MODEL || 'deepseek-ai/DeepSeek-R1',
      messages: [{ role: 'user', content: prompt }],
      temperature: 0.7,
      max_tokens: 500,
    });

    return response.choices[0].message.content;
  } catch (error) {
    console.error('OpenAI API error:', error.message);
    return generateFallbackLearningPlan(analysis);
  }
};

const generateFallbackLearningPlan = (analysis) => {
  const currentRoleName = analysis.currentRole.replace('role-', '').replace(/-/g, ' ');
  const targetRoleName = analysis.targetRole.replace('role-', '').replace(/-/g, ' ');
  const alignmentPercent = (analysis.alignment_score * 100).toFixed(1);

  return `Your transition from ${currentRoleName} to ${targetRoleName} is well-positioned with ${alignmentPercent}% skill alignment. Your existing expertise in qualitative research, user analysis, and stakeholder management provides a strong foundation for AI design work.

The key opportunity lies in developing your understanding of AI evaluation methodologies, prompt engineering best practices, and LLM-specific testing frameworks. These capabilities will allow you to apply your research expertise to the unique challenges of AI product design, including bias detection, fairness assessment, and user perception of AI systems.

We recommend starting with foundational AI evaluation courses, then moving to hands-on projects that combine your research methods with AI-specific tools and frameworks. Your journey is highly achievable with focused effort on these 3-4 critical gap areas over the next 3-6 months.`;
};

const queryNeo4j = async (query, params = {}) => {
  if (!neo4jConnected || !driver) {
    throw new Error('Neo4j not connected');
  }

  const session = driver.session();
  try {
    const result = await session.run(query, params);
    return result.records.map(record => record.toObject());
  } finally {
    await session.close();
  }
};

const demoData = {
  roles: [
    { id: 'role-ux-researcher', name: 'UX Researcher', type: 'current' },
    { id: 'role-ai-design-researcher', name: 'AI Design Researcher', type: 'target' },
    { id: 'role-product-designer', name: 'Product Designer', type: 'target' },
    { id: 'role-ai-pm', name: 'AI Product Manager', type: 'target' },
  ],
  skills: [
    { id: 'ds-qual-analysis', label: 'Qualitative Analysis', category: 'Research Methods' },
    { id: 'ds-user-interviews', label: 'User Interviews', category: 'Research Methods' },
    { id: 'ds-usability-testing', label: 'Usability Testing', category: 'Research Methods' },
    { id: 'ds-affinity-diag', label: 'Affinity Diagrams', category: 'Analysis Techniques' },
    { id: 'ds-persona-creation', label: 'Persona Creation', category: 'Analysis Techniques' },
    { id: 'ds-journey-mapping', label: 'Journey Mapping', category: 'Analysis Techniques' },
    { id: 'ds-stakeholder-pres', label: 'Stakeholder Presentation', category: 'Communication' },
    { id: 'ai-prompt-eval', label: 'Prompt Evaluation', category: 'AI Capabilities' },
    { id: 'ai-bias-detect', label: 'Bias Detection', category: 'AI Capabilities' },
    { id: 'ai-fair-assess', label: 'Fairness Assessment', category: 'AI Capabilities' },
    { id: 'ai-llm-testing', label: 'LLM Testing Frameworks', category: 'AI Capabilities' },
    { id: 'ai-output-quality', label: 'Output Quality Evaluation', category: 'AI Capabilities' },
  ],
  sarahAnalysis: {
    currentRole: 'UX Researcher',
    targetRole: 'AI Design Researcher',
    alignment_score: 0.65,
    matched_skills: [
      {
        id: 'ds-qual-analysis',
        label: 'Qualitative Analysis',
        category: 'Research Methods',
        transfers_to: ['ai-prompt-eval', 'ai-output-quality'],
        transfer_confidence: 0.85,
      },
      {
        id: 'ds-user-interviews',
        label: 'User Interviews',
        category: 'Research Methods',
        transfers_to: ['ai-bias-detect'],
        transfer_confidence: 0.75,
      },
      {
        id: 'ds-usability-testing',
        label: 'Usability Testing',
        category: 'Research Methods',
        transfers_to: ['ai-output-quality', 'ai-llm-testing'],
        transfer_confidence: 0.8,
      },
      {
        id: 'ds-stakeholder-pres',
        label: 'Stakeholder Presentation',
        category: 'Communication',
        transfers_to: [],
        transfer_confidence: 0.7,
      },
    ],
    gap_skills: [
      { id: 'ai-bias-detect', label: 'Bias Detection', category: 'AI Capabilities' },
      { id: 'ai-fair-assess', label: 'Fairness Assessment', category: 'AI Capabilities' },
      { id: 'ai-llm-testing', label: 'LLM Testing Frameworks', category: 'AI Capabilities' },
    ],
    recommended_courses: [
      { id: 'course-1', label: 'AI Ethics and Fairness in NLP', provider: 'Coursera', duration: '4 weeks' },
      { id: 'course-2', label: 'Evaluating Large Language Models', provider: 'Fast.ai', duration: '6 weeks' },
      { id: 'course-3', label: 'Responsible AI: Detecting Bias', provider: 'Stanford Online', duration: '3 weeks' },
      { id: 'course-4', label: 'Prompt Engineering for AI Evaluation', provider: 'OpenAI', duration: '2 weeks' },
    ],
    recommended_tools: [
      { id: 'tool-1', label: 'Weights & Biases', type: 'Experiment Tracking' },
      { id: 'tool-2', label: 'SQuAD Dataset', type: 'Evaluation Benchmark' },
      { id: 'tool-3', label: 'Arena Evaluation Framework', type: 'LLM Benchmarking' },
      { id: 'tool-4', label: 'Fairness Indicators', type: 'Bias Detection' },
    ],
    learning_plan_text: `Your transition from UX Researcher to AI Design Researcher is well-positioned with 65% skill alignment. Your expertise in qualitative analysis, user interviews, and usability testing provides a strong foundation for evaluating AI systems. These research methodologies transfer seamlessly to prompt evaluation (85% confidence) and output quality assessment (80% confidence).

The key opportunity lies in developing your understanding of AI-specific fairness and bias detection methodologies. These capabilities will allow you to apply your research expertise to the unique challenges of AI product design, including detecting biases in language models, assessing fairness across different user groups, and understanding how AI systems perform in real-world scenarios.

We recommend starting with foundational AI ethics and fairness courses, then moving to hands-on LLM evaluation projects that combine your research methods with AI-specific testing frameworks. Your journey is highly achievable with focused effort on these 3-4 critical gap areas over the next 3-6 months.`,
    graph_data: {
      nodes: [
        { id: 'role-ux-researcher', label: 'UX Researcher', group: 'Role', color: '#3b82f6' },
        { id: 'role-ai-design-researcher', label: 'AI Design Researcher', group: 'Role', color: '#3b82f6' },
        { id: 'ds-qual-analysis', label: 'Qualitative Analysis', group: 'DesignSkill', color: '#22c55e' },
        { id: 'ds-user-interviews', label: 'User Interviews', group: 'DesignSkill', color: '#22c55e' },
        { id: 'ds-usability-testing', label: 'Usability Testing', group: 'DesignSkill', color: '#22c55e' },
        { id: 'ds-stakeholder-pres', label: 'Stakeholder Presentation', group: 'DesignSkill', color: '#22c55e' },
        { id: 'ai-prompt-eval', label: 'Prompt Evaluation', group: 'AICapability', color: '#ef4444' },
        { id: 'ai-bias-detect', label: 'Bias Detection', group: 'AICapability', color: '#ef4444' },
        { id: 'ai-fair-assess', label: 'Fairness Assessment', group: 'AICapability', color: '#ef4444' },
        { id: 'ai-llm-testing', label: 'LLM Testing Frameworks', group: 'AICapability', color: '#ef4444' },
        { id: 'ai-output-quality', label: 'Output Quality Evaluation', group: 'AICapability', color: '#ef4444' },
        { id: 'course-1', label: 'AI Ethics and Fairness', group: 'Course', color: '#a855f7' },
        { id: 'course-2', label: 'Evaluating LLMs', group: 'Course', color: '#a855f7' },
        { id: 'tool-1', label: 'Weights & Biases', group: 'Tool', color: '#06b6d4' },
        { id: 'tool-4', label: 'Fairness Indicators', group: 'Tool', color: '#06b6d4' },
      ],
      edges: [
        { from: 'role-ux-researcher', to: 'ds-qual-analysis', label: 'has skill' },
        { from: 'role-ux-researcher', to: 'ds-user-interviews', label: 'has skill' },
        { from: 'role-ux-researcher', to: 'ds-usability-testing', label: 'has skill' },
        { from: 'role-ux-researcher', to: 'ds-stakeholder-pres', label: 'has skill' },
        { from: 'role-ai-design-researcher', to: 'ai-prompt-eval', label: 'requires' },
        { from: 'role-ai-design-researcher', to: 'ai-bias-detect', label: 'requires' },
        { from: 'role-ai-design-researcher', to: 'ai-fair-assess', label: 'requires' },
        { from: 'role-ai-design-researcher', to: 'ai-llm-testing', label: 'requires' },
        { from: 'ds-qual-analysis', to: 'ai-prompt-eval', label: 'transfers_to', weight: 0.85, dashes: false },
        { from: 'ds-qual-analysis', to: 'ai-output-quality', label: 'transfers_to', weight: 0.85, dashes: false },
        { from: 'ds-user-interviews', to: 'ai-bias-detect', label: 'transfers_to', weight: 0.75, dashes: false },
        { from: 'ds-usability-testing', to: 'ai-output-quality', label: 'transfers_to', weight: 0.8, dashes: false },
        { from: 'ds-usability-testing', to: 'ai-llm-testing', label: 'transfers_to', weight: 0.8, dashes: false },
        { from: 'ai-prompt-eval', to: 'course-2', label: 'taught_by' },
        { from: 'ai-bias-detect', to: 'course-1', label: 'taught_by' },
        { from: 'ai-fair-assess', to: 'course-1', label: 'taught_by' },
        { from: 'ai-bias-detect', to: 'tool-4', label: 'develops_with' },
        { from: 'ai-fair-assess', to: 'tool-4', label: 'develops_with' },
      ],
    },
  },
};

const getDemoRoles = () => {
  const current = demoData.roles.filter(r => r.type === 'current');
  const target = demoData.roles.filter(r => r.type === 'target');

  return {
    // Replit format
    currentRoles: current.map(r => ({
      id: r.id.replace('role-', ''),
      title: r.name,
      description: `${r.name} role`,
    })),
    targetRoles: target.map(r => ({
      id: r.id.replace('role-', ''),
      title: r.name,
      description: `${r.name} role`,
    })),
    // Original format
    current,
    target,
  };
};

const getDemoSkills = () => {
  const groupedSkills = {};

  demoData.skills.forEach(skill => {
    if (!groupedSkills[skill.category]) {
      groupedSkills[skill.category] = [];
    }
    groupedSkills[skill.category].push(skill);
  });

  return groupedSkills;
};

app.get('/api/roles', async (req, res) => {
  try {
    if (neo4jConnected) {
      const query = `
        MATCH (r:Role)
        RETURN r.id as id, r.name as name, r.type as type, r.description as description
        ORDER BY r.name
      `;
      const records = await queryNeo4j(query);

      // Return in Replit format (currentRoles/targetRoles with title field)
      const grouped = {
        currentRoles: records.filter(r => r.type === 'current').map(r => ({
          id: r.id.replace('role-', ''),
          title: r.name,
          description: r.description || `${r.name} role`,
        })),
        targetRoles: records.filter(r => r.type === 'target').map(r => ({
          id: r.id.replace('role-', ''),
          title: r.name,
          description: r.description || `${r.name} role`,
        })),
        // Also include original format for backward compat with React frontend
        current: records.filter(r => r.type === 'current'),
        target: records.filter(r => r.type === 'target'),
      };

      res.json(grouped);
    } else {
      res.json(getDemoRoles());
    }
  } catch (error) {
    console.error('GET /api/roles error:', error.message);
    res.json(getDemoRoles());
  }
});

app.get('/api/skills', async (req, res) => {
  try {
    if (neo4jConnected) {
      const query = `
        MATCH (s:DesignSkill)
        RETURN s.id as id, s.name as label, s.category as category
        ORDER BY s.category, s.name
      `;
      const records = await queryNeo4j(query);

      const grouped = {};
      records.forEach(skill => {
        if (!grouped[skill.category]) {
          grouped[skill.category] = [];
        }
        grouped[skill.category].push({
          id: skill.id,
          label: skill.label,
        });
      });

      res.json(grouped);
    } else {
      res.json(getDemoSkills());
    }
  } catch (error) {
    console.error('GET /api/skills error:', error.message);
    res.json(getDemoSkills());
  }
});

app.post('/api/analyze', async (req, res) => {
  try {
    const { currentRole, skills, targetRole } = req.body;

    if (!currentRole || !skills || !Array.isArray(skills) || !targetRole) {
      return res.status(400).json({
        error: 'Missing required fields: currentRole, skills (array), targetRole',
      });
    }

    if (!neo4jConnected) {
      return handleDemoAnalysis(currentRole, skills, targetRole, res);
    }

    // Fire RocketRide pipeline in parallel (non-blocking)
    const rocketRidePromise = callRocketRidePipeline(currentRole, skills, targetRole);

    // Primary path: direct Neo4j + LLM analysis
    const analysis = await performGraphAnalysis(currentRole, skills, targetRole);
    const learningPlan = await generateLearningPlan(analysis);

    analysis.narrative = learningPlan;

    // Collect RocketRide result (if it finished in time)
    const rocketRideResult = await rocketRidePromise;
    if (rocketRideResult) {
      analysis.rocketride_enrichment = rocketRideResult;
      console.log('RocketRide enrichment attached to response');
    }

    res.json(analysis);
  } catch (error) {
    console.error('POST /api/analyze error:', error.message);
    const { currentRole, skills, targetRole } = req.body;
    handleDemoAnalysis(currentRole, skills, targetRole, res);
  }
});

const performGraphAnalysis = async (currentRole, userSkills, targetRole) => {
  // 1. Get target role requirements
  const requirementsQuery = `
    MATCH (role:Role {id: $targetRole})-[req:REQUIRES]->(skill)
    RETURN skill.id as id, skill.name as name, labels(skill)[0] as type, req.importance as importance
  `;
  const requirements = await queryNeo4j(requirementsQuery, { targetRole });

  // 2. Get user's skills with TRANSFERS_TO edges and weights
  const transfersQuery = `
    MATCH (s:DesignSkill)
    WHERE s.id IN $skillIds
    OPTIONAL MATCH (s)-[t:TRANSFERS_TO]->(cap:AICapability)
    RETURN s.id as skillId, s.name as skillName, s.category as category,
           cap.id as capId, cap.name as capName, t.weight as weight, t.rationale as rationale
  `;
  const transferRecords = await queryNeo4j(transfersQuery, { skillIds: userSkills });

  // 3. Get current role name
  const roleQuery = `
    MATCH (r1:Role {id: $currentRole}), (r2:Role {id: $targetRole})
    RETURN r1.name as currentRoleName, r2.name as targetRoleName
  `;
  const roleNames = await queryNeo4j(roleQuery, { currentRole, targetRole });
  const currentRoleName = roleNames[0]?.currentRoleName || currentRole;
  const targetRoleName = roleNames[0]?.targetRoleName || targetRole;

  // Build matched skills with transfer info
  const matchedSkillsMap = new Map();
  const transferredCapIds = new Set();
  const transferEdges = [];

  transferRecords.forEach(r => {
    if (!matchedSkillsMap.has(r.skillId)) {
      matchedSkillsMap.set(r.skillId, {
        name: r.skillName,
        weight: r.weight || 0.6,
        current_level: 'Advanced',
        transfers_to: r.capName || '',
      });
    }
    if (r.capId) {
      transferredCapIds.add(r.capId);
      transferEdges.push({
        skillId: r.skillId,
        skillName: r.skillName,
        capId: r.capId,
        capName: r.capName,
        weight: r.weight,
        rationale: r.rationale,
      });
      // Update the matched skill with the highest-weight transfer
      const existing = matchedSkillsMap.get(r.skillId);
      if (r.weight > existing.weight) {
        existing.weight = r.weight;
        existing.transfers_to = r.capName;
      }
    }
  });

  // Build required capabilities sets
  const requiredIds = new Set(requirements.map(r => r.id));
  const userSkillsSet = new Set(userSkills);

  // Identify direct matches (user has the exact skill the role requires)
  const directMatches = requirements.filter(r => userSkillsSet.has(r.id));

  // Identify transfer matches (user has skills that transfer to required capabilities)
  const transferMatches = requirements.filter(r =>
    r.type === 'AICapability' && transferredCapIds.has(r.id)
  );

  // Identify gaps (required but not matched directly or through transfer)
  const coveredIds = new Set([
    ...directMatches.map(r => r.id),
    ...transferMatches.map(r => r.id),
  ]);
  const gapRequirements = requirements.filter(r => !coveredIds.has(r.id));

  // 4. Get courses and tools for gap capabilities
  const gapIds = gapRequirements.map(g => g.id);
  let courses = [];
  let tools = [];

  if (gapIds.length > 0) {
    const coursesQuery = `
      MATCH (c:Course)-[:TEACHES]->(cap)
      WHERE cap.id IN $gapIds
      RETURN DISTINCT c.id as id, c.name as name, c.provider as provider,
             c.duration_weeks as duration_weeks, c.cost as cost, cap.name as forCapability
    `;
    courses = await queryNeo4j(coursesQuery, { gapIds });

    const toolsQuery = `
      MATCH (t:Tool)-[:DEVELOPS]->(cap)
      WHERE cap.id IN $gapIds
      RETURN DISTINCT t.id as id, t.name as name, t.category as category, cap.name as forCapability
    `;
    tools = await queryNeo4j(toolsQuery, { gapIds });
  }

  // Compute alignment score
  const totalRequired = requirements.length;
  const totalCovered = coveredIds.size;
  const alignmentScore = totalRequired > 0 ? totalCovered / totalRequired : 0;

  // Build transfer_skills (skills that partially bridge to capabilities)
  const transferSkills = transferEdges
    .filter(e => coveredIds.has(e.capId))
    .map(e => ({
      name: `${e.skillName} → ${e.capName}`,
      weight: e.weight,
      time_to_proficiency: e.weight >= 0.8 ? '1-2 weeks' : e.weight >= 0.6 ? '2-4 weeks' : '4-6 weeks',
      learning_path: e.rationale || 'Build on existing skills',
    }));

  // Build gap_skills with recommended resources
  const coursesByCapability = {};
  courses.forEach(c => {
    if (!coursesByCapability[c.forCapability]) coursesByCapability[c.forCapability] = [];
    coursesByCapability[c.forCapability].push(`${c.name} (${c.provider}, ${c.duration_weeks}w, ${c.cost})`);
  });

  const gapSkills = gapRequirements.map(g => ({
    name: g.name,
    weight: g.importance === 'core' ? 0.92 : 0.78,
    recommended_resources: coursesByCapability[g.name] || ['Self-guided learning'],
    learning_path: g.importance === 'core' ? 'Priority — start here' : 'Secondary — build on foundations',
    time_to_proficiency: g.importance === 'core' ? '2-3 weeks' : '1-2 weeks',
  }));

  // Build graph_data for vis.js
  const graphNodes = [];
  const graphEdges = [];
  const addedNodeIds = new Set();

  const addNode = (id, label, type, description) => {
    if (!addedNodeIds.has(id)) {
      graphNodes.push({ id, label, type, description });
      addedNodeIds.add(id);
    }
  };

  // Add role nodes
  addNode(currentRole, `${currentRoleName}\n(Current)`, 'target', `Your current role`);
  addNode(targetRole, `${targetRoleName}\n(Target)`, 'target', `Your target role`);

  // Add matched skill nodes (green)
  matchedSkillsMap.forEach((skill, skillId) => {
    addNode(skillId, skill.name, 'matched', `Your skill — transfers to ${skill.transfers_to} (${Math.round(skill.weight * 100)}%)`);
    graphEdges.push({ from: currentRole, to: skillId, type: 'has_skill' });
  });

  // Add transfer capability nodes (orange)
  transferEdges.forEach(e => {
    addNode(e.capId, e.capName, 'transfer', `AI capability — ${e.rationale || 'transferred from ' + e.skillName}`);
    graphEdges.push({ from: e.skillId, to: e.capId, type: 'transfers_to', weight: e.weight });
  });

  // Add edges from transfer capabilities to target role
  transferMatches.forEach(tm => {
    graphEdges.push({ from: tm.id, to: targetRole, type: 'enables' });
  });

  // Add gap capability nodes (red)
  gapRequirements.forEach(g => {
    addNode(g.id, g.name, 'gap', `GAP — ${g.importance} requirement`);
    graphEdges.push({ from: g.id, to: targetRole, type: 'requires' });
  });

  // Add course nodes (purple)
  courses.slice(0, 4).forEach(c => {
    addNode(c.id, c.name, 'course', `${c.provider} — ${c.duration_weeks}w — ${c.cost}`);
    const gapCap = gapRequirements.find(g => g.name === c.forCapability);
    if (gapCap) {
      graphEdges.push({ from: c.id, to: gapCap.id, type: 'teaches' });
    }
  });

  // Add tool nodes (cyan)
  tools.slice(0, 3).forEach(t => {
    addNode(t.id, t.name, 'tool', `${t.category} tool`);
    const gapCap = gapRequirements.find(g => g.name === t.forCapability);
    if (gapCap) {
      graphEdges.push({ from: t.id, to: gapCap.id, type: 'develops' });
    }
  });

  // Compute time estimate
  const totalWeeks = gapSkills.reduce((sum, g) => {
    const weeks = parseInt(g.time_to_proficiency) || 3;
    return sum + weeks;
  }, 0);
  const estimateText = `${totalWeeks} weeks (part-time)`;

  const estimates = {
    total_time: estimateText,
    breakdown: {},
  };
  gapSkills.forEach(g => {
    estimates.breakdown[g.name] = g.time_to_proficiency;
  });

  return {
    currentRole: currentRoleName,
    targetRole: targetRoleName,
    alignment_score: Math.min(alignmentScore, 1.0),
    matched_skills: Array.from(matchedSkillsMap.values()),
    transfer_skills: transferSkills,
    gap_skills: gapSkills,
    recommended_courses: courses.map(c => ({ id: c.id, label: c.name, provider: c.provider, duration: `${c.duration_weeks} weeks` })),
    recommended_tools: tools.map(t => ({ id: t.id, label: t.name, type: t.category })),
    narrative: null, // will be replaced by LLM-generated plan
    estimates,
    graph_data: { nodes: graphNodes, edges: graphEdges },
  };
};

const handleDemoAnalysis = (currentRole, userSkills, targetRole, res) => {
  if (currentRole === 'role-ux-researcher' && targetRole === 'role-ai-design-researcher') {
    return res.json(demoData.sarahAnalysis);
  }

  const matched = demoData.skills.filter(s => userSkills.includes(s.id));
  const allRequired = demoData.skills.slice(7);
  const gaps = allRequired.filter(s => !userSkills.includes(s.id));

  const alignment = Math.min(matched.length / allRequired.length, 1.0);

  const analysis = {
    currentRole,
    targetRole,
    alignment_score: alignment,
    matched_skills: matched.map(s => ({
      ...s,
      transfers_to: [],
      transfer_confidence: 0.75,
    })),
    gap_skills: gaps,
    recommended_courses: demoData.sarahAnalysis.recommended_courses,
    recommended_tools: demoData.sarahAnalysis.recommended_tools,
    learning_plan_text: generateFallbackLearningPlan({
      currentRole,
      targetRole,
      alignment_score: alignment,
      matched_skills: matched,
      gap_skills: gaps,
    }),
    graph_data: {
      nodes: [
        { id: currentRole, label: currentRole.replace('role-', '').replace(/-/g, ' '), group: 'Role', color: '#3b82f6' },
        { id: targetRole, label: targetRole.replace('role-', '').replace(/-/g, ' '), group: 'Role', color: '#3b82f6' },
        ...matched.map(s => ({ id: s.id, label: s.label, group: 'DesignSkill', color: '#22c55e' })),
        ...gaps.map(s => ({ id: s.id, label: s.label, group: 'AICapability', color: '#ef4444' })),
      ],
      edges: [
        ...matched.map(s => ({ from: currentRole, to: s.id, label: 'has skill' })),
        ...gaps.map(s => ({ from: targetRole, to: s.id, label: 'requires', dashes: true })),
      ],
    },
  };

  res.json(analysis);
};

app.get('/api/demo/sarah', async (req, res) => {
  try {
    const sarahAnalysis = {
      ...demoData.sarahAnalysis,
      learning_plan_text: openaiClient
        ? await generateLearningPlan(demoData.sarahAnalysis)
        : demoData.sarahAnalysis.learning_plan_text,
    };
    res.json(sarahAnalysis);
  } catch (error) {
    console.error('GET /api/demo/sarah error:', error.message);
    res.json(demoData.sarahAnalysis);
  }
});

// ============================================================
// Replit frontend endpoints (/api/roles in Replit format, /api/path/compute)
// ============================================================

// Serve Replit static frontend
app.use(express.static(path.resolve(__dirname, '../../pathfinder-homepage')));

app.post('/api/path/compute', async (req, res) => {
  try {
    const { currentRole, targetRole, skills } = req.body;

    if (!currentRole || !targetRole || !skills) {
      return res.status(400).json({ error: 'Missing required fields: currentRole, targetRole, skills' });
    }

    // Map Replit role IDs to Neo4j IDs (add "role-" prefix if missing)
    const neoCurrentRole = currentRole.startsWith('role-') ? currentRole : `role-${currentRole}`;
    const neoTargetRole = targetRole.startsWith('role-') ? targetRole : `role-${targetRole}`;

    // Map Replit skill strings to Neo4j skill IDs
    const skillIdMap = {
      'Qualitative Analysis': 'ds-qual-analysis',
      'User Interviews': 'ds-user-interviews',
      'Usability Testing': 'ds-usability-testing',
      'Journey Mapping': 'ds-journey-mapping',
      'Affinity Diagramming': 'ds-affinity-diag',
      'Persona Creation': 'ds-persona-creation',
      'Stakeholder Presentations': 'ds-stakeholder-pres',
      'Visual Hierarchy': 'ds-visual-hierarchy',
      'Information Architecture': 'ds-info-architecture',
      'Card Sorting': 'ds-card-sorting',
      'Wireframing': 'ds-wireframing',
      'Prototyping': 'ds-prototyping',
      'Design Systems': 'ds-design-systems',
      'Heuristic Evaluation': 'ds-heuristic-eval',
    };
    const neoSkills = skills.map(s => skillIdMap[s] || `ds-${s.toLowerCase().replace(/\s+/g, '-')}`);

    let analysis;
    if (neo4jConnected) {
      // Fire RocketRide pipeline in parallel (non-blocking)
      const rocketRidePromise = callRocketRidePipeline(neoCurrentRole, neoSkills, neoTargetRole);

      analysis = await performGraphAnalysis(neoCurrentRole, neoSkills, neoTargetRole);
      const learningPlan = await generateLearningPlan(analysis);
      analysis.narrative = learningPlan;

      const rocketRideResult = await rocketRidePromise;
      if (rocketRideResult) {
        analysis.rocketride_enrichment = rocketRideResult;
        console.log('RocketRide enrichment attached to /api/path/compute response');
      }
    } else {
      // Fall back to demo data
      analysis = demoData.sarahAnalysis;
    }

    // Transform to Replit frontend format
    const replitResponse = {
      alignmentScore: analysis.alignment_score || 0.65,
      alignmentMessage: `Your ${skills.length} design skills provide a ${Math.round((analysis.alignment_score || 0.65) * 100)}% foundation for this transition.`,
      summary: analysis.narrative || analysis.learning_plan_text || 'Your design skills transfer well to this AI-augmented role.',
      transferableSkills: (analysis.matched_skills || []).map(s => ({
        skill: s.name || s.label,
        transfersTo: s.transfers_to || 'AI capability',
        transferWeight: s.weight || s.transfer_confidence || 0.75,
        currentLevel: s.current_level || 'Advanced',
      })),
      skillGaps: (analysis.gap_skills || []).map(s => ({
        skill: s.name || s.label,
        priority: s.weight >= 0.9 ? 'critical' : 'important',
        estimatedWeeks: parseInt(s.time_to_proficiency) || 4,
        description: s.learning_path || `Develop ${s.name || s.label} to strengthen your AI design capabilities`,
        resources: (s.recommended_resources || []).map(r => ({
          title: typeof r === 'string' ? r : r.name,
          url: typeof r === 'string' ? null : r.url,
          type: 'course',
        })),
      })),
      learningPlan: analysis.narrative || analysis.learning_plan_text || '',
      totalWeeks: analysis.estimates?.total_time ? parseInt(analysis.estimates.total_time) : 12,
    };

    res.json(replitResponse);
  } catch (error) {
    console.error('POST /api/path/compute error:', error.message);
    res.status(500).json({ error: 'Analysis failed', message: error.message });
  }
});

app.get('/api/health', (req, res) => {
  res.json({
    status: 'ok',
    neo4j_connected: neo4jConnected,
    openai_available: !!openaiClient,
    rocketride_ready: rrReady,
    environment: process.env.NODE_ENV || 'development',
  });
});

// SPA catch-all: serve index.html for non-API routes (client-side routing)
app.get('*', (req, res, next) => {
  if (req.path.startsWith('/api/')) return next();
  res.sendFile(path.resolve(__dirname, '../../pathfinder-homepage/index.html'));
});

app.use((err, req, res, next) => {
  console.error('Unhandled error:', err);
  res.status(500).json({
    error: 'Internal server error',
    message: process.env.NODE_ENV === 'development' ? err.message : undefined,
  });
});

const start = async () => {
  await initializeNeo4j();
  openaiClient = initializeLLM();
  await initializeRocketRide();

  app.listen(PORT, () => {
    console.log(`PathFinder API running on http://localhost:${PORT}`);
    console.log(`Neo4j connected: ${neo4jConnected}`);
    console.log(`LLM available: ${!!openaiClient}`);
    console.log(`RocketRide ready: ${rrReady}`);
    console.log(`Demo endpoint available at http://localhost:${PORT}/api/demo/sarah`);
  });
};

start().catch(error => {
  console.error('Failed to start server:', error);
  process.exit(1);
});

// Prevent unhandled rejections from crashing the server
process.on('unhandledRejection', (reason) => {
  console.log('Unhandled rejection (non-fatal):', reason?.message || reason);
});

process.on('SIGINT', async () => {
  if (driver) {
    await driver.close();
  }
  process.exit(0);
});
