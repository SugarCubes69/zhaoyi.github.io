
        // Firefly effect
        const portfolio = document.getElementById('honkai');
        const fireflyCount = 67; // number of fireflies
        
        for (let i = 0; i < fireflyCount; i++) {
          const firefly = document.createElement('div');
          firefly.className = 'firefly';
          
          // Random starting position
          firefly.style.left = Math.random() * portfolio.offsetWidth + 'px';
          firefly.style.top = Math.random() * portfolio.offsetHeight + 'px';
          
          // Random animation duration and delay
          firefly.style.animationDuration = 5 + Math.random() * 5 + 's';
          firefly.style.animationDelay = Math.random() * 5 + 's';
          
          portfolio.appendChild(firefly);
        }