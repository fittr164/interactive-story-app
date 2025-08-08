<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Interactive Story: A Journey to Find Solace</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <!-- Chosen Palette: Earthy Neutrals -->
    <!-- Application Structure Plan: The application is structured as a three-act narrative journey: 'The City' (Act 1), 'The Mountains' (Act 2), and 'The Return' (Act 3). This thematic structure allows users to follow the protagonist's emotional and physical transformation logically. Navigation is handled by clear buttons that guide the user from one act to the next, creating a linear but engaging story flow. The core interaction involves revealing story text sequentially and visualizing the protagonist's emotional state through an interactive chart, which makes the abstract concept of an 'internal journey' tangible and easier to understand. -->
    <!-- Visualization & Content Choices: 
        - Report Info: Protagonist's feeling of being overwhelmed in the city. -> Goal: Inform & Engage. -> Viz/Method: Dynamic text blocks revealed on click. -> Interaction: User clicks 'Next' to progress through the narrative snippets. -> Justification: Simulates the feeling of being bombarded by information, mirroring the story's theme. -> Library/Method: Vanilla JS.
        - Report Info: The contrast between the chaotic city life and the serene mountain life. -> Goal: Compare & Analyze. -> Viz/Method: A dynamic doughnut chart representing 'Mind State'. -> Interaction: The chart's data updates as the user navigates from Act 1 to Act 3, visually showing the shift from 'Chaos' to 'Clarity' and 'Harmony'. -> Justification: Provides a powerful, at-a-glance visualization of the protagonist's internal transformation, which is the core message of the report. -> Library/Method: Chart.js.
        - Report Info: Key vocabulary representing emotional and physical states. -> Goal: Inform & Reinforce. -> Viz/Method: Highlighting key terms within the text. -> Interaction: Users can hover over highlighted words (though no pop-up is implemented to keep it simple) to note important concepts. -> Justification: Draws attention to the rich vocabulary in the source text, aiding comprehension and retention. -> Library/Method: HTML/CSS.
    -->
    <!-- CONFIRMATION: NO SVG graphics used. NO Mermaid JS used. -->
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #FDF8F0;
            color: #4A4A4A;
        }
        .nav-button {
            transition: all 0.3s ease;
        }
        .nav-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .text-highlight {
            background-color: #E9E2D9;
            padding: 2px 4px;
            border-radius: 4px;
            font-weight: 600;
            color: #8C6A4D;
        }
        .chart-container {
            position: relative;
            width: 100%;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
            height: 300px;
            max-height: 400px;
        }
        @media (min-width: 768px) {
            .chart-container {
                height: 350px;
            }
        }
    </style>
