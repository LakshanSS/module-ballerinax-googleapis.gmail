// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/mime;
import ballerina/log;

documentation{Represents the GMail Client Connector.
    F{{client}} - HTTP Client used in GMail connector.
}
public type GMailConnector object {
    public {
        http:Client client;
    }

    documentation{List the messages in user's mailbox.
        P{{userId}} - The user's email address. The special value **me** can be used to indicate the authenticated user.
        P{{filter}} - Optional. SearchFilter with optional query parameters to search emails.
        R{{}} -  If successful, returns MessageListPage. Else returns GMailError.
    }
    public function listMessages(string userId, SearchFilter? filter = ()) returns MessageListPage|GMailError;

    documentation{Create the raw base 64 encoded string of the whole message and send it as an email from the user's
        mailbox to its recipient.
        P{{userId}} - The user's email address. The special value **me** can be used to indicate the authenticated user.
        P{{message}} - MessageRequest to send.
        R{{}} - If successful, returns (message id, thread id) of the successfully sent message. Else
                returns GMailError.
    }
    public function sendMessage(string userId, MessageRequest message) returns (string, string)|GMailError;

    documentation{Read the specified mail from users mailbox.
        P{{userId}} - The user's email address. The special value **me** can be used to indicate the authenticated user.
        P{{messageId}} -  The message id of the specified mail to retrieve.
        P{{format}} - Optional. The format to return the messages in.
                  Acceptable values for format for a get message request are defined as following constants
                  in the package:

                    *FORMAT_FULL* : Returns the full email message data with body content parsed in the payload
                                    field;the raw field is not used. (default)

                    *FORMAT_METADATA* : Returns only email message ID, labels, and email headers.

                    *FORMAT_MINIMAL* : Returns only email message ID and labels; does not return the email headers,
                                      body, or payload.

                    *FORMAT_RAW* : Returns the full email message data with body content in the raw field as a
                                   base64url encoded string. (the payload field is not included in the response)
        P{{metadataHeaders}} - Optional. The meta data headers array to include in the reponse when the format is given
                               as *FORMAT_METADATA*.
        R{{}} - If successful, returns Message type of the specified mail. Else returns GMailError.
    }
    public function readMessage(string userId, string messageId, string? format = (), string[]? metadataHeaders = ())
                                                                                        returns Message|GMailError;
    documentation{Gets the specified message attachment from users mailbox.
        P{{userId}} - The user's email address. The special value **me** can be used to indicate the authenticated user.
        P{{messageId}} -  The message id of the specified mail to retrieve.
        P{{attachmentId}} - The id of the attachment to retrieve.
        R{{}} - If successful, returns MessageAttachment type object of the specified attachment. Else returns
                GMailError.
    }
    public function getAttachment(string userId, string messageId, string attachmentId)
                                                                                returns MessageAttachment|GMailError;

    documentation{Move the specified message to the trash.
        P{{userId}} - The user's email address. The special value **me** can be used to indicate the authenticated user.
        P{{messageId}} -  The message id of the specified mail to trash.
        R{{}} - If successful, returns boolean specifying the status of trashing. Else returns GMailError.
    }
    public function trashMail(string userId, string messageId) returns boolean|GMailError;

    documentation{Removes the specified message from the trash.
        P{{userId}} - The user's email address. The special value **me** can be used to indicate the authenticated user.
        P{{messageId}} - The message id of the specified message to untrash.
        R{{}} - If successful, returns boolean specifying the status of untrashing. Else returns GMailError.
    }
    public function untrashMail(string userId, string messageId) returns boolean|GMailError;

    documentation{Immediately and permanently deletes the specified message. This operation cannot be undone.
        P{{userId}} - The user's email address. The special value **me** can be used to indicate the authenticated user.
        P{{messageId}} - The message id of the specified message to delete.
        R{{}} - If successful, returns boolean status of deletion. Else returns GMailError.
    }
    public function deleteMail(string userId, string messageId) returns boolean|GMailError;

    documentation{List the threads in user's mailbox.
        P{{userId}} - The user's email address. The special value **me** can be used to indicate the authenticated user.
        P{{filter}} - Optional. The SearchFilter with optional query parameters to search a thread.
        R{{}} - If successful, returns ThreadListPage type. Else returns GMailError.
    }
    public function listThreads(string userId, SearchFilter? filter = ()) returns ThreadListPage|GMailError;

    documentation{Read the specified mail thread from users mailbox.
        P{{userId}} - The user's email address. The special value **me** can be used to indicate the authenticated user.
        P{{threadId}} -  The thread id of the specified mail to retrieve.
        P{{format}} - Optional. The format to return the messages in.
                  Acceptable values for format for a get thread request are defined as following constants
                  in the package:

                    *FORMAT_FULL* : Returns the full email message data with body content parsed in the payload
                                    field;the raw field is not used. (default)

                    *FORMAT_METADATA* : Returns only email message ID, labels, and email headers.

                    *FORMAT_MINIMAL* : Returns only email message ID and labels; does not return the email headers,
                                      body, or payload.

                    *FORMAT_RAW* : Returns the full email message data with body content in the raw field as a
                                   base64url encoded string. (the payload field is not included in the response)
        P{{metadataHeaders}} - Optional. The meta data headers array to include in the reponse when the format is given
                               as *FORMAT_METADATA*.
        R{{}} - If successful, returns Thread type of the specified mail thread. Else returns GMailError.
    }
    public function readThread(string userId, string threadId, string? format = (), string[]? metadataHeaders = ())
                                                                                           returns Thread|GMailError;

    documentation{Move the specified mail thread to the trash.
        P{{userId}} - The user's email address. The special value **me** can be used to indicate the authenticated user.
        P{{threadId}} -  The thread id of the specified mail thread to trash.
        R{{}} - If successful, returns boolean status of trashing. Else returns GMailError.
    }
    public function trashThread(string userId, string threadId) returns boolean|GMailError;

    documentation{Removes the specified mail thread from the trash.
        P{{userId}} - The user's email address. The special value **me** can be used to indicate the authenticated user.
        P{{threadId}} - The thread id of the specified mail thread to untrash.
        R{{}} - If successful, returns boolean status of untrashing. Else returns GMailError.
    }
    public function untrashThread(string userId, string threadId) returns boolean|GMailError;

    documentation{Immediately and permanently deletes the specified mail thread. This operation cannot be undone.
        P{{userId}} - The user's email address. The special value **me** can be used to indicate the authenticated user.
        P{{threadId}} - The thread id of the specified mail thread to delete.
        R{{}} - If successful, returns boolean status of deletion. Else returns GMailError.
    }
    public function deleteThread(string userId, string threadId) returns boolean|GMailError;

    documentation{Get the current user's GMail Profile.
        P{{userId}} - The user's email address. The special value **me** can be used to indicate the authenticated user.
        R{{}} - If successful, returns UserProfile type. Else returns GMailError.
    }
    public function getUserProfile(string userId) returns UserProfile|GMailError;
};

