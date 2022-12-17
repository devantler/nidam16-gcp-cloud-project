const constants = {
    serverBaseURL_development: 'http://localhost:3000',
    serverBaseURL_production: getServerBaseURL()
}

function getServerBaseURL() {
    var region = window.location.href.split("-u7hplahhma")[0].split("frontend-")[1];
    console.log(region);
    var fullUrl = ""
    switch (region) {
        case "us-central1":
            fullUrl = "https://backend-us-central1-u7hplahhma-uc.a.run.app";
            break;
        case "europe-west1":
            fullUrl = "https://backend-europe-west1-u7hplahhma-ew.a.run.app";
            break;
        case "europe-north1":
            fullUrl = "https://backend-europe-north1-u7hplahhma-lz.a.run.app";
            break;
        case "asia-east1":
            fullUrl = "https://backend-asia-east1-u7hplahhma-de.a.run.app";
            break;
        default:
            throw new Error("Region not found");
    }
    return fullUrl;
}

export default constants;
