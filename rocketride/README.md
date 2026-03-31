# PathFinder AI Pipeline for RocketRide

This directory contains the complete RocketRide AI pipeline configuration for PathFinder, a skill gap analysis system that leverages Neo4j knowledge graphs and LLM reasoning to generate personalized career development plans.

## Overview

The PathFinder pipeline is a 6-node AI workflow that:
1. Ingests user input (current role, skills, target role)
2. Normalizes free-text skills to canonical knowledge graph IDs
3. Queries Neo4j to find current position in the skill graph
4. Queries Neo4j to determine target role requirements
5. Analyzes skill gaps and identifies learning paths
6. Generates a personalized, actionable learning plan

**Total Pipeline Execution Time**: ~15-30 seconds (depending on Neo4j query complexity and LLM latency)

## Files Included

### Pipeline Configuration
- **`pathfinder-pipeline.json`** - Main pipeline definition in JSON format (RocketRide native)
- **`pathfinder-pipeline.yaml`** - Same pipeline in YAML format (alternative format)

### Prompts
- **`prompts/skill-normalizer.md`** - System prompt for Node 2 (LLM-based skill normalization)
- **`prompts/plan-generator.md`** - System prompt for Node 6 (LLM-based plan generation)

### Documentation
- **`README.md`** - This file

## Quick Start

### 1. Import Pipeline into RocketRide VS Code Extension

1. Open VS Code with the RocketRide AI extension installed
2. Open the RocketRide sidebar (icon varies by version)
3. Click "Import Pipeline" or "Load Pipeline"
4. Choose `pathfinder-pipeline.json` from this directory
5. The pipeline will appear in the RocketRide visual editor

Alternatively, if your version supports YAML:
- Use `pathfinder-pipeline.yaml` instead of the JSON version

### 2. Configure Environment Variables

The pipeline requires several environment variables/secrets. Set these in RocketRide's settings or configuration panel:

#### Neo4j Configuration
These connect to your PathFinder Neo4j knowledge graph:

```
NEO4J_HOST=bolt://localhost:7687
NEO4J_USER=neo4j
NEO4J_PASSWORD=<your-password>
```

**Required Neo4j Details:**
- Host should be the bolt:// connection string (protocol required)
- User is typically `neo4j` (default)
- Password is what you set during Neo4j installation
- Database: `neo4j` (default, can be modified in node config if needed)

**Testing Connection:**
```bash
# Using neo4j-cli (if installed)
cypher-shell -a bolt://localhost:7687 -u neo4j -p <password> "RETURN 'Connection successful'"
```

#### LLM Configuration
These configure the language model for skill normalization and plan generation:

```
LLM_API_KEY=<your-api-key>
LLM_MODEL=gpt-4
LLM_API_ENDPOINT=https://api.openai.com/v1
```

**Supported Models:**
- OpenAI: `gpt-4`, `gpt-4-turbo`, `gpt-3.5-turbo`
- Anthropic: `claude-3-opus`, `claude-3-sonnet`
- Other: Adjust `LLM_API_ENDPOINT` for alternative providers

**Getting API Keys:**
- OpenAI: https://platform.openai.com/api-keys
- Anthropic: https://console.anthropic.com/
- Others: Consult your provider's documentation

### 3. Configure Neo4j Knowledge Graph

Before running the pipeline, ensure your Neo4j database contains:

**Required Node Types:**
- `Role` - Career roles (e.g., "Product Designer", "Senior Frontend Engineer")
- `Skill` - Skills from the canonical skill list
- `Concept` - Prerequisite concepts
- `Level` - Proficiency levels (Beginner, Intermediate, Advanced, Expert)
- `Course` - Learning resources
- `Tool` - Tools and technologies

**Required Relationship Types:**
- `REQUIRES` - Role requires Skill (with `priority` and `importance` properties)
- `TRANSFERS_TO` - Skill transfers to another skill (with `weight` property)
- `REQUIRES_KNOWLEDGE` - Skill requires Concept
- `HAS_LEVEL` - Skill has a Level
- `TEACHES` - Course teaches Skill
- `DEVELOPS` - Tool develops Skill

**Example Neo4j Setup:**
```cypher
// Create a skill
CREATE (s:Skill {id: "skill:react:012", name: "React.js", level: "intermediate"})

// Create a role
CREATE (r:Role {id: "role:frontend-engineer:001", name: "Frontend Engineer", description: "Build user-facing web applications"})

// Link role to skill requirement
CREATE (r)-[:REQUIRES {priority: 1, importance: 0.9}]->(s)

// Create a course that teaches the skill
CREATE (c:Course {id: "course:react-deep-dive:001", name: "React Deep Dive", durationHours: 20})
CREATE (c)-[:TEACHES]->(s)

// Create a transfer relationship
CREATE (s)-[:TRANSFERS_TO {weight: 0.8}]->(s2:Skill {id: "skill:vue:013", name: "Vue.js"})
```