public function GMailConnector::listMessages(string userId, SearchFilter? filter = ()) returns MessageListPage|
                                                                                                          GMailError {
    endpoint http:Client httpClient = self.client;
    string getListMessagesPath = USER_RESOURCE + userId + MESSAGE_RESOURCE;
    SearchFilter searchFilter = filter ?: {};
    string uriParams;
    //The default value for include spam trash query parameter of the api call is false
    uriParams = check createUrlEncodedRequest(uriParams, INCLUDE_SPAMTRASH, <string>searchFilter.includeSpamTrash);
    //Add optional query parameters
    foreach labelId in searchFilter.labelIds {
        uriParams = check createUrlEncodedRequest(uriParams, LABEL_IDS, labelId);
    }
    uriParams = searchFilter.maxResults != EMPTY_STRING ?
                             check createUrlEncodedRequest(uriParams, MAX_RESULTS, searchFilter.maxResults) : uriParams;
    uriParams = searchFilter.pageToken != EMPTY_STRING ?
                               check createUrlEncodedRequest(uriParams, PAGE_TOKEN, searchFilter.pageToken) : uriParams;
    uriParams = searchFilter.q != EMPTY_STRING ?
                                            check createUrlEncodedRequest(uriParams, QUERY, searchFilter.q) : uriParams;
    getListMessagesPath = getListMessagesPath + uriParams;
    var httpResponse = httpClient->get(getListMessagesPath);
    match handleResponse(httpResponse){
        json jsonlistMsgResponse => return convertJsonMsgListToMessageListPageType(jsonlistMsgResponse);
        GMailError gmailError => return gmailError;
    }
}

