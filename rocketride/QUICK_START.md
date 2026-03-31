# PathFinder RocketRide Pipeline - Quick Start Guide

## 30-Second Overview

The PathFinder pipeline is a 6-node AI system that helps professionals plan their career development by:
1. Analyzing their current skills
2. Mapping a target role
3. Finding the gaps
4. Generating a personalized learning plan

Total execution time: ~15-30 seconds

## Files You Have

```
pathfinder-pipeline.json      ← Import this into RocketRide
pathfinder-pipeline.yaml      ← (alternative format)
README.md                     ← Full documentation
MANIFEST.md                   ← File overview
QUICK_START.md               ← This file
prompts/
  ├── skill-normalizer.md    ← LLM prompt for Node 2
  └── plan-generator.md      ← LLM prompt for Node 6
```

## 5-Step Setup

### Step 1: Install Prerequisites
- VS Code with RocketRide AI extension
- Neo4j instance running
- OpenAI API key (or compatible LLM)

### Step 2: Configure Environment Variables
Set these in RocketRide settings or as environment variables:

```bash
NEO4J_HOST=bolt://localhost:7687
NEO4J_USER=neo4j
NEO4J_PASSWORD=your_password

LLM_API_KEY=sk-...
LLM_MODEL=gpt-4
LLM_API_ENDPOINT=https://api.openai.com/v1
```

### Step 3: Import Pipeline
1. Open RocketRide in VS Code
2. Click "Import Pipeline"
3. Select `pathfinder-pipeline.json`
4. Done!

### Step 4: Verify Neo4j
Ensure your Neo4j database has:
- `Skill` nodes with IDs like "skill:react:012"
- `Role` nodes with names like "Product Manager"
- `Course` and `Tool` nodes
- Relationships: REQUIRES, TRANSFERS_TO, TEACHES, DEVELOPS

### Step 5: Run Test
Click "Run Pipeline" and provide sample input:
- Current Role: "UX Designer"
- Current Skills: ["user research", "prototyping", "figma"]
- Target Role: "Product Manager"

## Pipeline Overview

### Node 1: Input Parser
- **What it does**: Validates your input
- **Takes**: Form inputs (role, skills, timeline)
- **Outputs**: Structured parsedInput object

### Node 2: Skill Normalizer (LLM)
- **What it does**: Maps your free-text skills to canonical IDs
- **Takes**: "React", "JavaScript", "CSS styling"
- **Outputs**: ["skill:react:012", "skill:javascript:011", "skill:css:015"]
- **Temperature**: 0.1 (consistent, deterministic)

### Node 3: Neo4j Matcher
- **What it does**: Finds your skills in the knowledge graph
- **Takes**: Skill IDs from Node 2
- **Outputs**: Your current skills + transfer opportunities

### Node 4: Target Resolver
- **What it does**: Lists what the target role requires
- **Takes**: Target role name
- **Outputs**: List of required skills with priorities

### Node 5: Gap Analyzer
- **What it does**: Compares what you have vs. need
- **Takes**: Current skills (Node 3) + Required skills (Node 4)
- **Outputs**: Alignment %, skill gaps, learning resources

### Node 6: Plan Generator (LLM)
- **What it does**: Creates a personalized learning plan
- **Takes**: Everything from previous nodes
- **Outputs**: Detailed plan with priorities, milestones, encouragement
- **Temperature**: 0.7 (creative but structured)

## Sample Output

When you run the pipeline, Node 6 outputs something like:

```json
{
  "summary": "You can transition from UX Designer to Product Manager in 6-8 months. Your research and communication skills are transferable.",
  "currentState": {
    "role": "UX Designer",
    "alignmentPercentage": 37.5,
    "strengths": ["User research", "Communication", "Design thinking"]
  },
  "targetState": {
    "role": "Product Manager",
    "estimatedTimelineMonths": 8
  },
  "priorities": [
    {
      "rank": 1,
      "skill": "Product Management",
      "timeEstimate": "3-4 months",
      "resources": [
        {"name": "Product Management 101", "type": "course"}
      ]
    }
  ],
  "milestones": [
    {
      "month": 1,
      "description": "Master PM fundamentals",
      "deliverables": ["Complete PM 101", "Write first strategy doc"]
    }
  ],
  "encouragement": "Your transition is achievable..."
}
```

## Data Flow Diagram

