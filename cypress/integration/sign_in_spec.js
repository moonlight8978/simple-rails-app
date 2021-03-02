describe("Sign in", function () {
  beforeEach(() => {
    cy.app("clean");
    cy.clearCookies();
    cy.appFactories([["create", "user", { username: "depzaivler" }]]);
  });

  it("sign in successfully", () => {
    cy.visit("/sign_in");

    cy.get("[data-cy=username]").type("depzaivler");
    cy.get("[data-cy=password]").type("123456");
    cy.get("[data-cy=submit]").click();

    cy.contains("depzaivler");
  });

  it("show errors", () => {
    cy.visit("/sign_in");

    cy.get("[data-cy=submit]").click();
    cy.get("[data-cy=username_error]")
      .should("be.visible")
      .and("contain", "Username can't be blank");

    cy.get("[data-cy=username]").type("depzai");
    cy.get("[data-cy=submit]").click();
    cy.get("[data-cy=username_error]")
      .should("be.visible")
      .and("contain", "Username is mismatch");

    cy.get("[data-cy=username]").clear().type("depzaivler");
    cy.get("[data-cy=submit]").click();
    cy.get("[data-cy=username_error]").should("not.exist");

    cy.get("[data-cy=username]").clear();

    cy.get("[data-cy=password_error]")
      .should("be.visible")
      .and("contain", "Password can't be blank");

    cy.get("[data-cy=password]").type("wrong");
    cy.get("[data-cy=submit]").click();
    cy.get("[data-cy=password_error]")
      .should("be.visible")
      .and("contain", "Password is mismatch");

    cy.get("[data-cy=username]").clear().type("depzaivler");
    cy.get("[data-cy=password]").type("123456");
    cy.get("[data-cy=submit]").click();

    cy.get("[data-cy=welcome]")
      .should("be.visible")
      .and("contain", "depzaivler");
  });
});
