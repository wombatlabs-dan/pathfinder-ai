import React, { useState, useEffect } from 'react';

function LoadingScreen() {
  const [step, setStep] = useState(0);

  const steps = [
    'Analyzing your profile...',
    'Computing skill transfers...',
    'Building your path...',
    'Generating learning plan...',
  ];

  useEffect(() => {
    const interval = setInterval(() => {
      setStep(prev => (prev + 1) % steps.length);
    }, 600);

    return () => clearInterval(interval);
  }, []);

  return (
    <div className="loading-screen">
      <div className="spinner" />
      <div className="loading-text">Computing your path...</div>
      <div className="loading-subtext">{steps[step]}</div>
    </div>
  );
}

export default LoadingScreen;
