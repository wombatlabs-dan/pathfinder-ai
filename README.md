# 🔍 PathFinder

>**AI-powered career navigation tool**

**Built live during** [HackwithBay 2.0](https://luma.com/2n8vk5s3?tk=CDAkzE) - 8-Hour Hackathon at AWS Builder Loft, SF

This tool helps design professionals find their personalized path into AI-augmented roles. Built with **Neo4j** knowledge graphs and **RocketRide AI** pipeline orchestration.

![PathFinder results — interactive graph visualization and alignment score](docs/pathfinder-demo-screen04.png)

> **[See the full demo walkthrough with all 9 screenshots](DEMO.md)**

---

## Quick Start (Demo in 2 minutes)

### Option A: Frontend only (fastest — no backend needed)

```bash
cd client
npm install
npm start
```

Open http://localhost:3000, click **"Try Sarah's Demo"** — done. The demo runs entirely offline with hardcoded data matching the pitch deck scenario.

### Option B: Full stack with Neo4j + LLM

```bash
# Terminal 1: Start the backend
cd server
cp .env.example .env
# Edit .env with your Neo4j Aura credentials and LLM API key
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

## The Problem

Design professionals — UX researchers, visual designers, content designers — are watching AI transform their field but don't know which AI skills matter for *their* specific role, what to learn first, or how their existing skills translate. PathFinder solves this with graph-powered skill mapping and personalized learning plans.

---

## Architecture

```
┌──────────────────────────────────────────────────────────────────────┐
│                        PathFinder Architecture                       │
│                                                                      │
│  ┌─────────┐    ┌─────────────┐    ┌──────────┐    ┌─────────────┐  │
│  │  React   │───▶│  Express    │───▶│  Neo4j   │───▶│  LLM API    │  │
│  │  Client  │◀───│  API        │◀───│  Aura    │    │  (DeepSeek) │  │
│  └─────────┘    └──────┬──────┘    └──────────┘    └─────────────┘  │
│                        │                                             │
│                        ▼                                             │
│               ┌─────────────────┐                                    │
│               │  RocketRide AI  │                                    │
│               │  Pipeline       │                                    │
│               │  (6-node        │                                    │
│               │   orchestration)│                                    │
│               └─────────────────┘                                    │
└──────────────────────────────────────────────────────────────────────┘
```

**Two execution paths, same logic:**

1. **Express API (primary)** — The backend directly queries Neo4j for skill matching, gap analysis, and transfer weights, then calls the LLM to generate personalized learning plans. This is the live production path.

2. **RocketRide Pipeline (orchestration layer)** — The same analysis logic is modeled as a 6-node RocketRide pipeline (see `rocketride/`). When running in Antigravity, the Express server calls it via webhook as a parallel enrichment path. The pipeline definition includes Neo4j query nodes and LLM prompt nodes that mirror the backend logic, demonstrating how this workflow scales to a visual, composable orchestration framework.

Both paths share the same Neo4j knowledge graph and LLM prompt templates.

---

## Project Structure

```
pathfinder/
├── README.md              ← You are here
├── neo4j/
│   └── seed.cypher        ← Graph schema: 50 skills, 32 AI capabilities,
│                             15 roles, 20 courses, 15 tools, 55+ TRANSFERS_TO edges
├── server/
│   ├── server.js          ← Express API (5 endpoints, Neo4j driver, LLM integration,
│   │                         RocketRide webhook integration)
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
│   │   │   ├── PathVisualization.js  ← vis-network interactive graph
│   │   │   ├── LearningPlan.js
│   │   │   └── ResultsScreen.js
│   │   └── data/
│   │       ├── config.js   ← Roles, skills, categories
│   │       └── demoData.js ← Sarah's pre-computed demo
│   └── package.json
└── rocketride/
    ├── pathfinder-pipeline.json  ← 6-node pipeline definition (RocketRide native)
    ├── pathfinder-pipeline.yaml  ← Same pipeline in YAML
    ├── prompts/
    │   ├── skill-normalizer.md   ← LLM prompt: maps free-text skills to graph IDs
    │   └── plan-generator.md     ← LLM prompt: generates personalized learning plans
    └── README.md                 ← Pipeline setup and node-by-node documentation
```

---

## How It Works

### The Knowledge Graph (Neo4j)

The graph is the product. 132 nodes and 208 relationships model the design-to-AI career landscape:

**6 node types:** DesignSkill (50), AICapability (32), Role (15), Tool (15), Course (20), Certification

**5 relationship types:**

- **`TRANSFERS_TO`** (weighted 0.0–1.0) — The core innovation. Quantifies how design skills transfer to AI capabilities. Example: Qualitative Analysis → Prompt Evaluation with 0.85 weight, meaning a UX researcher's analysis skills are 85% transferable to evaluating AI outputs.
- **`REQUIRES`** — What skills/capabilities a role needs (with importance: core/recommended)
- **`TEACHES`** — What a course covers
- **`LEADS_TO`** — Career progressions between roles
- **`DEVELOPS`** — What a tool helps you build

**Why this needs a graph database:** Computing the shortest weighted path from "UX Researcher skills" to "AI Design Researcher requirements" through transfer edges is a native graph traversal operation. A relational database would require expensive recursive joins. Neo4j's Cypher makes this a single query.

### The AI Pipeline (RocketRide)

The RocketRide pipeline models the full analysis as 6 composable nodes:

| Node | Type | Purpose |
|------|------|---------|
| 1. Input Parser | Input | Validates user profile (role, skills, target) |
| 2. Skill Normalizer | LLM | Maps free-text skills to canonical graph IDs |
| 3. Neo4j Matcher | Neo4j Query | Locates user in the skill graph, finds TRANSFERS_TO edges |
| 4. Target Resolver | Neo4j Query | Maps target role to its required capabilities |
| 5. Gap Analyzer | Neo4j Query | Computes skill gaps and shortest paths via transfers |
| 6. Plan Generator | LLM | Creates personalized, actionable learning plan |

The pipeline uses two LLM nodes (skill normalization at temperature 0.1 for consistency, plan generation at 0.7 for creativity) and three Neo4j query nodes with Cypher templates. Models can be swapped (GPT-4, DeepSeek, Claude) without rewriting any pipeline logic — demonstrating RocketRide's "one API" abstraction.

See `rocketride/README.md` for complete node-by-node documentation, Cypher queries, and example inputs/outputs.

### The Demo Story: Sarah

Sarah is a UX Researcher with 7 years of experience who wants to become an AI Design Researcher. PathFinder shows her she's already **65% aligned**:

- Her **qualitative analysis** skills map to **prompt evaluation** (0.85 transfer weight)
- Her **usability testing** maps to **AI output assessment** (0.78)
- Her **affinity diagramming** maps to **AI taxonomy design** (0.72)

She has 3 priority gaps to close (bias detection, fairness assessment, LLM testing frameworks) with a recommended ~6-week part-time learning plan featuring specific courses and tools.

---

## Required Technologies

### Neo4j — The Product IS a Graph

- 132 nodes across 6 types, 208 relationships across 5 types
- Weighted `TRANSFERS_TO` edges quantify skill transferability (the core differentiator)
- Cypher queries compute career paths via graph traversal
- Real Neo4j Aura instance seeded via `neo4j/seed.cypher`
- The backend runs 4 distinct Cypher queries per analysis (requirements, transfers, roles, courses/tools)

### RocketRide AI — Pipeline Orchestration

- 6-node pipeline with substantive logic in every node
- 2 LLM nodes (Skill Normalizer + Plan Generator) with complete system prompts
- 3 Neo4j query nodes with Cypher templates for graph matching and gap analysis
- Full pipeline definition in both JSON and YAML formats
- Server integrates via webhook for parallel pipeline enrichment
- Pipeline is importable into the RocketRide Antigravity IDE

---

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/roles` | All roles grouped by current/target type |
| GET | `/api/skills` | All design skills grouped by category |
| POST | `/api/analyze` | Core analysis: Neo4j graph matching + LLM plan generation |
| POST | `/api/path/compute` | Alternative analysis endpoint (Replit-compatible format) |
| GET | `/api/demo/sarah` | Pre-computed Sarah demo with full analysis |
| GET | `/api/health` | Server status (Neo4j, LLM, RocketRide connectivity) |

---

## For Judges

1. **Start the frontend** → `cd client && npm install && npm start`
2. **Click "Try Sarah's Demo"** → See the full 3-screen experience (input → loading → results)
3. **Explore the graph visualization** → Interactive vis-network showing skill transfers, gaps, courses
4. **Review the Neo4j data model** → `neo4j/seed.cypher` — 132 nodes, 208 relationships, weighted edges
5. **Review the RocketRide pipeline** → `rocketride/pathfinder-pipeline.json` — 6 nodes, 10 connections, complete Cypher queries and LLM prompts
6. **Review the pipeline documentation** → `rocketride/README.md` — node-by-node specs with example I/O
7. **Try a custom path** → Select a different role, check different skills, pick a target

### What makes this a graph problem

The `TRANSFERS_TO` relationship with confidence weights is something only a graph database handles natively. Finding the optimal career path from Role A to Role B through skill transfer edges is a shortest-weighted-path problem — exactly what Neo4j was built for.

---

## Tech Stack

- **Database:** Neo4j Aura (graph database)
- **Backend:** Express.js, Neo4j JavaScript Driver, OpenAI-compatible SDK
- **Frontend:** React 18, vis-network (graph visualization), Axios
- **LLM:** DeepSeek V3.2 via GMI Cloud (OpenAI-compatible API)
- **Pipeline:** RocketRide AI (6-node pipeline, Antigravity IDE)

---

## Contact

Dan Harrison — dan@wombatlabs.ai — [WombatLabs](https://wombatlabs.ai)
