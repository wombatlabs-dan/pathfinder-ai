PathFinder Neo4j Batch Files — Ready for Aura Browser
======================================================

All 7 files are paste-ready for Neo4j Aura browser query editor.
Each statement ends with a semicolon. No comments. No blank lines.

FILE STRUCTURE & EXECUTION ORDER:

1. batch0-verify.cypher (1 statement)
   - Verification query (run after all batches loaded)
   - Returns count of node types

2. batch1-constraints.cypher (9 statements)
   - CREATE CONSTRAINT (6 statements)
   - CREATE INDEX (3 statements)
   - RUN FIRST — required before loading nodes

3. batch2-design-skills.cypher (50 statements)
   - CREATE DesignSkill nodes
   - All 50 design skill nodes with properties

4. batch3-ai-capabilities.cypher (32 statements)
   - CREATE AICapability nodes
   - All 32 AI capability nodes with difficulty levels

5. batch4-roles-tools-courses.cypher (50 statements)
   - CREATE Role nodes (15 total)
   - CREATE Tool nodes (15 total)
   - CREATE Course nodes (20 total)

6. batch5-transfers-to.cypher (52 statements)
   - TRANSFERS_TO relationships
   - DesignSkill → AICapability with weights
   - Represents skill transferability to AI capabilities

7. batch6-other-relationships.cypher (156 statements)
   - REQUIRES relationships (Roles → Skills/Capabilities)
   - LEADS_TO relationships (Career progression)
   - TEACHES relationships (Courses → Capabilities)
   - DEVELOPS relationships (Tools → Capabilities)

TOTAL: 350+ individual statements, all semicolon-terminated

HOW TO USE IN NEO4J AURA:

1. Open Neo4j Aura Browser
2. Paste batch1-constraints.cypher, run
3. Wait for completion
4. Paste batch2-design-skills.cypher, run
5. Paste batch3-ai-capabilities.cypher, run
6. Paste batch4-roles-tools-courses.cypher, run
7. Paste batch5-transfers-to.cypher, run
8. Paste batch6-other-relationships.cypher, run
9. Paste batch0-verify.cypher, run (to verify load)

Each batch can be copied and pasted as a whole into the browser.
