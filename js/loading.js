
      // After 3 seconds, show the "Please click anywhere to start" message
      setTimeout(function() {
          document.querySelector('.loading-message').style.opacity = '1';
      }, 3000);
    
      // Event listener for clicks to remove the loading screen
      document.addEventListener('click', function() {
          const loadingScreen = document.getElementById('loading-screen');
          loadingScreen.classList.add('shrink-rotate-out'); // Add rotating effect
          loadingScreen.classList.add('hidden'); // Hide the loading screen with fade-out
    
          // Optionally, prevent any other clicks from triggering the loading screen to hide again
          document.removeEventListener('click', arguments.callee);
      });


        // Create AudioContext and connect the audio
        let audioContext = new (window.AudioContext || window.webkitAudioContext)();
        let audioElement = document.getElementById('background-audio');
        let audioSource = audioContext.createMediaElementSource(audioElement);
        audioSource.connect(audioContext.destination);
    
        // Start the audio only after user scrolls
        let hasPlayed = false;  // Flag to ensure audio only plays once
    
        window.addEventListener('click', () => {
            if (!hasPlayed) {
                audioContext.resume().then(() => {
                    audioElement.play().catch(function(error) {
                        console.error('Audio play failed:', error);
                    });
                    hasPlayed = true; // Ensure audio is not played again
                });
            }
        });