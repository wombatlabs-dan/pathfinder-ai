import React from 'react';
import PathVisualization from './PathVisualization';
import LearningPlan from './LearningPlan';

function ResultsScreen({ data, formData, onReset }) {
  // data comes directly as the flat response (alignment_score, matched_skills, etc.)
  const alignmentPercent = Math.round((data.alignment_score || 0) * 100);

  const CircularProgress = ({ percent }) => {
    const radius = 85;
    const circumference = 2 * Math.PI * radius;
    const offset = circumference - (percent / 100) * circumference;

    return (
      <div className="progress-circle">
        <svg className="progress-svg" viewBox="0 0 200 200">
          <defs>
            <linearGradient id="gradient" x1="0%" y1="0%" x2="100%" y2="100%">
              <stop offset="0%" stopColor="#22d3ee" />
              <stop offset="100%" stopColor="#06b6d4" />
            </linearGradient>
          </defs>
          <circle
            cx="100"
            cy="100"
            r={radius}
            className="progress-circle-bg"
          />
          <circle
            cx="100"
            cy="100"
            r={radius}
            className="progress-circle-fill"
            style={{
              strokeDasharray: circumference,
              strokeDashoffset: offset,
            }}
          />
        </svg>
        <div className="progress-text">
          <div className="progress-percentage">{percent}%</div>
          <div className="progress-label">aligned</div>
        </div>
      </div>
    );
  };

  return (
    <div className="screen-container results-screen">
      <div className="results-grid">
        {/* Left: Graph Visualization */}
        <PathVisualization graphData={data.graph_data} />

        {/* Right: Results Summary */}
        <div className="results-sidebar">
          {/* Alignment Card */}
          <div className="alignment-card">
            <div className="alignment-headline">
              You're already {alignmentPercent}% aligned!
            </div>
            <CircularProgress percent={alignmentPercent} />
            <div className="alignment-message">
              {alignmentPercent >= 75
                ? "You're well on your way! A few targeted skills and you'll be there."
                : alignmentPercent >= 50
                ? "You have solid foundations. Let's build on what you already know."
                : "You have what it takes — we'll build the missing pieces together."}
            </div>
          </div>

          {/* Learning Plan — pass the flat data directly */}
          <LearningPlan analysis={data} estimates={data.estimates} />

          {/* Action Buttons */}
          <div className="action-buttons">
            <button className="button button-primary" onClick={onReset}>
              Start Over
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default ResultsScreen;
