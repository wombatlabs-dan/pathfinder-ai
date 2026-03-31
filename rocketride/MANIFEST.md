# PathFinder RocketRide Pipeline - Complete Manifest

## Files Created

### 1. Core Pipeline Files
- **pathfinder-pipeline.json** (19 KB)
  - JSON format pipeline definition
  - 6 nodes with complete configuration
  - All connections defined
  - Variables and config sections
  - Preferred format for RocketRide import

- **pathfinder-pipeline.yaml** (17 KB)
  - YAML format pipeline definition
  - Same content as JSON version
  - Alternative format option

### 2. System Prompts
- **prompts/skill-normalizer.md** (6.1 KB)
  - Comprehensive prompt for Node 2 (LLM-based skill normalization)
  - Includes skill mapping table reference
  - Normalization rules and examples
  - Output format specification

- **prompts/plan-generator.md** (9.4 KB)
  - Comprehensive prompt for Node 6 (LLM-based plan generation)
  - Complete output schema specification
  - Prioritization rules and time estimation guidance
  - Milestone creation guidelines

### 3. Documentation
- **README.md** (22 KB)
  - Complete setup and usage guide
  - Node-by-node documentation
  - Troubleshooting section
  - Integration examples (Python, Node.js)
  - Advanced configuration options
  - Performance optimization tips

- **MANIFEST.md** (this file)
  - Directory structure and file overview

## Pipeline Architecture

### 6-Node Pipeline Flow

```
Node 1: Input Parser (input)
  └─ Validates user input: current role, skills, target role, timeline

Node 2: Skill Normalizer (llm)
  └─ Normalizes free-text skills to canonical knowledge graph IDs
  └─ Uses LLM with mapping table
  └─ Confidence scores and alternatives

Node 3: Neo4j Matcher (neo4j_query)
  └─ Finds user's current position in skill graph
  └─ Retrieves skill transfers and prerequisites

Node 4: Target Resolver (neo4j_query)
  └─ Maps target role to required skills
  └─ Returns priority and importance levels

Node 5: Gap Analyzer (neo4j_query)
  └─ Computes skill gaps and alignment percentage
  └─ Identifies learning paths via skill transfers
  └─ Finds relevant courses and tools

Node 6: Plan Generator (llm)
  └─ Generates personalized learning plan
  └─ Returns priorities, milestones, resources
  └─ Includes encouragement and next steps
```

### Data Flow Connections
- Node 1 → Node 2: parsedInput
- Node 1 → Node 4: parsedInput (target role)
- Node 1 → Node 6: parsedInput (original request)
- Node 2 → Node 3: normalizedCurrentSkills
- Node 3 → Node 5: currentSkillGraph
- Node 4 → Node 5: targetRoleRequirements
- Node 3 → Node 6: currentSkillGraph
- Node 4 → Node 6: targetRoleRequirements
- Node 5 → Node 6: gapAnalysisSummary, skillGapDetails

## Node Types Used

1. **input** (Node 1)
   - Takes user form input
   - Validates schema
   - Outputs parsedInput

2. **llm** (Nodes 2, 6)
   - OpenAI/Anthropic/compatible LLM
   - Configurable temperature
   - Configurable system prompts from file
   - JSON/structured output support

3. **neo4j_query** (Nodes 3, 4, 5)
   - Cypher query execution
   - Parameter transformation
   - Result structuring
   - Uses Neo4j connection config

## Configuration Variables

All variables are configurable in RocketRide settings:

### Neo4j Variables
- `neo4j_host` (default: bolt://localhost:7687)
- `neo4j_user` (default: neo4j)
- `neo4j_password` (sensitive, required)

### LLM Variables
- `llm_api_key` (sensitive, required)
- `llm_model` (default: gpt-4)
- `llm_api_endpoint` (default: https://api.openai.com/v1)

## Skill Mapping Table

The pipeline includes 25 canonical skills across 4 domains:

### Design Skills (9)
- UX Design, UI Design, Prototyping, User Research
- Interaction Design, Visual Design, Information Architecture
- Usability Testing, Accessibility

### Frontend Development (7)
- Frontend Development, JavaScript, React
- Vue.js, Angular, CSS, HTML

### Backend Development (4)
- Node.js, Python, Data Analysis, Machine Learning

### Product & Leadership (5)
- Product Management, Strategic Thinking, Communication
- Leadership, Project Management

## Key Features

### Deterministic Skill Normalization
- Temperature 0.1 ensures consistent normalization
- Mapping table prevents hallucination
- Confidence scores indicate reliability

### Graph-Based Gap Analysis
- Neo4j APOC for set operations
- Shortest path algorithms for transfer routes
- Weighted relationships for skill transfer quality

### Personalized Plan Generation
- Incorporates user's current state
- Considers learning preferences
- Provides multiple pathway options (fast/balanced/deep)
- Includes realistic time estimates and milestones

### Comprehensive Output
- Executive summary
- Skill prioritization with rationale
- Learning resource recommendations
- Milestone tracking
- Challenge anticipation
- Immediate next steps
- Personalized encouragement

## Installation Checklist

- [ ] Copy files to RocketRide pipeline directory
- [ ] Set Neo4j connection variables
- [ ] Set LLM API key and model
- [ ] Verify Neo4j database has required schema
- [ ] Create indexes for performance
- [ ] Test connection to Neo4j
- [ ] Test LLM API access
- [ ] Import pipeline in RocketRide UI
- [ ] Run test execution with sample input

## File Statistics

| File | Lines | Size | Format |
|------|-------|------|--------|
| pathfinder-pipeline.json | 450+ | 19 KB | JSON |
| pathfinder-pipeline.yaml | 420+ | 17 KB | YAML |
| prompts/skill-normalizer.md | 250+ | 6.1 KB | Markdown |
| prompts/plan-generator.md | 380+ | 9.4 KB | Markdown |
| README.md | 800+ | 22 KB | Markdown |

## Total Configuration
- **Lines of code/config**: 2,300+
- **Nodes**: 6
- **Connections**: 10
- **Skills in mapping**: 25
- **Supported roles**: Unlimited (defined in Neo4j)

## Next Steps

1. Review README.md for detailed setup instructions
2. Ensure Neo4j database is properly configured
3. Set environment variables for Neo4j and LLM
4. Import pathfinder-pipeline.json into RocketRide
5. Run test execution
6. Customize prompts as needed for your use case
7. Expand skill mapping and Neo4j schema as domain grows

