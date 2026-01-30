
                const slot = document.getElementById("slot-lines");
                const lineHeight = 1.5; // em
                const interval = 2000;
              
                function scrollSlot() {
                  // Animate scroll up
                  slot.style.transform = `translateY(-${lineHeight}em)`;
              
                  // After animation ends, rearrange
                  setTimeout(() => {
                    // Move first element to bottom
                    const first = slot.children[0];
                    slot.appendChild(first);
              
                    // Instantly reset transform (no animation)
                    slot.style.transition = "none";
                    slot.style.transform = "translateY(0)";
              
                    // Re-enable transition
                    setTimeout(() => {
                      slot.style.transition = "transform 0.6s ease-in-out";
                    }, 50);
                  }, 600); // match animation duration
                }
              
                setInterval(scrollSlot, interval);