/// <reference types="cypress" />
// ***********************************************************
// This example plugins/index.js can be used to load plugins
//
// You can change the location of this file or turn off loading
// the plugins file with the 'pluginsFile' configuration option.
//
// You can read more here:
// https://on.cypress.io/plugins-guide
// ***********************************************************

// This function is called when a project is opened or re-opened (e.g. due to
// the project's config changing)

const fs = require("fs");
const parse = require("csv-parse");

/**
 * @type {Cypress.PluginConfig}
 */
module.exports = (on, config) => {
  // `on` is used to hook into various events Cypress emits
  // `config` is the resolved Cypress config
  on("task", {
    deleteFolder(folderName) {
      fs.rmdirSync(folderName, { maxRetries: 10, recursive: true });
      return null;
    },

    parseCsv(body) {
      return new Promise((resolve, reject) => {
        parse(body, (err, csv) => {
          if (err) {
            reject(err);
          }

          resolve(csv);
        });
      });
    },
  });
};
