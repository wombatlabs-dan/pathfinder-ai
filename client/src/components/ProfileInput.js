import React, { useState, useMemo } from 'react';
import { ROLES, SKILLS_BY_CATEGORY, ROLE_SKILL_MAPPING } from '../data/config';

function ProfileInput({ onSubmit, onDemoClick }) {
  const [currentRole, setCurrentRole] = useState('');
  const [selectedSkills, setSelectedSkills] = useState(new Set());
  const [targetRole, setTargetRole] = useState('');

  const targetRoles = useMemo(
    () => ROLES.filter(role => role.type === 'target'),
    []
  );

  const currentRoles = useMemo(
    () => ROLES.filter(role => role.type === 'current'),
    []
  );

  const handleCurrentRoleChange = (e) => {
    const role = e.target.value;
    setCurrentRole(role);

    if (role && ROLE_SKILL_MAPPING[role]) {
      const defaultSkills = new Set(ROLE_SKILL_MAPPING[role]);
      setSelectedSkills(defaultSkills);
    } else {
      setSelectedSkills(new Set());
    }
  };

  const handleSkillToggle = (skillId) => {
    const newSkills = new Set(selectedSkills);
    if (newSkills.has(skillId)) {
      newSkills.delete(skillId);
    } else {
      newSkills.add(skillId);
    }
    setSelectedSkills(newSkills);
  };

  const handleSubmit = (e) => {
    e.preventDefault();

    if (!currentRole || selectedSkills.size === 0 || !targetRole) {
      alert('Please select a current role, at least one skill, and a target role');
      return;
    }

    onSubmit({
      currentRole,
      skills: Array.from(selectedSkills),
      targetRole,
    });
  };

  const handleDemoClick = () => {
    // Pre-fill Sarah's profile (matches config.js IDs)
    setCurrentRole('UX Researcher');
    setSelectedSkills(new Set([
      'user-interviews',
      'usability-testing',
      'data-analysis',
      'research-synthesis',
      'stakeholder-management',
      'presentation-skills',
      'design-documentation',
    ]));
    setTargetRole('AI Design Researcher');

    // Trigger demo mode (uses offline demo data)
    setTimeout(() => {
      onDemoClick();
    }, 0);
  };

  return (
    <div className="screen-container profile-input">
      <form className="input-form" onSubmit={handleSubmit}>
        {/* Current Role Selection */}
        <div className="form-section">
          <label className="form-label">
            What's your current role?
            <span className="form-label-required">*</span>
          </label>
          <select
            className="form-select"
            value={currentRole}
            onChange={handleCurrentRoleChange}
          >
            <option value="">Select a role...</option>
            {currentRoles.map(role => (
              <option key={role.id} value={role.id}>
                {role.label}
              </option>
            ))}
          </select>
        </div>

        {/* Skills Selection */}
        <div className="form-section">
          <label className="form-label">
            Select your skills
            <span className="form-label-required">*</span>
          </label>
          {Object.entries(SKILLS_BY_CATEGORY).map(([category, skills]) => (
            <div key={category} className="skill-category">
              <div className="category-title">{category}</div>
              <div className="skill-grid">
                {skills.map(skill => (
                  <label
                    key={skill.id}
                    className={`skill-checkbox ${
                      selectedSkills.has(skill.id) ? 'checked' : ''
                    }`}
                  >
                    <input
                      type="checkbox"
                      checked={selectedSkills.has(skill.id)}
                      onChange={() => handleSkillToggle(skill.id)}
                    />
                    <label>{skill.label}</label>
                  </label>
                ))}
              </div>
            </div>
          ))}
        </div>

        <div className="divider" />

        {/* Target Role Selection */}
        <div className="form-section">
          <label className="form-label">
            What's your target role?
            <span className="form-label-required">*</span>
          </label>
          <select
            className="form-select"
            value={targetRole}
            onChange={e => setTargetRole(e.target.value)}
          >
            <option value="">Select a target role...</option>
            {targetRoles.map(role => (
              <option key={role.id} value={role.id}>
                {role.label}
              </option>
            ))}
          </select>
        </div>

        {/* Buttons */}
        <div className="button-group">
          <button type="submit" className="button button-primary">
            Find My Path
          </button>
          <button
            type="button"
            className="button button-secondary"
            onClick={handleDemoClick}
          >
            Try Sarah's Demo
          </button>
        </div>
      </form>
    </div>
  );
}

export default ProfileInput;