For a complete schema, see the Neo4j Cypher scripts in your PathFinder repository's `database/` directory.

### 4. Run the Pipeline

#### Via RocketRide UI
1. In RocketRide, click "Run Pipeline"
2. A modal will appear for Node 1 (Input Parser)
3. Fill in required fields:
   - **Current Role**: Your current job title (e.g., "Junior Designer")
   - **Current Skills**: List skills you have (comma-separated or array format)
   - **Target Role**: Where you want to go (e.g., "Senior UX Designer")
   - **Timeline (optional)**: Months you want to achieve this (e.g., 6)
   - **Learning Style (optional)**: self-paced, mentored, structured-course, or mixed

4. Click "Execute"
5. Watch the pipeline progress through all 6 nodes
6. Final output will display in Node 6's output panel

#### Via API/Script
```bash
curl -X POST http://localhost:8080/rocketride/pipelines/pathfinder-pipeline/run \
  -H "Content-Type: application/json" \
  -d '{
    "currentRole": "UX Designer",
    "currentSkills": ["user research", "wireframing", "prototyping"],
    "targetRole": "Product Manager",
    "timelineMonths": 6,
    "learningStyle": "structured-course"
  }'
```

## Node Details

### Node 1: Input Parser

**Type**: `input`
**Description**: Validates and structures user input

**Input**: User-provided form data
**Output**: `parsedInput` object with validated fields

**Validation Rules:**
- `currentRole`: 1-100 characters, required
- `currentSkills`: Array with 1+ items, required
- `targetRole`: 1-100 characters, required
- `timelineMonths`: 1-60 months, optional
- `learningStyle`: One of {self-paced, mentored, structured-course, mixed}, optional

### Node 2: Skill Normalizer

**Type**: `llm`
**Description**: Uses Claude/GPT to normalize free-text skills to canonical knowledge graph IDs

**Configuration:**
- **Temperature**: 0.1 (deterministic - same input always produces same output)
- **Max Tokens**: 2,000
- **System Prompt**: From `prompts/skill-normalizer.md`

**Input**:
- `parsedInput` from Node 1
- Mapping table of skill names to IDs (built into config)

**Output**:
- `normalizedCurrentSkills`: Array of normalized skills with:
  - `originalText`: User's input
  - `canonicalId`: Skill ID from graph (e.g., "skill:react:012")
  - `canonicalName`: Human-readable skill name
  - `confidence`: 0.0-1.0 confidence score
  - `isPrimary`: Boolean indicating if primary or secondary match
  - `alternatives`: Alternative skill matches
  - `reasoning`: Explanation of the mapping

**Example Input:**
```json
{
  "currentRole": "Web Developer",
  "currentSkills": ["JavaScript", "React", "CSS styling", "REST APIs"],
  "targetRole": "Full Stack Engineer"
}
```

**Example Output:**
```json
[
  {
    "originalText": "JavaScript",
    "canonicalId": "skill:javascript:011",
    "canonicalName": "JavaScript Programming",
    "confidence": 0.98,
    "isPrimary": true,
    "reasoning": "Direct match to JavaScript skill"
  },
  {
    "originalText": "React",
    "canonicalId": "skill:react:012",
    "canonicalName": "React.js Framework",
    "confidence": 0.99,
    "isPrimary": true,
    "reasoning": "Explicit React framework mentioned"
  }
]
```

### Node 3: Neo4j Matcher

**Type**: `neo4j_query`
**Description**: Finds user's current position in skill graph

**Cypher Query Logic:**
1. Finds all user's skills in the graph
2. Retrieves TRANSFERS_TO relationships (skill transfer opportunities)
3. Retrieves REQUIRES_KNOWLEDGE prerequisites
4. Returns structured skill mapping

**Input**:
- `normalizedCurrentSkills` from Node 2

**Parameters Extracted**:
- `skillIds`: Array of canonical skill IDs

**Output**:
- `currentSkillGraph`: Array of skills with their graph relationships
  - `skillId`: Canonical ID
  - `skillName`: Human-readable name
  - `skillLevel`: Current proficiency level if known
  - `transfers`: Array of skills this can transfer to with weights
  - `prerequisites`: Prerequisite concepts

