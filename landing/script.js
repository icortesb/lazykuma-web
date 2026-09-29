async function copyText(text) {
  try {
    await navigator.clipboard.writeText(text);
    return true;
  } catch {
    return false;
  }
}

const copyBtn = document.getElementById('copy-btn');
const installCmd = document.getElementById('install-cmd');
const installBar = document.querySelector('.install');

if (installBar && installCmd && copyBtn) {
  installBar.addEventListener('click', async () => {
    const ok = await copyText(installCmd.textContent.trim());
    copyBtn.textContent = ok ? 'copied' : 'select & copy';
    setTimeout(() => { copyBtn.textContent = 'copy'; }, 1800);
  });
}

document.querySelectorAll('.install-option pre').forEach((pre) => {
  pre.classList.add('copyable');
  pre.tabIndex = 0;
  pre.setAttribute('role', 'button');
  pre.setAttribute('aria-label', 'Copy command');

  const trigger = async () => {
    const ok = await copyText(pre.textContent.trim());
    pre.classList.toggle('copied', ok);
    setTimeout(() => pre.classList.remove('copied'), 1400);
  };

  pre.addEventListener('click', trigger);
  pre.addEventListener('keydown', (e) => {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      trigger();
    }
  });
});
