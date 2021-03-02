describe("Rails using factory bot examples", function () {
  beforeEach(() => {
    cy.app("clean");
    cy.clearCookies();
  });

  it("using single factory bot", function () {
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
