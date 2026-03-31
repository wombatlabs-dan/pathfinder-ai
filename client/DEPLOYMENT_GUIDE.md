# PathFinder Frontend - Deployment Guide

Quick reference for getting PathFinder running for HackWithBay 2.0.

## Local Development (5 minutes)

```bash
# 1. Install dependencies
npm install

# 2. Start development server
npm start

# Opens http://localhost:3000 automatically
```

Visit the app and click "Try Sarah's Demo" to verify everything works.

## For Demo Day (When Backend is Ready)

```bash
# If backend is running on a different URL
REACT_APP_API_URL=https://api.yourdomain.com npm start

# Or set in .env file
echo "REACT_APP_API_URL=https://api.yourdomain.com" > .env
npm start
```

The app will call `POST /api/analyze` on your backend.

## Production Build

```bash
# Create optimized production bundle
npm run build

# Output folder: /build (ready to deploy)
```

Deploy the `/build` folder to:
- **Netlify**: Drag & drop `/build` folder
- **Vercel**: `vercel --prod`
- **GitHub Pages**: `npm run build && git add build && git commit -m "deploy"`
- **AWS S3**: `aws s3 sync build/ s3://your-bucket/`

## Environment Configuration

Create `.env` file in project root:

```bash
# Backend API endpoint (default: http://localhost:3001)
REACT_APP_API_URL=http://localhost:3001

# Optional: Custom API timeout
REACT_APP_API_TIMEOUT=10000
```

## API Requirements

Your backend must expose:

```
POST /api/analyze
```

Request:
```json
{
  "currentRole": "UX Researcher",
  "skills": ["user-interviews", "data-analysis", "prototyping"],
  "targetRole": "AI Design Researcher"
}
```

Response:
```json
{
  "analysis": {
    "alignment_score": 0.72,
    "matched_skills": [],
    "transfer_skills": [],
    "gap_skills": [],
    "narrative": "..."
  },
  "estimates": {
    "total_time": "3-4 months"
  },
  "graph_data": {
    "nodes": [],
    "edges": []
  }
}
```

If API is unreachable, the app automatically falls back to demo data.

## Demo Mode (No Backend Required)

The app ships with complete fallback data. To use:

1. Click "Try Sarah's Demo" button
2. Watch 2-second loading animation
3. See full results (no API call needed)

Perfect for:
- Offline demos
- WiFi-challenged environments
- Showing judges without backend dependency

## Performance Checklist

Before deploying:

- [ ] npm install completes without errors
- [ ] npm start opens app at localhost:3000
- [ ] "Try Sarah's Demo" button works
- [ ] Graph visualization renders smoothly
- [ ] All animations are buttery (60fps)
- [ ] Responsive on mobile/tablet
- [ ] No console errors
- [ ] API integration tested (if backend available)

## Troubleshooting

### App won't start
```bash
rm -rf node_modules package-lock.json
npm install
npm start
```

### Graph not rendering
- Check browser console for errors
- Ensure vis-network is installed: `npm ls vis-network`
- Try refreshing page (Cmd+R or Ctrl+R)

### API not connecting
- Verify backend is running on correct port
- Check CORS headers in backend
- Confirm `.env` has correct `REACT_APP_API_URL`
- Demo should still work as fallback

### Styles look wrong
- Clear browser cache: Cmd+Shift+R (Mac) or Ctrl+Shift+R (Windows)
- Rebuild: `npm run build`

## Mobile Testing

The app is fully responsive. Test on:

```bash
# Desktop (default)
npm start

# Tablet simulation (Chrome DevTools)
- F12 to open DevTools
- Click device toolbar icon
- Select "iPad" or custom dimensions

# Real device
- Get your IP: ipconfig getifaddr en0 (Mac) or ipconfig (Windows)
- On mobile: http://your-ip:3000
```

## Analytics & Monitoring

To add analytics (optional):

```javascript
// In App.js
import gtag from '@react-ga/core';

// Track page views
gtag.pageview(window.location.pathname);
```

## Scaling for Production

If PathFinder gets popular:

1. **Cache API responses**: Add Redis caching in backend
2. **Optimize graph rendering**: For 100+ nodes, lazy-load graph
3. **Database**: Store user sessions for "My Career Path" feature
4. **Auth**: Add user accounts for saved analyses
5. **Analytics**: Track popular role transitions, skill gaps
6. **Notifications**: Email users weekly learning tips

## Rollback Plan

If deployment breaks:

```bash
# Revert to last working build
git revert HEAD

# Or manually restore from backup
aws s3 sync s3://backup-bucket/build/ s3://main-bucket/
```

## Success Metrics for Hackathon

Monitor these after launch:

- **Demo clicks**: "Try Sarah's Demo" conversion
- **API calls**: Successful role analyses
- **Load time**: <2 seconds initial
- **Graph renders**: 100% success rate
- **Mobile traffic**: Works on all devices
- **Fallback usage**: How often demo vs real API

## Post-Hackathon Maintenance

**Week 1**: Monitor for bugs, fix any UI issues

**Week 2**: Gather feedback from judges, collect feature requests

**Week 3**: Implement top 3 requested features

**Month 1**: Set up CI/CD pipeline, automated tests

**Month 2**: Plan v2 features (saved profiles, community, etc.)

## Team Handoff

If handing off to another team:

1. Ensure they can run `npm install && npm start`
2. Provide `.env` configuration
3. Document API contract
4. Share ARCHITECTURE.md and design system
5. Walk through the 3 screens
6. Show how to customize roles/skills
7. Explain demo mode fallback

## Deployment Checklist

- [ ] All files committed to git
- [ ] npm install tested fresh
- [ ] npm start launches successfully
- [ ] Demo works offline
- [ ] API integration tested (if available)
- [ ] Responsive design verified
- [ ] Performance optimized (no console warnings)
- [ ] Documentation complete
- [ ] Team trained on maintenance
- [ ] Deployment credentials secure
- [ ] Monitoring/analytics configured
- [ ] Backup strategy in place

---

**You're ready to ship!** Good luck at HackWithBay 2.0!
