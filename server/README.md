# PathFinder Backend API

Node.js Express backend for the PathFinder AI Design Navigator hackathon project. Connects to Neo4j Aura for knowledge graph queries and uses OpenAI for personalized learning plan generation.

## Setup

### Installation

```bash
npm install
```

### Configuration

Copy `.env.example` to `.env` and fill in your credentials:

```bash
cp .env.example .env
```

Required environment variables:
- `NEO4J_URI` - Neo4j Aura connection URI (neo4j+s://...)
- `NEO4J_USER` - Neo4j username (default: neo4j)
- `NEO4J_PASSWORD` - Neo4j password
- `OPENAI_API_KEY` - OpenAI API key for plan generation
- `PORT` - Server port (default: 3001)

### Running the Server

```bash
npm start
```

The server will attempt to connect to Neo4j. If Neo4j is unavailable, it gracefully falls back to demo mode using built-in demo data.

## API Endpoints

### GET /api/roles

Returns all available roles grouped by type (current vs target career stages).

**Response:**
```json
{
  "current": [
    { "id": "role-ux-researcher", "name": "UX Researcher", "type": "current" }
  ],
  "target": [
    { "id": "role-ai-design-researcher", "name": "AI Design Researcher", "type": "target" }
  ]
}
```

### GET /api/skills

Returns all design skills and AI capabilities grouped by category.

**Response:**
```json
{
  "Research Methods": [
    { "id": "ds-qual-analysis", "label": "Qualitative Analysis" }
  ],
  "AI Capabilities": [
    { "id": "ai-prompt-eval", "label": "Prompt Evaluation" }
  ]
}
```

### POST /api/analyze

Core endpoint that analyzes career transition readiness and generates personalized learning paths.

**Request:**
```json
{
  "currentRole": "role-ux-researcher",
  "skills": [
    "ds-qual-analysis",
    "ds-user-interviews",
    "ds-usability-testing",
    "ds-affinity-diag",
    "ds-persona-creation",
    "ds-journey-mapping",
    "ds-stakeholder-pres"
  ],
  "targetRole": "role-ai-design-researcher"
}
```

**Response:**
```json
{
  "currentRole": "role-ux-researcher",
  "targetRole": "role-ai-design-researcher",
  "alignment_score": 0.65,
  "matched_skills": [
    {
      "id": "ds-qual-analysis",
      "label": "Qualitative Analysis",
      "category": "Research Methods",
      "transfers_to": ["ai-prompt-eval", "ai-output-quality"],
      "transfer_confidence": 0.85
    }
  ],
  "gap_skills": [
    {
      "id": "ai-bias-detect",
      "label": "Bias Detection",
      "category": "AI Capabilities"
    }
  ],
  "recommended_courses": [
    {
      "id": "course-1",
      "label": "AI Ethics and Fairness in NLP",
      "provider": "Coursera",
      "duration": "4 weeks"
    }
  ],
  "recommended_tools": [
    {
      "id": "tool-1",
      "label": "Weights & Biases",
      "type": "Experiment Tracking"
    }
  ],
  "learning_plan_text": "Your transition from UX Researcher to AI Design Researcher...",
  "graph_data": {
    "nodes": [
      {
        "id": "role-ux-researcher",
        "label": "UX Researcher",
        "group": "Role",
        "color": "#3b82f6"
      },
      {
        "id": "ds-qual-analysis",
        "label": "Qualitative Analysis",
        "group": "DesignSkill",
        "color": "#22c55e"
      }
    ],
    "edges": [
      {
        "from": "role-ux-researcher",
        "to": "ds-qual-analysis",
        "label": "has skill"
      },
      {
        "from": "ds-qual-analysis",
        "to": "ai-prompt-eval",
        "label": "transfers_to",
        "weight": 0.85,
        "dashes": false
      }
    ]
  }
}
```

**Analysis Details:**
- `alignment_score`: Percentage of target role requirements user can fulfill (0.0 - 1.0)
- `matched_skills`: User's current skills that apply to target role
- `transfers_to`: Array of AI capabilities that each matched skill can transfer to
- `transfer_confidence`: How reliably the skill transfers (0.7 - 0.9)
- `gap_skills`: Capabilities user needs to develop
- `recommended_courses`: Courses that teach gap capabilities
- `recommended_tools`: Tools that help develop gap capabilities
- `learning_plan_text`: AI-generated personalized learning narrative
- `graph_data`: Nodes and edges for vis.js visualization with color coding:
  - Green (#22c55e): User's matched skills
  - Orange (#f97316): Transfer connections
  - Red (#ef4444): Gap skills/capabilities
  - Blue (#3b82f6): Roles and requirements
  - Purple (#a855f7): Courses
  - Cyan (#06b6d4): Tools

### GET /api/demo/sarah

Pre-computed analysis demonstrating Sarah's transition from UX Researcher to AI Design Researcher (65% alignment). Perfect for hackathon demos without Neo4j.

**Response:** Complete analysis object matching Sarah's scenario with realistic data.

### GET /api/health

Health check endpoint that reports server status and connection states.

**Response:**
```json
{
  "status": "ok",
  "neo4j_connected": true,
  "openai_available": true,
  "environment": "development"
}
```

## Implementation Details

### Architecture

- **Neo4j Connection**: Connects to Neo4j Aura with automatic fallback to demo mode if unavailable
- **Graph Queries**: Performs complex path analysis on knowledge graph to find skill transfers
- **LLM Integration**: Uses OpenAI GPT-4 to generate personalized learning plans
- **Graceful Degradation**: Falls back to pre-computed demo data and rule-based plan generation if OpenAI unavailable

### Analysis Algorithm

1. Fetch all requirements for target role (both DesignSkills and AICapabilities)
2. Check which requirements user already has from their skills list
3. Find TRANSFERS_TO edges from user's matched skills to required AI capabilities
4. Identify gap skills/capabilities not covered by user or transfers
5. Find courses that TEACH the gap capabilities
6. Find tools that DEVELOP the gap capabilities
7. Calculate alignment percentage: (direct matches + transfers) / total requirements
8. Generate personalized learning plan using OpenAI API
9. Build visualization graph with proper color coding

### Color Coding for Visualization

- **Green (#22c55e)**: User's existing matched skills
- **Orange (#f97316)**: Skill transfer connections (dashed edges)
- **Red (#ef4444)**: Gap skills/capabilities user needs to develop
- **Blue (#3b82f6)**: Roles and direct requirements
- **Purple (#a855f7)**: Learning resources (courses)
- **Cyan (#06b6d4)**: Development tools

### Demo Data

Built-in Sarah scenario includes:
- Current role: UX Researcher with 7 skills
- Target role: AI Design Researcher requiring 5 AI capabilities
- Alignment: 65% (4 matched + 1 transferable = 5 covered / 5 required, capped at 1.0)
- Transfer mappings:
  - Qualitative Analysis → Prompt Evaluation (0.85 confidence)
  - User Interviews → Bias Detection (0.75 confidence)
  - Usability Testing → Output Quality Evaluation & LLM Testing (0.8 confidence)
- 4 recommended courses and 4 development tools
- Complete visualization graph with 14 nodes and 17 edges

## Error Handling

- Invalid request parameters return 400 Bad Request
- Neo4j connection failures automatically trigger demo mode fallback
- OpenAI API failures use rule-based plan generation
- All errors are logged to console
- Production mode suppresses error details in responses

## Deployment

For production:
1. Set `NODE_ENV=production`
2. Ensure all environment variables are configured
3. Use a process manager (PM2) to manage the server
4. Enable CORS only for allowed frontend domains
5. Add rate limiting for /api/analyze endpoint
6. Monitor Neo4j connection health with periodic health checks

## Development

For local development:
1. Configure `.env` with Neo4j Aura credentials (or leave empty for demo mode)
2. Add OpenAI key to `.env` for plan generation testing
3. Run `npm start` - server starts on port 3001
4. Test endpoints with curl or Postman
5. Check `/api/health` endpoint to verify connections

## License

MIT
