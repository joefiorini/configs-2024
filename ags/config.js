const main = '/tmp/ags/main.js';

try {
    await import(`file://${main}`);
} catch (error) {
    console.error(error);
    App.quit();
}
