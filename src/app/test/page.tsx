import { redirect } from "next/navigation";
import newrelic from "newrelic";

// @ts-ignore
export default async function ErrorPage({ searchParams }) {
  const { error } = await searchParams;

  switch (error) {
    case "type":
      const typeError = new TypeError("Type error occurred");
      newrelic.noticeError(typeError, {
        custom: "value",
      });
      throw typeError;

    case "promise":
      const someVariable = false;

      const PTest = () =>
        new Promise((res, rej) => {
          if (someVariable) res("resolved");
          else rej("rejected");
        });

      PTest()
        .then(function (res) {
          console.log("Promise Resolved: ", res);
        })
        .catch(function (err) {
          console.log("Promise Rejected: ", err);
        });
      break;

    default:
      if (!!error) {
        const err = new Error("slkdjf sdlkfj sldkfj" + error);
        newrelic.noticeError(err, {
          something: "value",
        });
        throw err;
      }
      break;
  }

  return <h1>sdkfj</h1>;
}
