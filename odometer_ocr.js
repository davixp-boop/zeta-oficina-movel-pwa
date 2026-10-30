// Zeta Oficina Móvel - OCR do hodômetro no navegador
(() => {
  let workerPromise = null;

  async function getWorker() {
    if (!window.Tesseract) {
      throw new Error('Tesseract.js não foi carregado.');
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

    return result?.data?.text ?? '';
  };
})();
