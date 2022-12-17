import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';

export const app = express()

app.use(bodyParser.json({ limit: "50mb" }));
app.use(bodyParser.urlencoded({ limit: "50mb", extended: true, parameterLimit: 50000 }));

let corsOptions;

if (process.env.NODE_ENV === 'development') {
  corsOptions = {
    origin: "*"
  }
} else {
  corsOptions = {
    origin: [
      "https://backend-us-central1-u7hplahhma-uc.a.run.app",
      "https://backend-europe-west1-u7hplahhma-ew.a.run.app",
      "https://backend-europe-north1-u7hplahhma-lz.a.run.app",
      "https://backend-asia-east1-u7hplahhma-de.a.run.app"
    ]
  }
}

app.use(cors(corsOptions));
