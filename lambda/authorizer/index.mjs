export const handler = async (event) => {
  const headers = event.headers || {};

  const environment = headers["x-environment"] || "";
  const studentId = headers["x-student-id"] || "";
  const internalToken = headers["x-internal-token"] || "";

  const expectedToken = process.env.INTERNAL_TOKEN;

  const isAuthorized =
    environment === "dev" &&
    studentId.trim().length > 0 &&
    Boolean(expectedToken) &&
    internalToken === expectedToken;

  return {
    isAuthorized,
    context: {
      studentId: studentId,
      environment: environment
    }
  };
};