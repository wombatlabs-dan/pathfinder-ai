# PathFinder Backend Setup Guide

Quick start guide for setting up and running the PathFinder API.

## Prerequisites

- Node.js >= 18.0.0
- npm or yarn
- (Optional) Neo4j Aura instance
- (Optional) OpenAI API key

## Installation

### 1. Install Dependencies

```bash
npm install
```

This installs:
- `express` - Web framework
- `neo4j-driver` - Neo4j database connection
- `cors` - Cross-origin support
- `dotenv` - Environment configuration
- `openai` - LLM integration

### 2. Configure Environment

Copy the example configuration:
```bash
cp .env.example .env
```

Edit `.env` with your credentials:

```env
# Neo4j Aura Configuration (optional - server works in demo mode without it)
NEO4J_URI=neo4j+s://YOUR_INSTANCE.databases.neo4j.io
NEO4J_USER=neo4j
NEO4J_PASSWORD=your-password-here

# OpenAI Configuration (optional - fallback plan generation without it)
OPENAI_API_KEY=sk-your-key-here

# Server Configuration
PORT=3001
NODE_ENV=development
```

**Note:** The server works perfectly in demo mode if Neo4j and OpenAI credentials are not provided. This is ideal for hackathon demos.

## Running the Server

### Development Mode

```bash
npm start
```

Server will start on `http://localhost:3001`

Output will show:
```
PathFinder API running on http://localhost:3001
Neo4j connected: true/false
OpenAI available: true/false
Demo endpoint available at http://localhost:3001/api/demo/sarah
```

### Verify Connection

Check the health endpoint:
```bash
curl http://localhost:3001/api/health
```

Response:
```json
{
  "status": "ok",
  "neo4j_connected": true,
  "openai_available": true,
  "environment": "development"
}
```

## Testing the API

### 1. Get Available Roles

```bash
curl http://localhost:3001/api/roles
```

### 2. Get Available Skills

```bash
curl http://localhost:3001/api/skills
```

### 3. Try the Demo Analysis

No authentication needed - works immediately:
```bash
curl http://localhost:3001/api/demo/sarah
```

Returns Sarah's complete 65% alignment analysis.

### 4. Perform Custom Analysis

```bash
curl -X POST http://localhost:3001/api/analyze \
  -H "Content-Type: application/json" \
  -d '{
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
  }'
```

## Running Modes

### Demo Mode (No External Dependencies)

If Neo4j credentials are missing, the server automatically uses demo mode:
- Returns hardcoded Sarah scenario for UX → AI Design Researcher
- Falls back to rule-based plan generation (no OpenAI needed)
- All endpoints work - perfect for hackathon presentations

```bash
# No .env file needed - just run
npm start
# Fallback demo data is used for all queries
```

### Neo4j Connected Mode

With Neo4j credentials in `.env`:
- Queries live knowledge graph for accurate data
- Computes real skill transfer alignments
- Still falls back to demo if Neo4j unavailable

### Full Featured Mode

With both Neo4j and OpenAI configured:
- Complete graph analysis with actual Neo4j queries
- AI-powered personalized learning plans
- Highest quality output

## API Quick Reference

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/roles` | GET | List available roles |
| `/api/skills` | GET | List available skills by category |
| `/api/analyze` | POST | Analyze career transition path |
| `/api/demo/sarah` | GET | Sarah's pre-computed analysis |
| `/api/health` | GET | Server health check |

## Response Structure

The `/api/analyze` endpoint returns:

```json
{
  "alignment_score": 0.65,           // 0.0-1.0, how much of target role user covers
  "matched_skills": [...],           // User's skills that apply to target role
  "gap_skills": [...],               // Skills user needs to develop
  "recommended_courses": [...],      // Courses that teach gap skills
  "recommended_tools": [...],        // Tools to develop gap skills
  "learning_plan_text": "...",       // Personalized narrative plan
  "graph_data": {                    // For vis.js visualization
    "nodes": [...],
    "edges": [...]
  }
}
```

## Color Coding in Visualization

- **Green (#22c55e)**: User's matched skills
- **Red (#ef4444)**: Gap skills to develop
- **Blue (#3b82f6)**: Roles and requirements
- **Purple (#a855f7)**: Courses
- **Cyan (#06b6d4)**: Tools

## Troubleshooting

### Port Already in Use

If port 3001 is busy, change it in `.env`:
```env
PORT=3002
```

### Neo4j Connection Error

The server automatically falls back to demo mode. Check logs:
```
Neo4j connection failed: [error message]
Falling back to demo mode
```

This is normal and doesn't prevent the server from working.

### Missing Dependencies

```bash
npm install
```

### OpenAI API Error

The server gracefully falls back to rule-based plan generation. Check logs for the specific error. Learning plans will still be generated without AI.

## Development Tips

- Server logs all requests to console
- Errors show in development mode, hidden in production
- Demo data is hardcoded and always available
- Graph analysis queries take ~100-500ms depending on Neo4j size
- OpenAI API calls take ~2-5 seconds

## Production Deployment

1. Set `NODE_ENV=production` in `.env`
2. Use a process manager (PM2):
   ```bash
   npm install -g pm2
   pm2 start server.js --name "pathfinder-api"
   ```
3. Enable CORS only for your frontend domain
4. Add rate limiting for `/api/analyze` endpoint
5. Monitor Neo4j connection health
6. Use environment variables for all secrets (not .env file)

## Next Steps

- Connect a React/Vue frontend to the `/api/analyze` endpoint
- Visualize the graph_data with vis.js
- Customize demo data in `server.js` for your use case
- Add authentication if needed
- Deploy to Heroku, Railway, Vercel, or your preferred platform

## Support

- Check logs for detailed error messages
- Test with curl before frontend integration
- Verify health endpoint: `/api/health`
- Demo works without any external dependencies
