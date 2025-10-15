document.getElementById('ping').addEventListener('click', async () => {
  const out = document.getElementById('out');
  try {
    const res = await fetch('/api/info');
    const data = await res.json();
    out.textContent = JSON.stringify(data, null, 2);
  } catch (e) {
    out.textContent = 'Error: ' + e.message;
  }
});
