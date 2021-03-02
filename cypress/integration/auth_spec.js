describe("Auth flow", function () {
  beforeEach(() => {
    cy.app("clean");
    cy.clearCookies();
  });

  it("create an account then sign in successfully", () => {
    cy.appFactories([["create", "user", { username: "depzaivler" }]]);

    cy.visit("/");
    cy.contains("Guest");
    cy.contains("Sign in").click();

    cy.get("[data-cy=username]").type("depzaivler");
    cy.get("[data-cy=password]").type("123456");
    cy.get("[data-cy=submit]").click();

    cy.contains("depzaivler");
    cy.get("[data-cy=sign_out]").click();

    cy.contains("Guest");
  });
});
