// Zeta Oficina Móvel - OCR local no navegador.
// Tesseract.js é carregado pelo index.html e o modelo é cacheado pelo navegador.
(() => {
  let workerPromise = null;

  async function getWorker() {
    if (!window.Tesseract) {
      throw new Error('Tesseract.js não foi carregado. Verifique a conexão com a internet.');
    }
    if (!workerPromise) {
      workerPromise = (async () => {
        const worker = await window.Tesseract.createWorker('eng');
        await worker.setParameters({
          preserve_interword_spaces: '1',
          user_defined_dpi: '300'
        });
        return worker;
      })();
    }
    return workerPromise;
  }

  window.zetaReadOdometerText = async function (dataUrl) {
    const worker = await getWorker();
    const result = await worker.recognize(dataUrl);
    return (result && result.data && result.data.text) ? result.data.text : '';
  };
})();
