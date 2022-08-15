/** @type {import('ts-jest/dist/types').InitialOptionsTsJest} */
module.exports = {
    preset: `ts-jest`,
    testEnvironment: `node`,
    moduleFileExtensions: [`js`, `ts`, `json`, `node`],
    testMatch: [`**/*.test.ts`],
    moduleNameMapper: {
        '^~/(.*)$': `<rootDir>/$1`
    },
    setupFiles: [`<rootDir>/test/setup.ts`]
}
