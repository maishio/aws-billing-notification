import { App } from "cdktf"

import { LambdaStack } from "./src/stacks/lambda-stack"

const app = new App()
new LambdaStack(app, "lambda-stack")
app.synth()