public function GMailConnector::sendMessage(string userId, MessageRequest message) returns (string, string)|GMailError {
    endpoint http:Client httpClient = self.client;
    if (message.contentType != TEXT_PLAIN && message.contentType != TEXT_HTML) {
        GMailError gMailError;
        gMailError.message = "Does not support the given content type: " + message.contentType
                                + " for the message with subject: " + message.subject;
        return gMailError;
    }
    if (message.contentType == TEXT_PLAIN && (lengthof message.inlineImagePaths != 0)){
        GMailError gMailError;
        gMailError.message = "Does not support adding inline images to text/plain body of the message with subject: "
                            + message.subject;
        return gMailError;
    }
    string concatRequest = EMPTY_STRING;

    //Set the general headers of the message
    concatRequest += TO + COLON_SYMBOL + message.recipient + NEW_LINE;
    concatRequest += SUBJECT + COLON_SYMBOL + message.subject + NEW_LINE;
    if (message.sender != EMPTY_STRING) {
        concatRequest += FROM + COLON_SYMBOL + message.sender + NEW_LINE;
    }
    if (message.cc != EMPTY_STRING) {
        concatRequest += CC + COLON_SYMBOL + message.cc + NEW_LINE;
    }
    if (message.bcc != EMPTY_STRING) {
        concatRequest += BCC + COLON_SYMBOL + message.bcc + NEW_LINE;
    }
    //------Start of multipart/mixed mime part (parent mime part)------

    //Set the content type header of top level MIME message part
    concatRequest += CONTENT_TYPE + COLON_SYMBOL + mime:MULTIPART_MIXED + SEMICOLON_SYMBOL + BOUNDARY + EQUAL_SYMBOL
                    + APOSTROPHE_SYMBOL + BOUNDARY_STRING + APOSTROPHE_SYMBOL + NEW_LINE;

    concatRequest += NEW_LINE + DASH_SYMBOL + DASH_SYMBOL + BOUNDARY_STRING + NEW_LINE;

    //------Start of multipart/related mime part------
    concatRequest += CONTENT_TYPE + COLON_SYMBOL + mime:MULTIPART_RELATED + SEMICOLON_SYMBOL + WHITE_SPACE + BOUNDARY
                    + EQUAL_SYMBOL + APOSTROPHE_SYMBOL + BOUNDARY_STRING_1 + APOSTROPHE_SYMBOL + NEW_LINE;

    concatRequest += NEW_LINE + DASH_SYMBOL + DASH_SYMBOL + BOUNDARY_STRING_1 + NEW_LINE;

    //------Start of multipart/alternative mime part------
    concatRequest += CONTENT_TYPE + COLON_SYMBOL + mime:MULTIPART_ALTERNATIVE + SEMICOLON_SYMBOL + WHITE_SPACE +
                     BOUNDARY + EQUAL_SYMBOL + APOSTROPHE_SYMBOL + BOUNDARY_STRING_2 + APOSTROPHE_SYMBOL + NEW_LINE;

    //Set the body part : text/plain
    if (message.contentType == TEXT_PLAIN){
        concatRequest += NEW_LINE + DASH_SYMBOL + DASH_SYMBOL + BOUNDARY_STRING_2 + NEW_LINE;
        concatRequest += CONTENT_TYPE + COLON_SYMBOL + TEXT_PLAIN + SEMICOLON_SYMBOL + CHARSET + EQUAL_SYMBOL
                        + APOSTROPHE_SYMBOL + UTF_8 + APOSTROPHE_SYMBOL + NEW_LINE;
        concatRequest += NEW_LINE + message.messageBody + NEW_LINE;
    }

    //Set the body part : text/html
    if (message.contentType == TEXT_HTML) {
        concatRequest += NEW_LINE + DASH_SYMBOL + DASH_SYMBOL + BOUNDARY_STRING_2 + NEW_LINE;
        concatRequest += CONTENT_TYPE + COLON_SYMBOL + TEXT_HTML + SEMICOLON_SYMBOL + CHARSET + EQUAL_SYMBOL
                        + APOSTROPHE_SYMBOL + UTF_8 + APOSTROPHE_SYMBOL + NEW_LINE;
        concatRequest += NEW_LINE + message.messageBody + NEW_LINE + NEW_LINE;
    }

    concatRequest += DASH_SYMBOL + DASH_SYMBOL + BOUNDARY_STRING_2 + DASH_SYMBOL + DASH_SYMBOL;
    //------End of multipart/alternative mime part------

    //Set inline Images as body parts
    foreach inlineImage in message.inlineImagePaths {
        concatRequest += NEW_LINE + DASH_SYMBOL + DASH_SYMBOL + BOUNDARY_STRING_1 + NEW_LINE;
        if (inlineImage.mimeType == EMPTY_STRING){
            GMailError gMailError;
            gMailError.message = "Image content type cannot be empty for image: " + inlineImage.imagePath;
            return gMailError;
        } else if (inlineImage.imagePath == EMPTY_STRING){
            GMailError gMailError;
            gMailError.message = "File path of inline image in message with subject: " + message.subject
                                                                                                    + "cannot be empty";
            return gMailError;
        }
        if (isMimeType(inlineImage.mimeType, IMAGE_ANY)) {
            string encodedFile;
            //Open and encode the image file into base64. Return a GMailError if fails.
            match encodeFile(inlineImage.imagePath) {
                string eFile => encodedFile = eFile;
                GMailError gMailError => return gMailError;
            }
            //Set the inline image headers of the message
            concatRequest += CONTENT_TYPE + COLON_SYMBOL + inlineImage.mimeType + SEMICOLON_SYMBOL + WHITE_SPACE
                            + NAME + EQUAL_SYMBOL + APOSTROPHE_SYMBOL + getFileNameFromPath(inlineImage.imagePath)
                            + APOSTROPHE_SYMBOL + NEW_LINE;
            concatRequest += CONTENT_DISPOSITION + COLON_SYMBOL + INLINE + SEMICOLON_SYMBOL + WHITE_SPACE
                            + FILE_NAME + EQUAL_SYMBOL + APOSTROPHE_SYMBOL + getFileNameFromPath(inlineImage.imagePath)
                            + APOSTROPHE_SYMBOL + NEW_LINE;
            concatRequest += CONTENT_TRANSFER_ENCODING + COLON_SYMBOL + BASE_64 + NEW_LINE;
            concatRequest += CONTENT_ID + COLON_SYMBOL + LESS_THAN_SYMBOL + INLINE_IMAGE_CONTENT_ID_PREFIX
                            + getFileNameFromPath(inlineImage.imagePath) + GREATER_THAN_SYMBOL + NEW_LINE;
            concatRequest += NEW_LINE + encodedFile + NEW_LINE + NEW_LINE;
        } else {
            //Return an error if an un supported content type other than image/* is passed
            GMailError gMailError;
            gMailError.message = "Unsupported content type:" + inlineImage.mimeType + "for the image:"
                + inlineImage.imagePath;
            return gMailError;
        }
    }
    if (lengthof (message.inlineImagePaths) != 0) {
        concatRequest += DASH_SYMBOL + DASH_SYMBOL + BOUNDARY_STRING_1 + DASH_SYMBOL + DASH_SYMBOL + NEW_LINE;
    }
    //------End of multipart/related mime part------

    //Set attachments
    foreach attachment in message.attachmentPaths {
        concatRequest += NEW_LINE + DASH_SYMBOL + DASH_SYMBOL + BOUNDARY_STRING + NEW_LINE;
        if (attachment.mimeType == EMPTY_STRING){
            GMailError gMailError;
            gMailError.message = "Content type of attachment:" + attachment.attachmentPath + "cannot be empty";
            return gMailError;
        } else if (attachment.attachmentPath == EMPTY_STRING){
            GMailError gMailError;
            gMailError.message = "File path of attachment in message with subject: " + message.subject
                + "cannot be empty";
            return gMailError;
        }
        string encodedFile;
        //Open and encode the file into base64. Return a GMailError if fails.
        match encodeFile(attachment.attachmentPath) {
            string eFile => encodedFile = eFile;
            GMailError gMailError => return gMailError;
        }
        concatRequest += CONTENT_TYPE + COLON_SYMBOL + attachment.mimeType + SEMICOLON_SYMBOL + WHITE_SPACE + NAME
                        + EQUAL_SYMBOL + APOSTROPHE_SYMBOL + getFileNameFromPath(attachment.attachmentPath)
                        + APOSTROPHE_SYMBOL + NEW_LINE;
        concatRequest += CONTENT_DISPOSITION + COLON_SYMBOL + ATTACHMENT + SEMICOLON_SYMBOL + WHITE_SPACE + FILE_NAME
                        + EQUAL_SYMBOL + APOSTROPHE_SYMBOL + getFileNameFromPath(attachment.attachmentPath)
                        + APOSTROPHE_SYMBOL + NEW_LINE;
        concatRequest += CONTENT_TRANSFER_ENCODING + COLON_SYMBOL + BASE_64 + NEW_LINE;
        concatRequest += NEW_LINE + encodedFile + NEW_LINE + NEW_LINE;
    }
    if (lengthof (message.attachmentPaths) != 0)   {
        concatRequest += DASH_SYMBOL + DASH_SYMBOL + BOUNDARY_STRING + DASH_SYMBOL + DASH_SYMBOL;
    }
    //------End of multipart/mixed mime part------

    string encodedRequest;
    match (concatRequest.base64Encode()){
        string encodeString => encodedRequest = encodeString;
        error encodeError => {
            GMailError gMailError;
            gMailError.message = "Error occurred during base64 encoding of the mime message request : " + concatRequest;
            gMailError.cause = encodeError;
            return gMailError;
        }
    }
    encodedRequest = encodedRequest.replace(PLUS_SYMBOL, DASH_SYMBOL).replace(FORWARD_SLASH_SYMBOL, UNDERSCORE_SYMBOL);
    http:Request request = new;
    json jsonPayload = {raw:encodedRequest};
    string sendMessagePath = USER_RESOURCE + userId + MESSAGE_SEND_RESOURCE;
    request.setJsonPayload(jsonPayload);
    var httpResponse = httpClient->post(sendMessagePath, request = request);
    match handleResponse(httpResponse){
        json jsonSendMessageResponse => {
            return (jsonSendMessageResponse.id.toString(), jsonSendMessageResponse.threadId.toString());
        }
        GMailError gMailError => return gMailError;
    }
}

