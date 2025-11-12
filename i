<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SWAPPER CLONE?</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Courier New', monospace;
        }
        
        body {
            background-color: #1a1a1a;
            color: #00ff00;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }
        
        .terminal-container {
            width: 90%;
            max-width: 800px;
            height: 500px;
            background-color: #000;
            border-radius: 5px;
            box-shadow: 0 0 20px rgba(0, 255, 0, 0.3);
            overflow: hidden;
        }
        
        .terminal-header {
            background-color: #333;
            padding: 10px;
            display: flex;
            align-items: center;
        }
        
        .terminal-buttons {
            display: flex;
            gap: 8px;
        }
        
        .terminal-button {
            width: 12px;
            height: 12px;
            border-radius: 50%;
        }
        
        .close { background-color: #ff5f56; }
        .minimize { background-color: #ffbd2e; }
        .maximize { background-color: #27c93f; }
        
        .terminal-title {
            margin-left: 10px;
            color: #ccc;
            font-size: 14px;
        }
        
        .terminal-body {
            padding: 15px;
            height: calc(100% - 40px);
            overflow-y: auto;
        }
        
        .terminal-line {
            margin-bottom: 5px;
            display: flex;
        }
        
        .prompt {
            color: #00ff00;
            margin-right: 10px;
        }
        
        .input-line {
            display: flex;
            align-items: center;
        }
        
        .command-input {
            background: transparent;
            border: none;
            color: #00ff00;
            font-size: 16px;
            outline: none;
            flex: 1;
        }
        
        .output {
            white-space: pre-wrap;
            margin-bottom: 10px;
        }
        
        .progress-bar {
            width: 100%;
            height: 20px;
            background-color: #333;
            border-radius: 3px;
            margin: 10px 0;
            overflow: hidden;
        }
        
        .progress-fill {
            height: 100%;
            background-color: #00ff00;
            width: 0%;
            transition: width 0.1s;
        }
        
        .welcome-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: #000;
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 100;
            font-size: 24px;
            color: #00ff00;
            animation: fadeOut 2s forwards 3s;
        }
        
        @keyframes fadeOut {
            to {
                opacity: 0;
                visibility: hidden;
            }
        }
        
        .blink {
            animation: blink 1s infinite;
        }
        
        @keyframes blink {
            0%, 100% { opacity: 1; }
            50% { opacity: 0; }
        }
    </style>
</head>
<body>
    <div class="welcome-animation" id="welcomeAnimation">
        <span>welcome buyer</span>
    </div>
    
    <div class="terminal-container">
        <div class="terminal-header">
            <div class="terminal-buttons">
                <div class="terminal-button close"></div>
                <div class="terminal-button minimize"></div>
                <div class="terminal-button maximize"></div>
            </div>
            <div class="terminal-title">terminal swapper</div>
        </div>
        <div class="terminal-body" id="terminalBody">
            <div class="terminal-line">
                <span class="prompt">buyer@terminal:~$</span>
                <span>ketik .start pake ya bro</span>
            </div>
            <div class="input-line">
                <span class="prompt">buyer@terminal:~$</span>
                <input type="text" class="command-input" id="commandInput" autofocus>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const terminalBody = document.getElementById('terminalBody');
            const commandInput = document.getElementById('commandInput');
            const welcomeAnimation = document.getElementById('welcomeAnimation');
            
            // Setelah animasi selesai, fokus ke input
            setTimeout(() => {
                commandInput.focus();
            }, 3500);
            
            // Fungsi untuk menambahkan output ke terminal
            function addOutput(text) {
                const outputElement = document.createElement('div');
                outputElement.className = 'output';
                outputElement.textContent = text;
                terminalBody.insertBefore(outputElement, terminalBody.lastElementChild);
            }
            
            // Fungsi untuk menambahkan baris input baru
            function addNewInputLine() {
                const inputLine = document.createElement('div');
                inputLine.className = 'input-line';
                inputLine.innerHTML = `
                    <span class="prompt">buyer@terminal:~$</span>
                    <input type="text" class="command-input" autofocus>
                `;
                terminalBody.appendChild(inputLine);
                
                // Fokus ke input baru
                const newInput = inputLine.querySelector('.command-input');
                newInput.focus();
                
                // Hapus input lama
                commandInput.remove();
                
                // Tambahkan event listener ke input baru
                newInput.addEventListener('keydown', handleInput);
            }
            
            // Fungsi untuk membuat progress bar
            function createProgressBar(duration, callback) {
                const progressBar = document.createElement('div');
                progressBar.className = 'progress-bar';
                
                const progressFill = document.createElement('div');
                progressFill.className = 'progress-fill';
                progressBar.appendChild(progressFill);
                
                terminalBody.insertBefore(progressBar, terminalBody.lastElementChild);
                
                let width = 0;
                const interval = setInterval(() => {
                    width += 1;
                    progressFill.style.width = width + '%';
                    
                    if (width >= 100) {
                        clearInterval(interval);
                        setTimeout(() => {
                            progressBar.remove();
                            if (callback) callback();
                        }, 500);
                    }
                }, duration / 100);
            }
            
            // Fungsi untuk menangani input
            function handleInput(e) {
                if (e.key === 'Enter') {
                    const command = e.target.value.trim();
                    
                    // Tambahkan baris dengan perintah yang dimasukkan
                    const commandLine = document.createElement('div');
                    commandLine.className = 'terminal-line';
                    commandLine.innerHTML = `
                        <span class="prompt">buyer@terminal:~$</span>
                        <span>${command}</span>
                    `;
                    terminalBody.insertBefore(commandLine, terminalBody.lastElementChild);
                    
                    // Proses perintah
                    processCommand(command);
                    
                    // Tambahkan baris input baru
                    addNewInputLine();
                    
                    // Scroll ke bawah
                    terminalBody.scrollTop = terminalBody.scrollHeight;
                }
            }
            
            // Fungsi untuk memproses perintah
            function processCommand(command) {
                const parts = command.split(' ');
                const mainCommand = parts[0].toLowerCase();
                
                switch(mainCommand) {
                    case '.start':
                        // Clear terminal
                        while (terminalBody.children.length > 1) {
                            terminalBody.removeChild(terminalBody.firstChild);
                        }
                        
                        addOutput("hola buyer this clone swapper terminal this command already");
                        addOutput(".check account");
                        addOutput(".brute force");
                        addOutput(".clear");
                        addOutput(".swap montoon");
                        addOutput(".swap id only");
                        addOutput(".pingServer");
                        addOutput(".swap platform");
                        break;
                        
                    case '.check':
                        if (parts.length >= 3) {
                            const email = parts[1];
                            const password = parts[2];
                            const status = Math.random() > 0.5 ? "valid" : "nonvalid";
                            addOutput(`status account: ${status}`);
                        } else {
                            addOutput("syntax: .check account <email> <password>");
                        }
                        break;
                        
                    case '.brute':
                        if (parts.length >= 2 && parts[1] === "6181_brute") {
                            addOutput("EMAIL:");
                            // Simulasi input email
                            setTimeout(() => {
                                const email = "buyer" + Math.floor(Math.random() * 1000) + "@example.com";
                                const password = "pass" + Math.floor(Math.random() * 10000);
                                
                                createProgressBar(3000, () => {
                                    // Clear terminal setelah progress selesai
                                    while (terminalBody.children.length > 1) {
                                        terminalBody.removeChild(terminalBody.firstChild);
                                    }
                                    
                                    addOutput("SUCCES BRUTE FORCE");
                                    addOutput(`EMAIL: ${email}`);
                                    addOutput(`PASSWORD: ${password}`);
                                    addOutput(`KEY_EMAIL: KEYS: #916862_7186726_61852`);
                                });
                            }, 1000);
                        } else {
                            addOutput("syntax: .brute force <key_api> (6181_brute)");
                        }
                        break;
                        
                    case '.clear':
                        // Clear terminal
                        while (terminalBody.children.length > 1) {
                            terminalBody.removeChild(terminalBody.firstChild);
                        }
                        break;
                        
                    case '.swap':
                        if (parts[1] === "montoon" && parts.length >= 4) {
                            const email = parts[2];
                            const password = parts[3];
                            
                            createProgressBar(3000, () => {
                                // Clear terminal setelah progress selesai
                                while (terminalBody.children.length > 1) {
                                    terminalBody.removeChild(terminalBody.firstChild);
                                }
                                
                                addOutput("Done cek The account");
                            });
                        } else if (parts[1] === "id" && parts[2] === "only" && parts.length >= 4) {
                            const id = parts[3];
                            
                            createProgressBar(5000, () => {
                                // Clear terminal setelah progress selesai
                                while (terminalBody.children.length > 1) {
                                    terminalBody.removeChild(terminalBody.firstChild);
                                }
                                
                                addOutput("GAGAL KONTOL ID SALAH ATAU NONVALID IDIOT");
                            });
                        } else if (parts[1] === "platform" && parts.length >= 4) {
                            const email = parts[2];
                            const password = parts[3];
                            
                            createProgressBar(5000, () => {
                                // Clear terminal setelah progress selesai
                                while (terminalBody.children.length > 1) {
                                    terminalBody.removeChild(terminalBody.firstChild);
                                }
                                
                                addOutput("GAGAL KONTOL NONVALID ATAU SANDI SALAH IDIOT");
                            });
                        } else {
                            addOutput("syntax: .swap <montoon|id only|platform> <params>");
                        }
                        break;
                        
                    case '.pingserver':
                        // Clear terminal
                        while (terminalBody.children.length > 1) {
                            terminalBody.removeChild(terminalBody.firstChild);
                        }
                        
                        addOutput("STATUS SERVER");
                        addOutput("PING USER: 999ms");
                        addOutput("PING SERVER: 1ms");
                        addOutput("STATUS USER: online");
                        addOutput("");
                        addOutput("OWNER: clonetressert");
                        break;
                        
                    default:
                        addOutput(`command not found: ${command}`);
                        addOutput("available commands: .start, .check, .brute, .clear, .swap, .pingServer");
                }
            }
            
            // Tambahkan event listener ke input
            commandInput.addEventListener('keydown', handleInput);
        });
    </script>
</body>
</html>
