import { redirect } from "next/navigation";
import newrelic from "newrelic";

// @ts-ignore
export default async function ErrorPage({ searchParams }) {
  const { q } = await searchParams;

  if (q === "type-error") {
    throw new TypeError("Type error occurred");
  }

  if (q === "custom") {
    newrelic.noticeError(new Error("sdlkfj errror"), {
      custom: "value",
    });
    redirect("https://google.com");
  }

  if (!!q) {
    const err = new Error("slkdjf sdlkfj sldkfj" + q);
    newrelic.noticeError(err, {
      something: "value",
    });
    throw err;
  }

  return <h1>sdkfj</h1>;
}
