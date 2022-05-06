export const handler = async (event: any) => {
  return {
    statusCode: 200,
    body: JSON.stringify(
      {
        message: `Hello, world! It's ${new Date().toISOString()}!`,
      },
      null,
      2
    ),
  };
};
