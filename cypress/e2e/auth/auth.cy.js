let username = `cypress+${Math.round(+new Date() / 1000)}@gmail.com`;
describe("Auth Module", () => {
  it("check the components in the sign up page", () => {
    cy.visit("http://localhost:9000/");
    cy.get("#card-subtitle").click();
    cy.url().should("include", "/register");
    cy.get("#card-header").should("contain", "Welcome to Hyperswitch");
    cy.get("#card-subtitle").should("contain", "Sign in");
    cy.get("#auth-submit-btn").should("exist");
    cy.get("#tc-text").should("exist");
    cy.get("#footer").should("exist");
  });

  it("check singup flow", () => {
    const password = "cypress98#";
    cy.visit("http://localhost:9000/");
    cy.get("#card-subtitle").click();
    cy.url().should("include", "/register");
    cy.get("[data-testid=email]").type(username);
    cy.get("[data-testid=password]").type(password);
    cy.get('button[type="submit"]').click({ force: true });
    cy.url().should("eq", "http://localhost:9000/home");
  });

  it("check the components in the login page", () => {
    cy.visit("http://localhost:9000/login");
    cy.url().should("include", "/login");
    cy.get("#card-header").should("contain", "Hey there, Welcome back!");
    cy.get("#card-subtitle").should("contain", "Sign up");
    cy.get("#auth-submit-btn").should("exist");
    cy.get("#tc-text").should("exist");
    cy.get("#footer").should("exist");
  });

  it("should successfully log in with valid credentials", () => {
    const password = "cypress98#";
    cy.visit("http://localhost:9000/login");
    cy.get("[data-testid=email]").type(username);
    cy.get("[data-testid=password]").type(password);
    cy.get('button[type="submit"]').click({ force: true });
    cy.url().should("eq", "http://localhost:9000/home");
  });

  it("should display an error message with invalid credentials", () => {
    cy.visit("http://localhost:9000/");
    cy.get("[data-testid=email]").type("xxx@gmail.com");
    cy.get("[data-testid=password]").type("xxxx");
    cy.get('button[type="submit"]').click({ force: true });
    cy.contains("Incorrect email or password").should("be.visible");
  });

  it("should login successfully with email containing spaces", () => {
    const password = "cypress98#";
    cy.visit("http://localhost:9000/");
    cy.get("[data-testid=email]").type(`  ${username}  `);
    cy.get("[data-testid=password]").type(password);
    cy.get('button[type="submit"]').click({ force: true });
    cy.url().should("eq", "http://localhost:9000/home");
  });
});
