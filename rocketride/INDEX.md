# PathFinder RocketRide Pipeline - Complete Index

**Location**: `/sessions/nifty-vibrant-carson/mnt/claude-context/pathfinder/rocketride/`

## Start Here

- **First time?** → Read `QUICK_START.md` (5 minutes)
- **Ready to import?** → Use `pathfinder-pipeline.json`
- **Need help?** → Check `README.md`
- **Want details?** → See `MANIFEST.md`

## Files by Purpose

### To Import Into RocketRide
```
pathfinder-pipeline.json     ← Use this (recommended)
pathfinder-pipeline.yaml     ← Or this alternative
```

### To Configure LLM Nodes
```
prompts/skill-normalizer.md  ← Node 2 configuration
prompts/plan-generator.md    ← Node 6 configuration
```

### For Documentation
```
QUICK_START.md               ← 5-minute setup guide
README.md                    ← Complete reference (800+ lines)
MANIFEST.md                  ← Technical overview
INDEX.md                     ← This file
```

## What Each File Does

### pathfinder-pipeline.json (19 KB)
**Primary RocketRide pipeline file**
- 6-node configuration (1 input, 2 LLM, 3 Neo4j)
- 10 data connections
- Complete node configurations
- Variable definitions
- Import this into RocketRide

**Key Sections:**
- `nodes[]` - Node definitions with inputs/outputs
- `connections[]` - Data flow between nodes
- `variables` - Environment configuration
- `config` - Pipeline settings

### pathfinder-pipeline.yaml (17 KB)
**Alternative YAML format**
- Same content as JSON version
- Use if RocketRide supports YAML import
- Easier to read/edit in text editor

### prompts/skill-normalizer.md (6.1 KB)
**System prompt for Node 2 (Skill Normalization)**
- Maps free-text skills to canonical IDs
- 25-skill reference table
- Examples and rules
- Output format specification

**Load into Node 2 config:**
```json
"systemPromptFile": "prompts/skill-normalizer.md"
```

### prompts/plan-generator.md (9.4 KB)
**System prompt for Node 6 (Plan Generation)**
- Generates personalized learning plans
- Schema specifications
- Prioritization rules
- Milestone creation guidelines

**Load into Node 6 config:**
```json
"systemPromptFile": "prompts/plan-generator.md"
```

### QUICK_START.md (8.9 KB)
**For getting started fast**
- 30-second overview
- 5-step setup process
- Node descriptions with examples
- Quick troubleshooting
- Common use cases

**Read this first if:**
- You're new to the project
- You want to start immediately
- You need a quick reference

### README.md (22 KB)
**Comprehensive documentation**
- Complete setup instructions
- Detailed node documentation
- Neo4j schema requirements
- LLM configuration options
- Troubleshooting (10+ scenarios)
- Integration examples (Python, Node.js)
- Performance optimization tips

**Read sections based on needs:**
- "Quick Start" - Initial setup
- "Node Details" - How each node works
- "Configure Neo4j" - Database setup
- "Troubleshooting" - Problem solving
- "Integration" - Using the pipeline in code

### MANIFEST.md (6.0 KB)
**Technical overview and architecture**
- File inventory
- Pipeline architecture diagram
- Node types and relationships
- Configuration variables
- Key features summary
- Statistics

**Use for:**
- Understanding overall structure
- Seeing how components connect
- Planning customization
- Technical reference

### INDEX.md (this file)
**Navigation guide**
- Quick file reference
- Purpose of each file
- Where to find what you need

## Quick Reference

### Setup Timeline
| Stage | Time | Action |
|-------|------|--------|
| Familiarize | 5 min | Read QUICK_START.md |
| Install | 5 min | Copy files, import to RocketRide |
| Configure | 10 min | Set environment variables |
| Verify | 5 min | Test Neo4j and LLM connections |
| Test | 10 min | Run pipeline with sample data |
| **Total** | **35 min** | Ready to use |

### File Size Guide
| Size | Usage |
|------|-------|
| 6 KB | Quick reference (MANIFEST.md, prompts) |
| 9 KB | Setup guide (QUICK_START.md) |
| 17-19 KB | Pipeline config (JSON/YAML) |
| 22 KB | Complete reference (README.md) |

### Node Quick Guide
| Node | Type | Purpose | Needs |
|------|------|---------|-------|
| 1 | input | Parse input | User form data |
| 2 | llm | Normalize skills | LLM API + mapping table |
| 3 | neo4j | Find current skills | Neo4j + query |
| 4 | neo4j | Get target requirements | Neo4j + query |
| 5 | neo4j | Analyze gaps | Neo4j + APOC library |
| 6 | llm | Generate plan | LLM API + context |