public function GMailConnector::readMessage(string userId, string messageId, string? format = (),
                                         string[]? metadataHeaders = ()) returns Message|GMailError {
    endpoint http:Client httpClient = self.client;
    string uriParams;
    string messageFormat = format ?: FORMAT_FULL;
    string[] messageMetadataHeaders = metadataHeaders ?: [];
    string readMessagePath = USER_RESOURCE + userId + MESSAGE_RESOURCE + FORWARD_SLASH_SYMBOL + messageId;
    //Add format query parameter
    uriParams = check createUrlEncodedRequest(uriParams, FORMAT, messageFormat);
    //Add the optional meta data headers as query parameters
    foreach metaDataHeader in messageMetadataHeaders {
        uriParams = check createUrlEncodedRequest(uriParams, METADATA_HEADERS, metaDataHeader);
    }
    readMessagePath = readMessagePath + uriParams;
    var httpResponse = httpClient->get(readMessagePath);
    match handleResponse(httpResponse){
        json jsonreadMessageResponse => {
            //Transform the json mail response from GMail API to Message type
            match (convertJsonMailToMessage(jsonreadMessageResponse)){
                Message message => return message;
                GMailError gMailError => return gMailError;
            }
        }
        GMailError gMailError => return gMailError;
    }
}

public function GMailConnector::getAttachment(string userId, string messageId, string attachmentId)
                                                                            returns MessageAttachment|GMailError {
    endpoint http:Client httpClient = self.client;
    string getAttachmentPath = USER_RESOURCE + userId + MESSAGE_RESOURCE + FORWARD_SLASH_SYMBOL + messageId
                               + ATTACHMENT_RESOURCE + attachmentId;
    var httpResponse = httpClient->get(getAttachmentPath);
    match handleResponse(httpResponse){
        json jsonAttachment => {
            //Transform the json mail response from GMail API to MessageAttachment type
            return convertJsonMessageBodyToMsgAttachment(jsonAttachment);
        }
        GMailError gMailError => return gMailError;
    }
}

