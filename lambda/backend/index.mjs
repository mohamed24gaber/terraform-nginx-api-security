export const handler = async (event) => {
  const users = [
    {
      id: 1,
      name: "Mohamed",
      role: "Cloud Engineer"
    },
    {
      id: 2,
      name: "Ahmed",
      role: "DevOps Engineer"
    },
    {
      id: 3,
      name: "Sara",
      role: "Software Engineer"
    }
  ];

  return {
    statusCode: 200,
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      success: true,
      message: "Users retrieved successfully",
      users: users
    })
  };
};