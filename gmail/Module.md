Connects to Gmail from Ballerina.

## Module Overview

Ballerina Gmail Connector provides the capability to send, read and delete emails through the Gmail REST API. It also provides the ability to read, trash, untrash and delete threads, ability to get the Gmail profile and mailbox history, etc. The connector handles OAuth 2.0 authentication.

## Configurations

Instantiate the connector by giving authentication details in the Gmail client config, which has built-in support for OAuth 2.0. Gmail uses OAuth 2.0 to authenticate and authorize requests. The Gmail connector can be minimally instantiated in the Gmail client config using the Access Token or by using the Client ID, Client Secret and Refresh Token.

**Obtaining Tokens to Run the Sample**

1. Visit [Google API Console](https://console.developers.google.com), click **Create Project**, and follow the wizard to create a new project.
2. Go to **Credentials -> OAuth Consent Screen**, enter a product name to be shown to users, and click **Save**.
3. On the **Credentials** tab, click **Create Credentials** and select **OAuth Client ID**.
4. Select an application type, enter a name for the application, and specify a redirect URI (enter https://developers.google.com/oauthplayground if you want to use
[OAuth 2.0 Playground](https://developers.google.com/oauthplayground) to receive the Authorization Code and obtain the
Access Token and Refresh Token).
5. Click **Create**. Your Client ID and Client Secret will appear.
6. In a separate browser window or tab, visit [OAuth 2.0 Playground](https://developers.google.com/oauthplayground). Click on the `OAuth 2.0 Configuration`
 icon in the top right corner and click on `Use your own OAuth credentials` and provide your `OAuth Client ID` and `OAuth Client Secret`.
7. Select the required Gmail API scopes from the list of API's, and then click **Authorize APIs**.
8. When you receive your authorization code, click **Exchange authorization code for tokens** to obtain the refresh token and access token.

You can now enter the credentials in the Gmail client config.

```ballerina
gmail:GmailConfiguration gmailConfig = {
    oauthClientConfig: {
        refreshUrl: gmail:REFRESH_URL,
        refreshToken: <REFRESH_TOKEN>,
        clientId: <CLIENT_ID>,
        clientSecret: <CLIENT_SECRET>
    }
};

gmail:Client gmailClient = new (gmailConfig);
```

## Compatibility

| Ballerina Language Versions  | Gmail API Version |
|:----------------------------:|:-----------------:|
|  Swan Lake Alpha 5           |   v1              |

## Sample

```ballerina
import ballerina/io;
import ballerinax/googleapis.gmail as gmail;

gmail:GmailConfiguration gmailConfig = {
    oauthClientConfig: {
        refreshUrl: gmail:REFRESH_URL,
        refreshToken: <REFRESH_TOKEN>,
        clientId: <CLIENT_ID>,
        clientSecret: <CLIENT_SECRET>
    }
};

gmail:Client gmailClient = new (gmailConfig);
public function main(string... args) {
    gmail:MessageRequest messageRequest = {
    recipient : "aa@gmail.com",
    sender : "bb@gmail.com",
    cc : "cc@gmail.com",
    subject : "Email-Subject",
    messageBody : "Email Message Body Text",
    // Set the content type of the mail as TEXT_PLAIN or TEXT_HTML.
    contentType : gmail:TEXT_PLAIN
    };

    // Send the message.
    var sendMessageResponse = gmailClient->sendMessage(messageRequest);
    if (sendMessageResponse is gmail:Message) {
        // If successful, print the message ID and thread ID.
        log:printInfo("Sent Message ID: "+ sendMessageResponse.id);
        log:printInfo("Sent Thread ID: "+ sendMessageResponse.threadId);
    } else {
        // If unsuccessful, print the error returned.
        io:println("Error: ", sendMessageResponse);
    }
}
```
