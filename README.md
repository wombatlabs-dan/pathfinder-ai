# PathFinder: AI Design Navigator

**HackWithBay 2.0 — March 30, 2026**
**Built by Dan Harrison, WombatLabs**

An AI-powered career navigation tool that helps design professionals find their personalized path into AI-augmented roles. Built with Neo4j and RocketRide AI.

---

## Quick Start (Demo in 2 minutes)

### Option A: Frontend only (fastest — no backend needed)

```bash
cd client
npm install
npm start
```

Open http://localhost:3000, click **"Try Sarah's Demo"** — done. The demo runs entirely offline with hardcoded data matching the pitch deck scenario.

### Option B: Full stack with Neo4j

```bash
# Terminal 1: Start the backend
cd server
cp .env.example .env
# Edit .env with your Neo4j Aura credentials and OpenAI API key
npm install
npm start

# Terminal 2: Seed the Neo4j database
# Open Neo4j Aura Browser → paste contents of neo4j/seed.cypher → Run

# Terminal 3: Start the frontend
cd client
npm install
npm start
```

---

## Project Structure

```
pathfinder/
├── README.md              ← You are here
├── neo4j/
│   └── seed.cypher        ← Graph schema + 50 skills, 32 AI capabilities, 15 roles, 20 courses, 15 tools, 55+ TRANSFERS_TO edges
├── server/
│   ├── server.js          ← Express API (5 endpoints, Neo4j driver, OpenAI integration)
│   ├── package.json
│   └── .env.example
├── client/
│   ├── src/
│   │   ├── App.js         ← 3-screen flow: Input → Loading → Results
│   │   ├── App.css        ← Dark theme design system
│   │   ├── components/
│   │   │   ├── Header.js
│   │   │   ├── ProfileInput.js
│   │   │   ├── LoadingScreen.js
│   │   │   ├── PathVisualization.js  ← vis-network graph (the "wow moment")
│   │   │   ├── LearningPlan.js
│   │   │   └── ResultsScreen.js
│   │   └── data/
│   │       ├── config.js   ← Roles, skills, categories
│   │       └── demoData.js ← Sarah's pre-computed demo
│   └── package.json
└── rocketride/
    ├── pathfinder-pipeline.json  ← 6-node RocketRide pipeline
    ├── pathfinder-pipeline.yaml
    ├── prompts/
    │   ├── skill-normalizer.md   ← LLM prompt for skill mapping
    │   └── plan-generator.md     ← LLM prompt for learning plan
    └── README.md
```

---

## How It Works

### The Knowledge Graph (Neo4j)

6 node types: **DesignSkill** (50), **AICapability** (32), **Role** (15), **Tool** (15), **Course** (20), **Certification**

5 relationship types:
- `TRANSFERS_TO` (weighted 0.0–1.0) — the core differentiator. Maps how design skills transfer to AI capabilities.
- `REQUIRES` — what a role needs
- `TEACHES` — what a course covers
- `LEADS_TO` — career progressions between roles
- `DEVELOPS` — what a tool helps you build

### The AI Pipeline (RocketRide)

6 sequential nodes:
1. **Input Parser** — validates user profile
2. **Skill Normalizer** (LLM) — maps free-text to canonical graph IDs
3. **Neo4j Matcher** — locates user in the skill graph
4. **Target Resolver** — maps target role to requirements
5. **Gap Analyzer** — computes optimal path using weighted graph traversal
6. **Plan Generator** (LLM) — creates personalized learning plan

### The Demo Story (Sarah)

Sarah is a UX Researcher with 7 years of experience who wants to become an AI Design Researcher. PathFinder shows her she's already **65% aligned** — her qualitative analysis skills map to prompt evaluation (0.85 weight), her usability testing maps to AI output assessment (0.78), and her affinity diagramming maps to AI taxonomy design (0.72). She has 3 priority gaps to close in ~6 weeks of part-time learning.

---

## Required Technologies

- **Neo4j** — The entire product IS a graph. Shortest-path algorithms compute career paths. TRANSFERS_TO weights quantify skill transferability. Community detection clusters related skills. This is what graph databases were built for.
- **RocketRide AI** — Multi-node intelligence pipeline with 6 substantive nodes. LLM nodes handle skill normalization and plan generation. Neo4j nodes handle graph matching and gap analysis. Models can be swapped without rewriting logic.

---

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | /api/roles | All roles grouped by type |
| GET | /api/skills | All skills grouped by category |
| POST | /api/analyze | Core analysis endpoint |
| GET | /api/demo/sarah | Pre-computed Sarah demo |
| GET | /api/health | Server status |

---

## For Judges

1. **Start the frontend** (`cd client && npm install && npm start`)
2. **Click "Try Sarah's Demo"** to see the full experience
3. **Explore the graph visualization** — this is the product's core value prop
4. **Review `neo4j/seed.cypher`** to see the graph data model
5. **Review `rocketride/pathfinder-pipeline.json`** to see the AI pipeline
6. **Try a custom path** — select a different role, check different skills, pick a target

---

## Contact

Dan Harrison — dan@wombatlabs.ai — WombatLabs
