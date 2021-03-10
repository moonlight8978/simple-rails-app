describe("Import notes", () => {
  beforeEach(() => {
    cy.app("clean");
    cy.clearCookies();
    cy.appFactories([["create", "user", { username: "depzaivler" }]]);
    cy.login("depzaivler");
  });

  it("import successfully", () => {
    cy.visit("/import_notes/new");

    cy.get("[data-cy=csv]")
      .attachFile("sample_book.csv")
      .trigger("change", { force: true });
    cy.get("[data-cy=upload_csv]").click();
    cy.get("[data-cy=notice]").should("be.visible").and("contain", "Success");

    cy.visit("/notes");
    cy.get("[data-cy=note]").should("have.length", 2);
  });

  it("import failed", () => {
    cy.visit("/import_notes/new");

    cy.get("[data-cy=csv]")
      .attachFile("sample_invalid_books.csv")
      .trigger("change", { force: true });

    cy.get("[data-cy=upload_csv]").click();

    cy.get("[data-cy=error]")
      .should("be.visible")
      .and("contain", "Row 1: Title can't be blank")
      .and("contain", "Row 2: Important is not included in the list")
      .and("contain", "Row 2: Created at is invalid");
  });
});
