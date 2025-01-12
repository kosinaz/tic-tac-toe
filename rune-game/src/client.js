// Wait for the Rune client to initialize
Rune.initClient({
	onChange: () => {
	  console.log("Rune client initialized");
  
	  // Create an iframe to load the Godot project
	  const iframe = document.createElement("iframe");
	  iframe.src = "/godot/index.html"; // Path to your Godot project's HTML file
	  iframe.style.position = "absolute";
	  iframe.style.top = "0";
	  iframe.style.left = "0";
	  iframe.style.width = "100%";
	  iframe.style.height = "100%";
	  iframe.style.border = "none";
  
	  // Clear the board and append the iframe
	  const board = document.getElementById("board");
	  board.innerHTML = ""; // Clear existing content
	  board.appendChild(iframe);
	},
  });
  