public function GMailConnector::trashMail(string userId, string messageId) returns boolean|GMailError {
    endpoint http:Client httpClient = self.client;
    string trashMailPath = USER_RESOURCE + userId + MESSAGE_RESOURCE + FORWARD_SLASH_SYMBOL + messageId
                           + FORWARD_SLASH_SYMBOL + TRASH;
    var httpResponse = httpClient->post(trashMailPath);
    match handleResponse(httpResponse){
        json jsonTrashMailResponse => {
            return true;
        }
        GMailError gMailError => return gMailError;
    }
}

public function GMailConnector::untrashMail(string userId, string messageId) returns boolean|GMailError {
    endpoint http:Client httpClient = self.client;
    string untrashMailPath = USER_RESOURCE + userId + MESSAGE_RESOURCE + FORWARD_SLASH_SYMBOL + messageId
                            + FORWARD_SLASH_SYMBOL + UNTRASH;
    var httpResponse = httpClient->post(untrashMailPath);
    match handleResponse(httpResponse){
        json jsonUntrashMailReponse => {
            return true;
        }
        GMailError gMailError => return gMailError;
    }
}

public function GMailConnector::deleteMail(string userId, string messageId) returns boolean|GMailError {
    endpoint http:Client httpClient = self.client;
    string deleteMailPath = USER_RESOURCE + userId + MESSAGE_RESOURCE + FORWARD_SLASH_SYMBOL + messageId;
    var httpResponse = httpClient->delete(deleteMailPath);
    match handleResponse(httpResponse){
        json jsonDeleteMailResponse => {
            return true;
        }
        GMailError gMailError => return gMailError;
    }
}

