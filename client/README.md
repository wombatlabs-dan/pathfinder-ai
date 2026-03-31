# PathFinder: AI Design Navigator - Frontend

A polished, design-forward React frontend for PathFinder, an AI-powered career navigation tool for design professionals.

## Features

- **Profile Input Screen**: Select your current role, skills, and target role with auto-fill for skill recommendations
- **Loading Animation**: Smooth, multi-step loading experience
- **Graph Visualization**: Interactive network graph showing skill transfers, gaps, and learning paths
- **Results Dashboard**:
  - Real-time alignment percentage with circular progress indicator
  - Detailed analysis of matched, transfer, and gap skills
  - AI-generated personalized learning narrative
  - Estimated time to proficiency
- **Demo Mode**: "Try Sarah's Demo" button with pre-loaded data for instant demos at hackathons
- **Responsive Design**: Works beautifully on desktop, tablet, and mobile
- **Fallback Support**: Works standalone even if backend is down using embedded demo data

## Tech Stack

- **React 18**: Component-based UI
- **vis-network**: Interactive graph visualization
- **axios**: HTTP client for API calls
- **CSS3**: Modern styling with gradients, animations, and responsive design

## Design System

```
Colors:
- Background: #0f172a (dark navy)
- Primary accent: #22d3ee (cyan)
- Secondary: #818cf8 (indigo)
- Success: #22c55e (green)
- Warning: #f97316 (orange)
- Danger: #ef4444 (red)
- Card background: #1e293b
```

## Setup & Installation

### Prerequisites

- Node.js 16+ and npm/yarn

### Installation

```bash
npm install
```

### Configuration

Create a `.env` file based on `.env.example`:

```bash
# Default is http://localhost:3001
REACT_APP_API_URL=http://localhost:3001
```

### Running the App

#### Development Mode

```bash
npm start
```

Opens [http://localhost:3000](http://localhost:3000)

#### Production Build

```bash
npm run build
```

Creates an optimized production build in `/build`

## Project Structure

```
client/
├── public/
│   └── index.html              # HTML shell
├── src/
│   ├── components/
│   │   ├── Header.js           # App header with logo and badges
│   │   ├── ProfileInput.js     # Role/skill selection form
│   │   ├── LoadingScreen.js    # Loading animation
│   │   ├── PathVisualization.js # Graph visualization
│   │   ├── LearningPlan.js     # Results sidebar
│   │   └── ResultsScreen.js    # Main results view
│   ├── data/
│   │   ├── config.js           # Roles and skills configuration
│   │   └── demoData.js         # Sarah's demo data (fallback)
│   ├── App.js                  # Main app logic
│   ├── App.css                 # Styling
│   ├── index.js                # React entry point
│   └── index.css               # Global styles
├── package.json
├── .env.example
└── .gitignore
```

## API Integration

### Endpoints

The app expects a backend at `http://localhost:3001` (configurable) with:

#### POST /api/analyze

Request body:
```json
{
  "currentRole": "UX Researcher",
  "skills": ["user-interviews", "data-analysis", ...],
  "targetRole": "AI Design Researcher"
}
```

Expected response:
```json
{
  "analysis": {
    "alignment_score": 0.72,
    "matched_skills": [...],
    "transfer_skills": [...],
    "gap_skills": [...],
    "narrative": "..."
  },
  "estimates": {
    "total_time": "3-4 months"
  },
  "graph_data": {
    "nodes": [...],
    "edges": [...]
  }
}
```

### Fallback / Demo Mode

If the API is unreachable, the app automatically falls back to embedded demo data. The "Try Sarah's Demo" button triggers a smooth 2-second loading animation before showing results.

## Demo Features

The "Try Sarah's Demo" button demonstrates the full user journey:
- Pre-selects: UX Researcher + typical skills + AI Design Researcher target
- Shows realistic alignment score (72%)
- Displays comprehensive graph visualization
- Includes detailed learning plan with resources
- No API call needed—works 100% offline

## Customization

### Adding New Roles

Edit `src/data/config.js`:

```javascript
export const ROLES = [
  { id: 'role-id', label: 'Role Name', type: 'current' | 'target' },
  // ...
];
```

### Adding New Skills

Edit `src/data/config.js`:

```javascript
export const SKILLS_BY_CATEGORY = {
  'Category': [
    { id: 'skill-id', label: 'Skill Name' },
    // ...
  ],
};
```

### Customizing Colors

Edit `src/App.css` and update the color variables:

```css
--bg-primary: #0f172a;
--accent-primary: #22d3ee;
--accent-secondary: #818cf8;
```

## Hackathon Demo Tips

1. **Always test the demo first**: Click "Try Sarah's Demo" to verify the graph visualization works smoothly
2. **Network graph is the "wow"**: Make sure judges see the interactive graph—it's the visual centerpiece
3. **Alignment score is the hook**: The circular progress indicator with 72% creates an emotional connection
4. **Narrative matters**: The personalized learning plan tells the story of transformation
5. **Fallback works offline**: If WiFi is spotty, the demo runs completely client-side

## Browser Support

- Chrome/Edge 90+
- Firefox 88+
- Safari 14+
- Mobile browsers (iOS Safari 14+, Chrome Android)

## Performance

- Initial load: ~45KB gzipped (React + vis-network)
- Graph visualization: Smooth 60fps with up to 50 nodes
- Demo mode: Instant startup, no network required

## Troubleshooting

### Graph visualization not showing

1. Check that `vis-network` is installed: `npm install vis-network`
2. Ensure the containerRef is properly mounted in PathVisualization.js
3. Verify graph data structure matches expected format

### API not connecting

1. Ensure backend is running on `http://localhost:3001`
2. Check CORS headers in backend
3. Verify `.env` file has correct `REACT_APP_API_URL`
4. Demo mode should still work as fallback

### Styles looking wrong

1. Clear browser cache: `Cmd+Shift+R` (Mac) or `Ctrl+Shift+R` (Windows)
2. Rebuild: `npm run build`
3. Check that `.css` files are being imported

## License

This project is part of HackWithBay 2.0 — Built with Neo4j + RocketRide AI