**Example Output:**
```json
[
  {
    "skillId": "skill:javascript:011",
    "skillName": "JavaScript Programming",
    "skillLevel": "advanced",
    "transfers": [
      {"targetSkillId": "skill:nodejs:017", "targetSkillName": "Node.js", "weight": 0.85},
      {"targetSkillId": "skill:angular:014", "targetSkillName": "Angular", "weight": 0.7}
    ],
    "prerequisites": []
  }
]
```

**Database Requirements:**
- Skill nodes must exist in Neo4j
- TRANSFERS_TO relationships must have `weight` property
- All skills must have ID properties matching normalized IDs

### Node 4: Target Resolver

**Type**: `neo4j_query`
**Description**: Maps target role to required skills and capabilities

**Cypher Query Logic:**
1. Finds the target role node
2. Retrieves all REQUIRES relationships
3. Gets the required proficiency level for each skill
4. Returns role requirements with priority and importance

**Input**:
- `parsedInput.targetRole` from Node 1

**Parameters Extracted:**
- `targetRole`: String name of desired role

**Output**:
- `targetRoleRequirements`: Object containing:
  - `roleId`: Unique role identifier
  - `roleName`: Role name
  - `roleDescription`: What the role entails
  - `requiredSkills`: Array with:
    - `skillId`: Canonical ID
    - `skillName`: Human-readable name
    - `priority`: Priority level (1=critical, 5=nice-to-have)
    - `importance`: Importance score (0.0-1.0)
    - `requiredLevel`: Proficiency level needed
    - `requiredLevelScore`: Numeric score

**Example Output:**
```json
{
  "roleId": "role:product-manager:001",
  "roleName": "Product Manager",
  "roleDescription": "Define product vision, gather requirements, and drive delivery",
  "requiredSkills": [
    {
      "skillId": "skill:product-mgmt:021",
      "skillName": "Product Management",
      "priority": 1,
      "importance": 0.95,
      "requiredLevel": "Advanced",
      "requiredLevelScore": 4
    },
    {
      "skillId": "skill:communication:023",
      "skillName": "Communication",
      "priority": 1,
      "importance": 0.9,
      "requiredLevel": "Expert",
      "requiredLevelScore": 5
    }
  ]
}
```

**Database Requirements:**
- Role nodes must exist with `name` property matching target role input
- REQUIRES relationships must have `priority` and `importance` properties
- HAS_LEVEL relationships must connect skills to level nodes

### Node 5: Gap Analyzer

**Type**: `neo4j_query`
**Description**: Computes skill gaps and identifies learning paths

**Cypher Query Logic:**
1. Intersects current skills with required skills
2. Identifies skill gaps
3. Finds shortest paths from current to gap skills (via transfers)
4. Identifies courses and tools that address gaps
5. Computes alignment percentage

**Inputs**:
- `currentSkillGraph` from Node 3
- `targetRoleRequirements` from Node 4

**Parameters Extracted:**
- `roleId`: Target role ID
- `requiredSkillIds`: Array of required skill IDs
- `currentSkillIds`: Array of user's current skill IDs

**Output**:
- `gapAnalysisSummary`: Object with:
  - `totalRequired`: Number of required skills
  - `directMatches`: Skills user already has
  - `matchPercentage`: Alignment percentage (0-100)
  - `skillGaps`: Number of gaps

- `skillGapDetails`: Array of gap information with:
  - `skillId` / `skillName`: The gap skill
  - `courses`: Courses that teach this skill
  - `tools`: Tools that help develop this skill
  - `shortestPathDistance`: Steps needed via transfers

- `learningPaths`: Paths through the knowledge graph

**Example Output:**
```json
{
  "summary": {
    "totalRequired": 8,
    "directMatches": 3,
    "matchPercentage": 37.5,
    "skillGaps": 5
  },
  "skillGaps": [
    {
      "skillId": "skill:product-mgmt:021",
      "skillName": "Product Management",
      "courses": [
        {"courseId": "course:pm-101", "courseName": "Product Management 101", "duration": 40}
      ],
      "tools": [{"toolId": "tool:jira", "toolName": "Jira", "type": "project-management"}],
      "shortestPathDistance": 2
    }
  ]
}
```

**Database Requirements:**
- APOC library enabled (for `apoc.coll.intersection`, `apoc.coll.subtract`)
- TEACHES relationships connecting courses to skills
- DEVELOPS relationships connecting tools to skills
- Shortest path calculations must work for skill graph traversal

### Node 6: Plan Generator

**Type**: `llm`
**Description**: Generates personalized learning plan

**Configuration:**
- **Temperature**: 0.7 (creative but structured)
- **Max Tokens**: 3,000
- **System Prompt**: From `prompts/plan-generator.md`
- **Output Schema**: Strict JSON schema validation