public function GMailConnector::listThreads(string userId, SearchFilter? filter = ()) returns ThreadListPage|GMailError {
    endpoint http:Client httpClient = self.client;
    string getListThreadPath = USER_RESOURCE + userId + THREAD_RESOURCE;
    string uriParams;
    SearchFilter searchFilter = filter ?: {};
    //The default value for include spam trash query parameter of the api call is false
    uriParams = check createUrlEncodedRequest(uriParams, INCLUDE_SPAMTRASH, <string>searchFilter.includeSpamTrash);
    //Add optional query parameters
    foreach labelId in searchFilter.labelIds {
        uriParams = check createUrlEncodedRequest(uriParams, LABEL_IDS, labelId);
    }
    uriParams = searchFilter.maxResults != EMPTY_STRING ?
                            check createUrlEncodedRequest(uriParams, MAX_RESULTS, searchFilter.maxResults) : uriParams;
    uriParams = searchFilter.pageToken != EMPTY_STRING ?
                            check createUrlEncodedRequest(uriParams, PAGE_TOKEN, searchFilter.pageToken) : uriParams;
    uriParams = searchFilter.q != EMPTY_STRING ?
                            check createUrlEncodedRequest(uriParams, QUERY, searchFilter.q) : uriParams;
    getListThreadPath = getListThreadPath + uriParams;
    var httpResponse = httpClient->get(getListThreadPath);
    match handleResponse(httpResponse) {
        json jsonListThreadResponse => return convertJsonThreadListToThreadListPageType(jsonListThreadResponse);
        GMailError gMailError => return gMailError;
    }
}

