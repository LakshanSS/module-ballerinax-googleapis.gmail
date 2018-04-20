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

documentation{
    Represents GMail endpoint.

    E{{}}
    F{{gMailConfig}} - GMail endpoint configuration
    F{{gMailConnector}} - GMail connector
}
public type Client object {
    public {
        GMailConfiguration gMailConfig = {};
        GMailConnector gMailConnector = new;
    }

    documentation{
        Gets called when the gMail endpoint is beign initialized.

        P{{gMailConfig}} - GMail connector configuration
    }
    public function init(GMailConfiguration gMailConfig) {
        gMailConfig.clientConfig.url = BASE_URL;
        match gMailConfig.clientConfig.auth {
            () => {}
            http:AuthConfig authConfig => {
                authConfig.refreshUrl = REFRESH_TOKEN_EP;
                authConfig.scheme = OAUTH;
            }
        }
        self.gMailConnector.client.init(gMailConfig.clientConfig);
    }

    documentation{
        Returns the connector that client code uses.
    }
    public function getCallerActions() returns GMailConnector {
        return self.gMailConnector;
    }
};

documentation{
    Represents the GMail client endpoint configuration.

    F{{clientConfig}} - The HTTP Client endpoint configuration.
}
public type GMailConfiguration {
    http:ClientEndpointConfig clientConfig;
};