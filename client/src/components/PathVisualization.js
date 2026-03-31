import React, { useEffect, useRef, useState } from 'react';
import { Network } from 'vis-network';

const NODE_COLORS = {
  matched: '#22c55e',
  transfer: '#f97316',
  gap: '#ef4444',
  target: '#06b6d4',
  course: '#a855f7',
  tool: '#22d3ee',
};

function PathVisualization({ graphData }) {
  const containerRef = useRef(null);
  const networkRef = useRef(null);
  const [tooltip, setTooltip] = useState(null);

  useEffect(() => {
    if (!containerRef.current || !graphData) return;

    const nodes = graphData.nodes.map(node => ({
      id: node.id,
      label: node.label,
      title: node.description || node.label,
      color: NODE_COLORS[node.type] || '#818cf8',
      shape: node.type === 'course' || node.type === 'tool' ? 'box' : 'dot',
      font: {
        size: node.type === 'target' ? 16 : 14,
        color: '#e2e8f0',
        face: 'system-ui',
      },
      borderWidth: node.type === 'target' ? 3 : 2,
      size: node.type === 'target' ? 40 : 30,
      mass: node.type === 'target' ? 2 : 1,
    }));

    const edges = graphData.edges.map(edge => ({
      from: edge.from,
      to: edge.to,
      label: edge.weight ? `${Math.round(edge.weight * 100)}%` : undefined,
      arrows: 'to',
      color: {
        color: edge.type === 'transfers_to'
          ? 'rgba(249, 115, 22, 0.6)'
          : 'rgba(34, 211, 238, 0.4)',
        highlight: edge.type === 'transfers_to'
          ? 'rgba(249, 115, 22, 0.9)'
          : 'rgba(34, 211, 238, 0.9)',
      },
      font: {
        size: 12,
        color: '#cbd5e1',
        face: 'system-ui',
      },
      width: 2,
      smooth: {
        type: 'continuous',
      },
    }));

    const options = {
      physics: {
        enabled: true,
        stabilization: {
          iterations: 200,
          fit: true,
        },
        barnesHut: {
          gravitationalConstant: -15000,
          centralGravity: 0.3,
          springLength: 200,
          springConstant: 0.04,
        },
        maxVelocity: 50,
        minVelocity: 0.75,
        solver: 'barnesHut',
        timestep: 0.5,
      },
      nodes: {
        physics: true,
      },
      edges: {
        physics: false,
        smooth: {
          type: 'continuous',
          forceDirection: 'none',
        },
      },
      interaction: {
        hover: true,
        navigationButtons: true,
        keyboard: false,
        zoomView: true,
        dragView: true,
      },
      configure: false,
    };

    const data = { nodes, edges };

    if (networkRef.current) {
      networkRef.current.destroy();
    }

    networkRef.current = new Network(containerRef.current, data, options);

    // Handle node hover
    networkRef.current.on('hoverNode', (event) => {
      const nodeId = event.node;
      const node = nodes.find(n => n.id === nodeId);
      if (node) {
        setTooltip({
          label: node.label,
          description: node.title,
          x: event.event.pageX,
          y: event.event.pageY,
        });
      }
    });

    networkRef.current.on('blurNode', () => {
      setTooltip(null);
    });

    // Fit to view after stabilization
    networkRef.current.once('stabilizationIterationsDone', () => {
      networkRef.current.setOptions({ physics: false });
    });

    return () => {
      if (networkRef.current) {
        networkRef.current.destroy();
        networkRef.current = null;
      }
    };
  }, [graphData]);

  return (
    <div className="visualization-container">
      <div className="visualization-content">
        <div ref={containerRef} className="viz-canvas" />
        {tooltip && (
          <div
            className="tooltip"
            style={{
              left: `${tooltip.x}px`,
              top: `${tooltip.y + 10}px`,
            }}
          >
            <div style={{ fontWeight: 700 }}>{tooltip.label}</div>
            <div style={{ fontSize: '0.8rem', marginTop: '0.25rem' }}>
              {tooltip.description}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

export default PathVisualization;