**Inputs**:
- `parsedInput` from Node 1
- `gapAnalysisSummary` from Node 5
- `skillGapDetails` from Node 5
- `currentSkillGraph` from Node 3
- `targetRoleRequirements` from Node 4

**Output**:
- `learningPlan`: Comprehensive plan object with:
  - `summary`: Executive summary
  - `currentState`: Assessment of current skills
  - `targetState`: Vision of target role
  - `priorities`: Ranked skills to learn (1-5+)
  - `milestones`: Time-based goals with deliverables
  - `learningPathways`: 3 options (fast/balanced/deep)
  - `weeklySchedule`: Time commitment breakdown
  - `commonChallenges`: Expected obstacles + solutions
  - `nextSteps`: Immediate actions
  - `encouragement`: Personalized motivation

**Example Output Structure:**
```json
{
  "summary": "Your transition from UX Designer to Product Manager is achievable in 6-8 months. You already have strong communication and design thinking skills; you'll focus on product strategy, metrics, and business acumen.",
  "currentState": {
    "role": "UX Designer",
    "skillCount": 8,
    "alignmentPercentage": 37.5,
    "strengths": ["Design thinking", "User research", "Communication"],
    "baselineAssessment": "You have foundational design and user-centric thinking skills..."
  },
  "targetState": {
    "role": "Product Manager",
    "estimatedTimelineMonths": 8,
    "description": "As a Product Manager, you'll define product vision, make strategic decisions, and drive delivery of features that solve customer problems."
  },
  "priorities": [
    {
      "rank": 1,
      "skill": "Product Management",
      "skillId": "skill:product-mgmt:021",
      "importance": "Critical foundation for the role",
      "rationale": "This is the core competency...",
      "currentLevel": "Beginner",
      "targetLevel": "Advanced",
      "timeEstimate": "3-4 months",
      "learningApproach": "Structured courses + real projects",
      "resources": [
        {
          "type": "course",
          "name": "Product Management 101",
          "duration": "6 weeks",
          "difficulty": "intermediate",
          "why": "Comprehensive foundation in PM fundamentals"
        }
      ],
      "transferSkills": ["Strategic thinking", "Communication"]
    }
  ],
  "milestones": [
    {
      "month": 1,
      "description": "Foundation: Complete PM fundamentals",
      "skills": ["Product Management", "Strategic Thinking"],
      "deliverables": ["Completed PM 101 course", "First product strategy document"],
      "successCriteria": ["Can articulate a product vision", "Understand OKR framework"]
    }
  ],
  "nextSteps": [
    "Enroll in Product Management 101 course this week",
    "Read 'Inspired' by Marty Cagan",
    "Find a PM mentor in your network",
    "Join a product management community"
  ],
  "encouragement": "You're making a thoughtful career transition that plays to your strengths. Your user research and design background are actually valuable PM skills; you'll build on them with business and strategy knowledge. This is definitely doable."
}
```

## Pipeline Data Flow

```
Input Parser (Node 1)
    ↓ parsedInput
    ├─→ Skill Normalizer (Node 2)
    │       ↓ normalizedCurrentSkills
    │       └─→ Neo4j Matcher (Node 3)
    │               ↓ currentSkillGraph
    │               └─→ Gap Analyzer (Node 5)
    │                   ↑
    │                   └─ targetRoleRequirements from Node 4
    │
    ├─→ Target Resolver (Node 4)
    │       ↓ targetRoleRequirements
    │       └─→ Gap Analyzer (Node 5)
    │               ↓ gapAnalysisSummary, skillGapDetails
    │               └─→ Plan Generator (Node 6)
    │
    └─→ Plan Generator (Node 6)
            ├─ Input: currentSkillGraph (Node 3)
            ├─ Input: targetRoleRequirements (Node 4)
            ├─ Input: Gap analysis (Node 5)
            └─ Output: learningPlan
```

## Troubleshooting

### Neo4j Connection Failed
**Error**: "Failed to connect to Neo4j at bolt://..."

**Solutions**:
1. Verify Neo4j is running: `neo4j console` or check service status
2. Check the host/port: Default is `localhost:7687` for Bolt protocol
3. Verify credentials: Username and password are correct
4. Check firewall: Neo4j port may be blocked
5. Test connection: Use `cypher-shell` with same credentials

### LLM API Error
**Error**: "OpenAI API key invalid" or "Model not found"

**Solutions**:
1. Verify API key is set and not expired
2. Check model name matches available models for provider
3. Ensure API endpoint is correct for your provider
4. Check API account has quota remaining
5. Review API logs for specific error details

### Skills Not Found in Graph
**Error**: "No matching skills in Neo4j" or "0 skills matched"

