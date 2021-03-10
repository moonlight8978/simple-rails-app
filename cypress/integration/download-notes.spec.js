describe("Download notes csv", () => {
  beforeEach(() => {
    const downloadsFolder = Cypress.config("downloadsFolder");
    cy.task("deleteFolder", downloadsFolder);
    cy.app("clean");
    cy.clearCookies();
    cy.appFactories([["create", "user", { username: "depzaivler" }]]);
    cy.appFactories([
      [
        "create",
        "note",
        "for_user",
        {
          username: "depzaivler",
          title: "ttt",
          content: "ccc",
          created_at: new Date("2021-01-01"),
        },
      ],
    ]);
    cy.login("depzaivler");
  });

  it("download with correct data", () => {
    cy.visit("/notes");
    cy.intercept(
      {
        pathname: "/notes.csv",
      },
      (req) => {
        req.redirect("/notes");
      }
    ).as("csv");

    cy.get("[data-cy=download_csv]").click();
    cy.wait("@csv")
      .its("request")
      .then((req) => {
        cy.request(req).then(({ body, headers }) => {
          expect(headers).to.have.property("content-type", "text/csv");

          cy.task("parseCsv", body).then((csv) => {
            expect(csv).to.deep.equal([
              ["Title", "Content", "Important", "Created at"],
              ["ttt", "ccc", "0", "2021-01-01"],
            ]);
          });
        });
      });
  });
});