## Configuration Checklist

### Prerequisites
- [ ] Neo4j instance running
- [ ] LLM API key (OpenAI/Anthropic)
- [ ] VS Code with RocketRide extension

### Environment Setup
- [ ] NEO4J_HOST = bolt://localhost:7687
- [ ] NEO4J_USER = neo4j
- [ ] NEO4J_PASSWORD = [your password]
- [ ] LLM_API_KEY = [your API key]
- [ ] LLM_MODEL = gpt-4
- [ ] LLM_API_ENDPOINT = https://api.openai.com/v1

### Neo4j Database
- [ ] Skill nodes exist (with ID property)
- [ ] Role nodes exist (with name property)
- [ ] Course and Tool nodes exist
- [ ] REQUIRES, TRANSFERS_TO, TEACHES relationships exist
- [ ] Indexes created for performance

### RocketRide Setup
- [ ] Copy files to pipeline directory
- [ ] Import pathfinder-pipeline.json
- [ ] Set environment variables
- [ ] Verify connections
- [ ] Run test execution

## Customization Paths

### Add More Skills
Edit Node 2 in `pathfinder-pipeline.json`:
```json
"mappingTable": {
  "existing-skill": "skill:id:###",
  "my-new-skill": "skill:mynew:999"
}
```

### Modify Skill Normalization
Edit `prompts/skill-normalizer.md`:
- Add new skill categories
- Adjust example mappings
- Modify confidence scoring rules

### Adjust Plan Generation
Edit `prompts/plan-generator.md`:
- Change time estimation guidelines
- Modify milestone creation rules
- Adjust prioritization logic

### Change LLM Provider
Edit Node 2 and Node 6 in pipeline:
```json
"model": "claude-3-opus",
"apiEndpoint": "https://api.anthropic.com/v1"
```

### Optimize Neo4j Queries
Edit Nodes 3, 4, 5 in `pathfinder-pipeline.json`:
- Modify WHERE clauses
- Adjust path traversal depth
- Change relationship filtering

## Troubleshooting Quick Links

### Connection Issues
- See README.md "Neo4j Connection Failed"
- See README.md "LLM API Error"

### Data Issues
- See README.md "Skills Not Found in Graph"
- See README.md "Unexpected Results"

### Performance Issues
- See README.md "Pipeline Times Out"
- See QUICK_START.md "Performance Expectations"

### General Help
- Check README.md "Troubleshooting" section
- Review node comments in pipeline JSON
- Examine prompt files for guidelines

## Support Resources

### In This Project
- **QUICK_START.md** - Fast answers
- **README.md** - Detailed documentation
- **MANIFEST.md** - Architecture overview
- **Prompt files** - Configuration guides

### External Resources
- [RocketRide AI Documentation](docs.rocketride.ai)
- [Neo4j Documentation](neo4j.com/docs)
- [OpenAI API Reference](platform.openai.com/docs)
- [Anthropic API Reference](anthropic.com/docs)

## File Locations Summary

```
/sessions/nifty-vibrant-carson/mnt/claude-context/pathfinder/rocketride/
├── pathfinder-pipeline.json       ← IMPORT THIS
├── pathfinder-pipeline.yaml       ← (alternative)
├── README.md                      ← Full docs
├── QUICK_START.md                 ← Start here
├── MANIFEST.md                    ← Technical info
├── INDEX.md                       ← This file
└── prompts/
    ├── skill-normalizer.md        ← Node 2 prompt
    └── plan-generator.md          ← Node 6 prompt
```

## Next Steps

1. **Right Now** (2 minutes)
   - Read "Start Here" section above
   - Choose QUICK_START.md or README.md based on needs

2. **Next** (5 minutes)
   - Read your chosen guide
   - Gather environment variables
   - Check Neo4j is available

3. **Then** (10 minutes)
   - Copy files to RocketRide directory
   - Import pathfinder-pipeline.json
   - Configure variables

4. **Test** (10 minutes)
   - Run pipeline with sample data
   - Check output quality
   - Review any errors

5. **Customize** (as needed)
   - Adjust prompts for your domain
   - Add more skills to mapping table
   - Optimize Neo4j queries

---

**You have everything you need. Choose your starting document and begin!**

Most people start with: `QUICK_START.md` (5 minute read)

Then reference: `README.md` (as needed)

For architecture: `MANIFEST.md` (optional deep dive)

To import: `pathfinder-pipeline.json` (after setup)
