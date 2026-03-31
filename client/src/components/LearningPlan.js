import React from 'react';

function LearningPlan({ analysis, estimates }) {
  return (
    <div className="learning-plan-container">
      {/* Skills That Transfer */}
      {analysis.matched_skills && analysis.matched_skills.length > 0 && (
        <div className="plan-section">
          <div className="section-title">
            <div className="section-icon">✓</div>
            Skills That Transfer
          </div>
          {analysis.matched_skills.map(skill => (
            <div key={skill.name} className="skill-item">
              <div className="skill-item-header">
                <span className="skill-item-name">{skill.name}</span>
                <span className="skill-badge matched">Matched</span>
              </div>
              <div className="skill-item-details">
                <div className="skill-details-row">
                  <div className="skill-detail">
                    <div className="skill-detail-label">Transfer Weight</div>
                    <div className="skill-detail-value">
                      {Math.round(skill.weight * 100)}%
                    </div>
                  </div>
                  <div className="skill-detail">
                    <div className="skill-detail-label">Current Level</div>
                    <div className="skill-detail-value">
                      {skill.current_level || 'Advanced'}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Transfer Skills (from skill gaps that transfer) */}
      {analysis.transfer_skills && analysis.transfer_skills.length > 0 && (
        <div className="plan-section">
          <div className="section-title">
            <div className="section-icon">→</div>
            Skills to Strengthen
          </div>
          {analysis.transfer_skills.map(skill => (
            <div key={skill.name} className="skill-item">
              <div className="skill-item-header">
                <span className="skill-item-name">{skill.name}</span>
                <span className="skill-badge transfer">Transfer</span>
              </div>
              <div className="skill-item-details">
                <div className="skill-details-row">
                  <div className="skill-detail">
                    <div className="skill-detail-label">Transfer Weight</div>
                    <div className="skill-detail-value">
                      {Math.round(skill.weight * 100)}%
                    </div>
                  </div>
                  <div className="skill-detail">
                    <div className="skill-detail-label">Time to Bridge</div>
                    <div className="skill-detail-value">
                      {skill.time_to_proficiency || '2-4 weeks'}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Skills to Develop */}
      {analysis.gap_skills && analysis.gap_skills.length > 0 && (
        <div className="plan-section">
          <div className="section-title">
            <div className="section-icon">⚡</div>
            Skills to Develop
          </div>
          {analysis.gap_skills.map(skill => (
            <div key={skill.name} className="skill-item">
              <div className="skill-item-header">
                <span className="skill-item-name">{skill.name}</span>
                <span className="skill-badge gap">Gap</span>
              </div>
              <div className="skill-item-details">
                {skill.recommended_resources && (
                  <div>
                    <div className="skill-detail-label">Resources</div>
                    <div className="skill-detail-value">
                      {skill.recommended_resources.join(', ')}
                    </div>
                  </div>
                )}
                <div className="skill-details-row">
                  <div className="skill-detail">
                    <div className="skill-detail-label">Learning Path</div>
                    <div className="skill-detail-value">
                      {skill.learning_path || 'Self-paced'}
                    </div>
                  </div>
                  <div className="skill-detail">
                    <div className="skill-detail-label">Est. Time</div>
                    <div className="skill-detail-value">
                      {skill.time_to_proficiency || '4-8 weeks'}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Narrative */}
      {analysis.narrative && (
        <div className="plan-section">
          <div className="section-title">
            <div className="section-icon">📋</div>
            Your Personalized Path
          </div>
          <div className="narrative">
            {analysis.narrative}
          </div>
        </div>
      )}

      {/* Total Estimate */}
      {estimates && (
        <div className="estimate">
          <div className="estimate-label">Estimated Time to Close All Gaps</div>
          <div className="estimate-value">{estimates.total_time}</div>
        </div>
      )}
    </div>
  );
}

export default LearningPlan;
