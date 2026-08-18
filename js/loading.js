
(function () {
    var MIN_DURATION = 3000;    // loader never shorter than this
    var MAX_DURATION = 10000;   // safety net: never stuck longer than this

    // List everything the first screen needs. Empty array is fine.
    var ASSETS = [
        // 'images/bg.jpg',
        // 'images/title.png'
    ];
    var QUOTES = [
        "空っぽなのに心が",
        "痛むんだ",
        "今日がどうにも寂しくってさ",
        "眠れないままだけどさ",
        "いつか幸せって思えるまで",
        "君は君のままでいてよ"
    ];

    var screenEl = document.getElementById('loading-screen');
    var fill     = screenEl.querySelector('#fill');
    var text     = screenEl.querySelector('.loading-text');
    var message  = screenEl.querySelector('.loading-message');
    var audioEl  = document.getElementById('background-audio');

    text.textContent = QUOTES[Math.floor(Math.random() * QUOTES.length)];

    var startTime = Date.now();
    var total     = ASSETS.length + (audioEl ? 1 : 0);
    var loaded    = 0;
    var ready     = false;

    function step() {
        loaded++;
        if (loaded >= total) finished();
    }

    ASSETS.forEach(function (src) {
        var img = new Image();
        img.onload  = step;
        img.onerror = step;     // a 404 must not stall the bar
        img.src = src;
    });

    if (audioEl) {
        audioEl.addEventListener('canplaythrough', step, { once: true });
        audioEl.addEventListener('error', step, { once: true });
    }

    // Bar follows whichever is further behind: real progress, or the clock.
    function updateBar() {
        var byAssets = total ? (loaded / total) * 100 : 100;
        var byTime   = ((Date.now() - startTime) / MIN_DURATION) * 100;
        var pct = Math.min(byAssets, byTime, 100);

        fill.style.width = pct + '%';
        if (pct > 35) text.classList.add('on');
        if (!ready) requestAnimationFrame(updateBar);
    }
    requestAnimationFrame(updateBar);

    function finished() {
        if (ready) return;

        // If assets finished early, wait out the remainder of the floor.
        var elapsed = Date.now() - startTime;
        if (elapsed < MIN_DURATION) {
            setTimeout(finished, MIN_DURATION - elapsed);
            return;
        }

        ready = true;
        fill.style.width = '100%';
        text.classList.add('on');
        message.classList.add('on');
        document.addEventListener('click', dismiss, { once: true });
    }

    setTimeout(finished, MAX_DURATION);

    function dismiss() {
        screenEl.classList.add('shrink-rotate-out');
        setTimeout(function () { screenEl.style.display = 'none'; }, 900);

        if (audioEl) {
            audioEl.play().catch(function (err) {
                console.error('Audio play failed:', err);
            });
        }
    }
})();