</head>
<body class="antialiased">

    <div class="container mx-auto p-4 md:p-8 max-w-5xl">
        
        <header class="text-center mb-8 md:mb-12">
            <h1 class="text-4xl md:text-5xl font-bold text-[#8C6A4D] mb-2">A Journey to Find Solace</h1>
            <p class="text-lg text-gray-600">An interactive exploration of an internal transformation.</p>
        </header>

        <main id="app" class="bg-white/60 backdrop-blur-sm p-6 md:p-10 rounded-2xl shadow-lg border border-gray-200">
            
            <!-- Navigation -->
            <nav class="flex justify-center space-x-2 md:space-x-4 mb-8">
                <button id="nav-act1" class="nav-button py-2 px-4 md:px-6 bg-[#8C6A4D] text-white rounded-full font-semibold shadow-md">Act I: The City</button>
                <button id="nav-act2" class="nav-button py-2 px-4 md:px-6 bg-gray-300 text-gray-700 rounded-full font-semibold">Act II: The Mountains</button>
                <button id="nav-act3" class="nav-button py-2 px-4 md:px-6 bg-gray-300 text-gray-700 rounded-full font-semibold">Act III: The Return</button>
            </nav>

            <!-- Content Area -->
            <div id="content-area">
                <!-- Populated by JS -->
            </div>

        </main>

    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const app = document.getElementById('app');
            const contentArea = document.getElementById('content-area');
            const navButtons = {
                act1: document.getElementById('nav-act1'),
                act2: document.getElementById('nav-act2'),
                act3: document.getElementById('nav-act3'),
            };

            const storyData = {
                act1: {
                    title: "The Oppressive City",
                    intro: "The story begins in a bustling city, where the protagonist feels overwhelmed and lost. The constant noise and relentless pace have led to a profound sense of dissatisfaction. This section explores the feelings of being trapped and the desperate need for an escape.",
                    narrative: [
                        "The city, with its perpetual hum and relentless pace, had become an <span class='text-highlight'>oppressive</span> force, a vast machine with no pause button.",
                        "For years, I had navigated its <span class='text-highlight'>labyrinthine</span> streets, driven by a fierce ambition to succeed, a pursuit that now felt hollow and <span class='text-highlight'>unfulfilling</span>.",
                        "The <span class='text-highlight'>cacophony</span> of daily life—the blaring horns, the crowded subways, the constant barrage of digital notifications—had created a deafening noise in my mind.",
                        "This profound feeling of <span class='text-highlight'>disquiet</span> compelled me to seek an escape, a radical change of scenery that might offer some form of <span class='text-highlight'>solace</span>. The decision was an <span class='text-highlight'>impulsive</span> and desperate plea for sanity."
                    ],
                    chartData: {
                        labels: ['Chaos', 'Clarity', 'Harmony'],
                        data: [80, 10, 10],
                        title: "Mind State: Overwhelmed"
                    }
                },
                act2: {
                    title: "The Mountain's Embrace",
                    intro: "Seeking refuge, the protagonist travels to a remote mountain region. This act details the physical and mental challenges of this new environment and the gradual shift from discomfort to peace. It's a journey of endurance that leads to a powerful internal discovery.",
                    narrative: [
                        "My journey began with a departure from the familiar, an <span class='text-highlight'>impromptu</span> decision to travel to a remote, mountainous region where civilization was a distant memory.",
                        "The initial days were an exercise in sheer <span class='text-highlight'>endurance</span>. The hiking trails were <span class='text-highlight'>arduous</span>, and the silence was so complete it was almost unsettling.",
                        "I was confronted with a stark reality: my physical strength, much like my mental fortitude, had been <span class='text-highlight'>eroded</span> by my sedentary urban existence.",
                        "Yet, with each step, a sense of clarity began to <span class='text-highlight'>emerge</span>. I was forced to be <span class='text-highlight'>present</span>, rather than being <span class='text-highlight'>consumed</span> by worries of the past or anxieties about the future.",
                        "This solitude, initially a source of deep discomfort, gradually transformed into a profound and <span class='text-highlight'>rejuvenating</span> sense of peace. I realized my previous quest for external validation had been a misguided one."
                    ],
                    chartData: {
                        labels: ['Chaos', 'Clarity', 'Harmony'],
                        data: [20, 60, 20],
                        title: "Mind State: Finding Clarity"
                    }
                },
                act3: {
                    title: "The Harmonious Return",
                    intro: "Returning to the city, the protagonist is no longer the same person. This final act explores how the lessons learned in the mountains are applied to urban life. The external environment hasn't changed, but the internal perspective has, leading to a new sense of purpose and calm.",
                    narrative: [
                        "True fulfillment, I began to <span class='text-highlight'>surmise</span>, was an <span class='text-highlight'>intrinsic</span> quality, not an external prize to be won. The journey wasn't about conquering the mountains, but about confronting the quiet chaos within myself.",
                        "I returned to the city with a newfound sense of purpose, not to escape its challenges, but to <span class='text-highlight'>engage</span> with them with a more <span class='text-highlight'>harmonious</span> and deliberate perspective.",
                        "The clamor of the streets was still there, but now, I had learned how to silence my own <span class='text-highlight'>internalized</span> noise.",
                        "I was no longer a vessel adrift, but an anchored ship, navigating the turbulent waters of modern life with a calm and determined spirit. The mountains had given me the tools to change my perspective."
                    ],
                    chartData: {
                        labels: ['Chaos', 'Clarity', 'Harmony'],
                        data: [10, 30, 60],
                        title: "Mind State: Harmonious"
                    }
                }
            };

            let chartInstance = null;

            function renderContent(act) {
                const data = storyData[act];
                let narrativeHtml = data.narrative.map((p, index) => `<p class="text-lg md:text-xl mb-4 opacity-0" style="transition-delay: ${index * 150}ms;">${p}</p>`).join('');

                contentArea.innerHTML = `
                    <div class="text-center mb-8">
                        <h2 class="text-3xl font-bold text-[#8C6A4D]">${data.title}</h2>
                        <p class="mt-2 text-gray-600 max-w-2xl mx-auto">${data.intro}</p>
                    </div>
                    <div class="grid md:grid-cols-2 gap-8 items-center">
                        <div id="narrative-text">
                            ${narrativeHtml}
                        </div>
                        <div class="chart-container">
                            <canvas id="mindStateChart"></canvas>
                        </div>
                    </div>
                `;
                
                setTimeout(() => {
                    document.querySelectorAll('#narrative-text p').forEach(p => {
                        p.classList.remove('opacity-0');
                        p.classList.add('transition-opacity', 'duration-500');
                    });
                }, 100);

                updateNav(act);
                renderChart(data.chartData);
            }

            function updateNav(activeAct) {
                Object.keys(navButtons).forEach(key => {
                    if (key === activeAct) {
                        navButtons[key].classList.remove('bg-gray-300', 'text-gray-700');
                        navButtons[key].classList.add('bg-[#8C6A4D]', 'text-white');
                    } else {
                        navButtons[key].classList.remove('bg-[#8C6A4D]', 'text-white');
                        navButtons[key].classList.add('bg-gray-300', 'text-gray-700');
                    }
                });
            }

            function renderChart(chartData) {
                const ctx = document.getElementById('mindStateChart').getContext('2d');
                if (chartInstance) {
                    chartInstance.destroy();
                }
                chartInstance = new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: chartData.labels,
                        datasets: [{
                            label: 'Mind State',
                            data: chartData.data,
                            backgroundColor: [
                                'rgba(239, 68, 68, 0.7)', // Chaos (Red)
                                'rgba(59, 130, 246, 0.7)', // Clarity (Blue)
                                'rgba(16, 185, 129, 0.7)'  // Harmony (Green)
                            ],
                            borderColor: [
                                'rgba(239, 68, 68, 1)',
                                'rgba(59, 130, 246, 1)',
                                'rgba(16, 185, 129, 1)'
                            ],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'top',
                            },
                            title: {
                                display: true,
                                text: chartData.title,
                                font: {
                                    size: 18
                                }
                            }
                        },
                        animation: {
                            animateScale: true,
                            animateRotate: true
                        }
                    }
                });
            }

            navButtons.act1.addEventListener('click', () => renderContent('act1'));
            navButtons.act2.addEventListener('click', () => renderContent('act2'));
            navButtons.act3.addEventListener('click', () => renderContent('act3'));

            // Initial render
            renderContent('act1');
        });
    </script>
</body>
</html>
