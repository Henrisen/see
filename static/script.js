Array.from(document.querySelectorAll("pre")).forEach((e) => {
    e.addEventListener("click", (i) => {
        let elm = i.target;
        if (i.target.nodeName == "CODE") elm = elm.parentNode;
        if (elm.ariaBusy) return;
        navigator.clipboard.writeText(elm.firstChild.textContent);
        let old = elm.firstChild.textContent;
        elm.firstChild.textContent = "Command Copied";
        elm.ariaBusy = "yes";
        setTimeout(() => {
            elm.firstChild.textContent = old;
            elm.ariaBusy = "";
        }, 1000);
    });
})

// Get canvas and context
const header = document.getElementById('header');
const canvas = document.getElementById('background');
const ctx = canvas.getContext('2d');

// Make sure the canvas is responsive
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

// Particle array
let particles = [];
let r=0.5329815303430079;
// Image for the background
const backgroundImage = new Image();
backgroundImage.src = https://github.com/Henrisen/see/blob/main/.github/resources/2.png?raw=true; // Random image from Lorem Picsum

// Function to create new particle
function createParticle(x, y) {
    const speed = Math.random() * 5 + 2;  // Speed of the particle
    const angle = Math.random() * Math.PI * 2;  // Random direction
    const velocityX = Math.cos(angle) * speed;
    const velocityY = Math.sin(angle) * speed;
    
    particles.push({
        x: x,
        y: y,
        radius: Math.random() * 3 + 5, // Random radius for each particle
        color: 'rgba(255, 255, 255, 0.8)', // Particle color
        velocityX: velocityX,
        velocityY: velocityY
    });
}

// Update particles
function updateParticles() {
    // Loop through each particle
    for (let i = 0; i < particles.length; i++) {
        const p = particles[i];

        // Update particle position
        p.x += p.velocityX;
        p.y += p.velocityY;

        // Fade out and shrink the particle
        p.radius -= 0.05;
        if (p.radius <= 0) {
            particles.splice(i, 1); // Remove the particle if its radius is too small
            i--;
        }
    }
}

// Draw particles
function drawParticles() {
    ctx.clearRect(0, 0, canvas.width, canvas.height); // Clear canvas
    ctx.drawImage(backgroundImage, 0, 0, canvas.width *r, canvas.height); // Draw the image as background

    for (let i = 0; i < particles.length; i++) {
        const p = particles[i];
        ctx.beginPath();
        ctx.arc(p.x, p.y, p.radius, 0, Math.PI * 2); // Draw particle as circle
        ctx.fillStyle = p.color;
        ctx.fill();
    }
}

// Mousemove event to generate particles at cursor location
header.addEventListener('mousemove', (event) => {
    // console.log(scrollX, scrollY);
    // console.log(event.x, event.y);
    createParticle(event.x + scrollX, event.y + scrollY);
});

// Animation loop to update and draw particles
function animate() {
    updateParticles();
    drawParticles();
    requestAnimationFrame(animate); // Continue the animation
}

// Start the animation
animate();

// Resize canvas on window resize
window.addEventListener('resize', () => {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
});
