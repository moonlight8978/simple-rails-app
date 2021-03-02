describe("Sudo authentication", () => {
  beforeEach(() => {
    cy.app("clean");
    cy.clearCookies();
    cy.appFactories([["create", "user", { username: "depzaivler" }]]);
  });

  it("requires sudo password to access route", () => {
    cy.login("depzaivler");

    cy.visit("/");
    cy.get("[data-cy=to_change_notification_settings]").click();

    cy.get("[data-cy=password]").type("123456");
    cy.get("[data-cy=submit]").click();

    cy.contains("Change notification settings").should("be.visible");
  });

  it("show validation errors, and redirect correctly", () => {
    cy.login("depzaivler");

    cy.visit("/");
    cy.get("[data-cy=to_change_notification_settings]").click();

    cy.get("[data-cy=password]").type("wrong");
    cy.get("[data-cy=submit]").click();
    cy.get("[data-cy=password_error]")
      .should("be.visible")
      .and("contain", "Password is mismatch");

    cy.get("[data-cy=password]").clear().type("123456");
    cy.get("[data-cy=submit]").click();

    cy.contains("Change notification settings").should("be.visible");
  });
});
