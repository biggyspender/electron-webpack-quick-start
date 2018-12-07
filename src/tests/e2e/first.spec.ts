import { Application } from "spectron";
import * as path from "path"
describe("first test", function () {
    jest.setTimeout(10000);
    let app: Application;
    beforeEach(function () {
        const projectRoot = path.join(__dirname, '..', '..', '..');
        const electronPath = path.join(projectRoot, 'node_modules', '.bin', 'electron')
        const appPath = path.join(projectRoot, 'dist', 'main', 'main.js')
        app = new Application({ path: electronPath, args: [appPath], env: { IS_SPECTRON: "true" } })

        return app.start();
    })
    afterEach(function () {
        return (app && app.stop()) || Promise.resolve();
    })
    test("test1", async function () {
        await app.client.waitForExist('#counter-navlink')
        await app.client.click('#counter-navlink')
        const valStr = await app.client.getText('#counter-count')
        const val = parseInt(valStr)
        expect(val).not.toBeNaN()
        await app.client.click('#increment-button')
        const newValStr = await app.client.getText('#counter-count')
        const newVal = parseInt(newValStr)
        expect(newVal).toBe(val + 1)
    })

})