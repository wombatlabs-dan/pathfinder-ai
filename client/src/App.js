import React, { useState } from 'react';
import axios from 'axios';
import './App.css';
import Header from './components/Header';
import ProfileInput from './components/ProfileInput';
import LoadingScreen from './components/LoadingScreen';
import ResultsScreen from './components/ResultsScreen';
import { DEMO_DATA } from './data/demoData';

const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:3001';

function App() {
  const [screen, setScreen] = useState('input');
  const [formData, setFormData] = useState(null);
  const [resultsData, setResultsData] = useState(null);
  const [error, setError] = useState(null);

  const handleSubmit = async (data) => {
    setFormData(data);
    setScreen('loading');
    setError(null);

    try {
      const response = await axios.post(`${API_BASE_URL}/api/analyze`, {
        currentRole: data.currentRole,
        skills: data.skills,
        targetRole: data.targetRole,
      });

      setResultsData(response.data);
      setScreen('results');
    } catch (err) {
      console.error('API Error:', err);
      setError(err.message);
      setScreen('input');
    }
  };

  const handleDemoClick = () => {
    setFormData(DEMO_DATA.formData);
    setScreen('loading');
    setError(null);

    // Simulate loading delay for smooth transition
    setTimeout(() => {
      setResultsData(DEMO_DATA.resultsData);
      setScreen('results');
    }, 2000);
  };

  const handleReset = () => {
    setScreen('input');
    setFormData(null);
    setResultsData(null);
    setError(null);
  };

  return (
    <div className="app">
      <Header />
      <div className="app-content">
        {screen === 'input' && (
          <ProfileInput onSubmit={handleSubmit} onDemoClick={handleDemoClick} />
        )}
        {screen === 'loading' && <LoadingScreen />}
        {screen === 'results' && (
          <ResultsScreen
            data={resultsData}
            formData={formData}
            onReset={handleReset}
          />
        )}
        {error && (
          <div style={{ padding: '2rem', textAlign: 'center', color: '#ef4444' }}>
            Error: {error}
          </div>
        )}
      </div>
    </div>
  );
}

export default App;