**Solutions**:
1. Verify skill nodes exist in Neo4j:
   ```cypher
   MATCH (s:Skill) RETURN count(s)
   ```
2. Check that skill IDs match the canonical format
3. Ensure skills are indexed for performance:
   ```cypher
   CREATE INDEX idx_skill_id FOR (s:Skill) ON (s.id)
   ```
4. Verify Neo4j Matcher's Cypher query parameters are correct
5. Check that normalized skill IDs from Node 2 match graph IDs

### Pipeline Times Out
**Error**: "Pipeline execution exceeded timeout"

**Solutions**:
1. Increase `config.timeout` in pipeline definition (milliseconds)
2. Optimize Neo4j queries: Add indexes on frequently-searched properties
3. Simplify Cypher queries: Reduce result set size
4. Check Neo4j performance: Monitor query execution time
5. Check LLM response time: May be slow due to API load

### Unexpected Results

**Poor skill normalization**:
- Review `prompts/skill-normalizer.md`
- Ensure mapping table includes common skill terms
- Consider adding examples to the prompt

**Incorrect gap analysis**:
- Verify Neo4j data is correct
- Check REQUIRES relationships have proper properties
- Ensure required skills exist for target role

**Weak learning plan**:
- Ensure courses and tools are linked to skills in Neo4j
- Verify `prompts/plan-generator.md` has sufficient context
- Check that gap analysis provides needed details

## Integration Examples

### Python Integration
```python
import requests
import json

def run_pathfinder_pipeline(current_role, skills, target_role):
    """Run the PathFinder pipeline"""
    payload = {
        "currentRole": current_role,
        "currentSkills": skills,
        "targetRole": target_role
    }

    response = requests.post(
        "http://localhost:8080/rocketride/pipelines/pathfinder-pipeline/run",
        json=payload,
        headers={"Authorization": "Bearer YOUR_TOKEN"}
    )

    return response.json()

# Usage
plan = run_pathfinder_pipeline(
    "UX Designer",
    ["user research", "prototyping", "figma"],
    "Product Manager"
)

print(plan["learningPlan"]["summary"])
```

### Node.js Integration
```javascript
const axios = require('axios');

async function runPathFinderPipeline(currentRole, skills, targetRole) {
  try {
    const response = await axios.post(
      'http://localhost:8080/rocketride/pipelines/pathfinder-pipeline/run',
      {
        currentRole,
        currentSkills: skills,
        targetRole
      },
      {
        headers: {
          'Authorization': 'Bearer YOUR_TOKEN'
        }
      }
    );
    return response.data;
  } catch (error) {
    console.error('Pipeline error:', error.message);
  }
}

// Usage
const plan = await runPathFinderPipeline(
  'Frontend Developer',
  ['React', 'JavaScript', 'CSS'],
  'Full Stack Engineer'
);
```

## Advanced Configuration

### Custom Skill Mapping
Edit Node 2's `mappingTable` in the pipeline JSON to add more skills or adjust canonical IDs:

```json
"mappingTable": {
  "my-custom-skill": "skill:custom:999",
  "another-skill": "skill:another:998"
}
```

### Adjusting Temperature
- **Node 2** (Skill Normalizer): Keep at 0.1 for consistency
- **Node 6** (Plan Generator): Can adjust:
  - 0.5-0.6: More structured, consistent plans
  - 0.7-0.8: Balanced creativity and structure (recommended)
  - 0.9+: More creative/varied plans

### Custom Cypher Queries
Modify Neo4j query nodes (3, 4, 5) to adjust graph traversal logic:

```json
"query": "MATCH (s:Skill) WHERE s.id IN $skillIds RETURN s"
```

## Performance Optimization

### Neo4j Optimization
1. Create indexes on frequently-searched properties:
   ```cypher
   CREATE INDEX idx_skill_id FOR (s:Skill) ON (s.id);
   CREATE INDEX idx_role_name FOR (r:Role) ON (r.name);
   ```

2. Use query profiling:
   ```cypher
   PROFILE MATCH (s:Skill) WHERE s.id = "skill:react:012" RETURN s
   ```

3. Partition large graphs by domain

### LLM Optimization
1. Cache common prompts
2. Batch similar requests
3. Use smaller models for simple tasks (e.g., skill normalization)

## Support & Contributing

For issues, questions, or improvements:
1. Check this README and troubleshooting section
2. Review prompt files for configuration options
3. Examine Neo4j database schema
4. Consult RocketRide AI documentation

For contributions:
- Improve prompts based on real results
- Add new node types for additional analysis
- Expand skill mapping table
- Share successful case studies