public function GMailConnector::readThread(string userId, string threadId, string? format = (),
                                           string[]? metadataHeaders = ()) returns Thread|GMailError {
    endpoint http:Client httpClient = self.client;
    string uriParams;
    string messageFormat = format ?: FORMAT_FULL;
    string[] messageMetadataHeaders = metadataHeaders ?: [];
    string readThreadPath = USER_RESOURCE + userId + THREAD_RESOURCE + FORWARD_SLASH_SYMBOL + threadId;
    //Add format optional query parameter
    uriParams = check createUrlEncodedRequest(uriParams, FORMAT, messageFormat);
    //Add the optional meta data headers as query parameters
    foreach metaDataHeader in messageMetadataHeaders {
        uriParams = check createUrlEncodedRequest(uriParams, METADATA_HEADERS, metaDataHeader);
    }
    readThreadPath += uriParams;
    var httpResponse = httpClient->get(readThreadPath);
    match handleResponse(httpResponse) {
        json jsonReadThreadResponse => {
            //Transform the json mail response from GMail API to Thread type
            match convertJsonThreadToThreadType(jsonReadThreadResponse){
                Thread thread => return thread;
                GMailError gMailError => return gMailError;
            }
        }
        GMailError gMailError => return gMailError;
    }
}

public function GMailConnector::trashThread(string userId, string threadId) returns boolean|GMailError {
    endpoint http:Client httpClient = self.client;
    string trashThreadPath = USER_RESOURCE + userId + THREAD_RESOURCE + FORWARD_SLASH_SYMBOL + threadId
                            + FORWARD_SLASH_SYMBOL + TRASH;
    var httpResponse = httpClient->post(trashThreadPath);
    match handleResponse(httpResponse){
        json jsonTrashThreadResponse => return true;
        GMailError gMailError => return gMailError;
    }
}

public function GMailConnector::untrashThread(string userId, string threadId) returns boolean|GMailError {
    endpoint http:Client httpClient = self.client;
    string untrashThreadPath = USER_RESOURCE + userId + THREAD_RESOURCE + FORWARD_SLASH_SYMBOL + threadId
                                + FORWARD_SLASH_SYMBOL + UNTRASH;
    var httpResponse = httpClient->post(untrashThreadPath);
    match handleResponse(httpResponse) {
        json jsonUntrashThreadResponse => return true;
        GMailError gMailError => return gMailError;
    }
}

public function GMailConnector::deleteThread(string userId, string threadId) returns boolean|GMailError {
    endpoint http:Client httpClient = self.client;
    string deleteThreadPath = USER_RESOURCE + userId + THREAD_RESOURCE + FORWARD_SLASH_SYMBOL + threadId;
    var httpResponse = httpClient->delete(deleteThreadPath);
    match handleResponse(httpResponse){
        json jsonDeleteThreadResponse => return true;
        GMailError gMailError => return gMailError;
    }
}

public function GMailConnector::getUserProfile(string userId) returns UserProfile|GMailError {
    endpoint http:Client httpClient = self.client;
    string getProfilePath = USER_RESOURCE + userId + PROFILE_RESOURCE;
    var httpResponse = httpClient->get(getProfilePath);
    match handleResponse(httpResponse){
        json jsonProfileResponse => {
            //Transform the json profile response from GMail API to User Profile type
            return convertJsonProfileToUserProfileType(jsonProfileResponse);
        }
        GMailError gMailError => return gMailError;
    }
}
