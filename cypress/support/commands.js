// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add("login", (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add("drag", { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add("dismiss", { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This is will overwrite an existing command --
// Cypress.Commands.overwrite("visit", (originalFn, url, options) => { ... })
Cypress.Commands.add("checkMail", (content) => {
  cy.visit("/letter_opener");

  cy.get("iframe")
    .its("0.contentDocument")
    .should("exist")
    .its("body")
    .should("not.be.undefined")
    .then(cy.wrap)
    .get("#mail")
    .its("0.contentDocument")
    .should("exist")
    .its("body")
    .should("not.be.undefined")
    .then(cy.wrap)
    .contains(content)
    .should("be.visible");
});

Cypress.Commands.add("login", (username, password = "123456") => {
  cy.visit("/sign_in");

  cy.get("[data-cy=username]").type(username);
  cy.get("[data-cy=password]").type(password);
  cy.get("[data-cy=submit]").click();
});

Cypress.Commands.add(
  "attachFile",
  {
    prevSubject: "element",
  },
  (input, fileName, fileType) => {
    cy.fixture(fileName, "base64")
      .then((content) => Cypress.Blob.base64StringToBlob(content, fileType))
      .then((blob) => {
        const testFile = new File([blob], fileName);
        const dataTransfer = new DataTransfer();

        dataTransfer.items.add(testFile);
        input[0].files = dataTransfer.files;
        return input;
      });
  }
);

Cypress.Commands.add("download", (subject) => {
  return cy.wait(subject).its("request").then(cy.request);
});