```
┌─────────────────────────────────────────────────┐
│        Input Parser (Node 1)                     │
│   Current Role, Skills, Target Role, Timeline   │
└────────────────┬────────────────────────────────┘
                 │
        ┌────────┴────────┐
        │                 │
        v                 v
┌───────────────────┐  ┌──────────────────┐
│ Skill Normalizer  │  │ Target Resolver  │
│   (Node 2)        │  │   (Node 4)       │
│ LLM-based mapping │  │ Neo4j query      │
└────────┬──────────┘  └────────┬─────────┘
         │                      │
         v                      v
┌──────────────────┐  ┌──────────────────┐
│ Neo4j Matcher    │  │    (feeds to     │
│  (Node 3)        │  │  Gap Analyzer)   │
│ Find current     │  │                  │
│ position in      │  └────────┬─────────┘
│ skill graph      │           │
└────────┬─────────┘           │
         │                     │
         └──────────┬──────────┘
                    │
                    v
         ┌──────────────────────────┐
         │   Gap Analyzer (Node 5)  │
         │   Neo4j weighted query   │
         │   Align %, gaps, paths   │
         └────────┬─────────────────┘
                  │
                  v
         ┌──────────────────────────┐
         │ Plan Generator (Node 6)  │
         │ LLM generates plan       │
         │ Priorities, timelines,   │
         │ resources, milestones    │
         └──────────────────────────┘
```

## Common Input Examples

### Designer to Product Manager
```
currentRole: "UX Designer"
currentSkills: ["user research", "prototyping", "figma"]
targetRole: "Product Manager"
timelineMonths: 6
```

### Frontend Dev to Full Stack
```
currentRole: "Frontend Developer"
currentSkills: ["React", "JavaScript", "CSS", "HTML"]
targetRole: "Full Stack Engineer"
timelineMonths: 8
```

### Junior Designer to Design Lead
```
currentRole: "Junior Graphic Designer"
currentSkills: ["visual design", "adobe creative suite", "typography"]
targetRole: "Design Director"
timelineMonths: 24
```

## Troubleshooting Quick Fixes

| Problem | Fix |
|---------|-----|
| "Neo4j connection failed" | Check Neo4j is running: `neo4j console` |
| "LLM API key invalid" | Verify key in settings, check provider |
| "No skills matched" | Ensure skill nodes exist in Neo4j graph |
| "Empty results" | Verify Cypher queries work in Neo4j directly |
| "Pipeline timeout" | Increase timeout in config, optimize Neo4j queries |

## Customization Tips

### Add More Skills
Edit `pathfinder-pipeline.json`, Node 2, `mappingTable`:
```json
"my-new-skill": "skill:mynewskill:999"
```

### Adjust Plan Creativity
- Node 2 (Skill Normalizer): Keep temperature at 0.1
- Node 6 (Plan Generator): Increase from 0.7 to 0.8-0.9 for more creativity

### Modify Time Estimates
Edit `prompts/plan-generator.md` section "Time Estimation Guidance"

### Add Domain-Specific Prompts
Create custom prompt files and reference them in node config:
```json
"systemPromptFile": "prompts/my-custom-prompt.md"
```

## Next Steps

1. **For Details**: Read `README.md` (comprehensive guide)
2. **For Architecture**: Read `MANIFEST.md` (technical overview)
3. **For Setup Help**: See README.md "Quick Start" section
4. **For Neo4j Schema**: See README.md "Configure Neo4j Knowledge Graph"
5. **For LLM Config**: See README.md "LLM Configuration"

## Keyboard Shortcuts (RocketRide)

These may vary by extension version:
- `Ctrl+Enter` / `Cmd+Enter`: Run pipeline
- `Ctrl+S` / `Cmd+S`: Save pipeline
- `F1`: Open command palette
- `Ctrl+P` / `Cmd+P`: File quick open

## Support Resources

1. **README.md** - Full documentation
2. **MANIFEST.md** - Technical overview
3. **Node comments** - In-line configuration help
4. **Prompts** - Review system prompts for adjustments

## Performance Expectations

| Metric | Expected |
|--------|----------|
| Input Parsing | <100ms |
| Skill Normalization | 2-5s (LLM call) |
| Neo4j Queries | 1-3s each |
| Plan Generation | 5-10s (LLM call) |
| Total Pipeline | 15-30s |

Network latency and LLM provider load will affect these times.

---

**You're all set!** Import `pathfinder-pipeline.json` and run your first career analysis.
