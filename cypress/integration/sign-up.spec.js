describe("Sign up", () => {
  beforeEach(() => {
    cy.app("clean");
    cy.clearCookies();
    cy.appFactories([["create", "user", { username: "depzaivler" }]]);
  });

  it("show validation errors", () => {
    cy.visit("/sign_up");

    cy.get("[data-cy=submit]").click();
    cy.get("[data-cy=username_error]")
      .should("be.visible")
      .and("contain", "Username can't be blank");

    cy.get("[data-cy=username]").type("depzaivler");
    cy.get("[data-cy=submit]").click();
    cy.get("[data-cy=username_error]")
      .should("be.visible")
      .and("contain", "Username has already been taken");

    cy.get("[data-cy=username]").clear();

    cy.get("[data-cy=password_error]")
      .should("be.visible")
      .and("contain", "Password can't be blank");
    cy.get("[data-cy=password_confirmation_error]")
      .should("be.visible")
      .and("contain", "Password confirmation can't be blank");

    cy.get("[data-cy=password]").type("pass");
    cy.get("[data-cy=password_confirmation]").type("word");
    cy.get("[data-cy=submit]").click();
    cy.get("[data-cy=password_confirmation_error]")
      .should("be.visible")
      .and("contain", "Password confirmation doesn't match Password");

    cy.get("[data-cy=email_error]").should("not.exist");

    cy.get("[data-cy=email_notification_enabled]").check();
    cy.get("[data-cy=submit]").click();
    cy.get("[data-cy=email_error]")
      .should("be.visible")
      .and("contain", "Email can't be blank");

    cy.get("[data-cy=email]").type("wrong_email_format");
    cy.get("[data-cy=submit]").click();
    cy.get("[data-cy=email_error]")
      .should("be.visible")
      .and("contain", "Email is invalid");

    cy.get("[data-cy=email]").clear().type("depzai@example.com");
    cy.get("[data-cy=submit]").click();
    cy.get("[data-cy=email_error]").should("not.exist");
  });

  it("register successfully without notification", () => {
    cy.visit("/sign_up");

    cy.get("[data-cy=username]").type("depzai");
    cy.get("[data-cy=password]").type("123456");
    cy.get("[data-cy=password_confirmation]").type("123456");
    cy.get("[data-cy=submit]").click();

    cy.get("[data-cy=welcome]").should("be.visible").and("contain", "depzai");
  });

  it("register successfully with notification", () => {
    cy.visit("/sign_up");

    cy.get("[data-cy=username]").type("depzai");
    cy.get("[data-cy=password]").type("123456");
    cy.get("[data-cy=password_confirmation]").type("123456");
    cy.get("[data-cy=email_notification_enabled]").check();
    cy.get("[data-cy=email]").type("depzai@example.com");
    cy.get("[data-cy=submit]").click();

    cy.get("[data-cy=welcome]").should("be.visible").and("contain", "depzai");

    cy.checkMail("Welcome to Simple Rails App, depzai");
  });
});
