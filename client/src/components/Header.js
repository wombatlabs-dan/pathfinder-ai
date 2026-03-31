import React from 'react';

function Header() {
  return (
    <header className="header">
      <div className="header-content">
        <div className="header-left">
          <div>
            <div className="logo">PathFinder</div>
            <div className="tagline">Your AI-powered design career navigator</div>
          </div>
        </div>
        <div className="badges">
          <div className="badge">
            <span>⚡</span>
            <span>Built with Neo4j + RocketRide AI</span>
          </div>
          <div className="badge">
            <span>🏆</span>
            <span>HackWithBay 2.0</span>
          </div>
        </div>
      </div>
    </header>
  );
}

export default Header;
