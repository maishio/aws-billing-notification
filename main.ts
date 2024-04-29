import { App } from "cdktf";

import { BillingNotificationStack } from "./src/stacks/billing-notification";

const app = new App();
new BillingNotificationStack(app, "billing-notification");
app.synth();
