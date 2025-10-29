document.addEventListener("DOMContentLoaded", function() {
  const startButton = document.getElementById("startButton");
  const homeScreen = document.getElementById("homeScreen");
  const generatorScreen = document.getElementById("generatorScreen");
  const generateButton = document.getElementById("generateBtn");
  const copyButton = document.getElementById("copyBtn");
  const modifyButton = document.getElementById("modifyBtn");
  const phraseOutput = document.getElementById("phraseOutput");
  const pseudoDisplay = document.getElementById("pseudoDisplay");
  const themeToggle = document.getElementById("themeToggle");

  startButton.addEventListener("click", () => {
    homeScreen.style.display = "none";
    generatorScreen.style.display = "flex";
  });

  generateButton.addEventListener("click", async () => {
    const username = pseudoDisplay.value.trim();
    const response = await fetch("/generate", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ username }),
    });
    const data = await response.json();
    phraseOutput.value = data.phrase;
  });

  copyButton.addEventListener("click", () => {
    const phrase = phraseOutput.value;
    if (phrase) {
      navigator.clipboard.writeText(phrase);
      alert("📋 Phrase copiée !");
    } else {
      alert("⚠️ Aucune phrase à copier !");
    }
  });

  modifyButton.addEventListener("click", () => {
    const newPseudo = prompt("Entre ton pseudo Instagram :", pseudoDisplay.value);
    if (newPseudo !== null) pseudoDisplay.value = newPseudo.trim();
  });

  themeToggle.addEventListener("click", () => {
    document.body.classList.toggle("light");
  });
});