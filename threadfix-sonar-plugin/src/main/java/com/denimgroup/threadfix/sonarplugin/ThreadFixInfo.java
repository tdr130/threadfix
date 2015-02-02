////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2009-2015 Denim Group, Ltd.
//
//     The contents of this file are subject to the Mozilla Public License
//     Version 2.0 (the "License"); you may not use this file except in
//     compliance with the License. You may obtain a copy of the License at
//     http://www.mozilla.org/MPL/
//
//     Software distributed under the License is distributed on an "AS IS"
//     basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
//     License for the specific language governing rights and limitations
//     under the License.
//
//     The Original Code is ThreadFix.
//
//     The Initial Developer of the Original Code is Denim Group, Ltd.
//     Portions created by Denim Group, Ltd. are Copyright (C)
//     Denim Group, Ltd. All Rights Reserved.
//
//     Contributor(s): Denim Group, Ltd.
//
////////////////////////////////////////////////////////////////////////
package com.denimgroup.threadfix.sonarplugin;

import com.denimgroup.threadfix.data.entities.Application;
import com.denimgroup.threadfix.remote.PluginClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static com.denimgroup.threadfix.CollectionUtils.list;

/**
 * Created by mcollins on 1/28/15.
 */
public class ThreadFixInfo {

    private static final Logger LOG = LoggerFactory.getLogger(ThreadFixInfo.class);

    private String url, apiKey, applicationName, applicationId;

    private List<String> errors = list();

    public ThreadFixInfo(Map<String, String> properties) {
        this.url = properties.get("threadfix.url");
        this.apiKey = properties.get("threadfix.apiKey");
        this.applicationName = properties.get("threadfix.applicationName");
        this.applicationId = properties.get("threadfix.applicationId");

        this.errors = getErrors();

        if (this.errors.isEmpty() && this.applicationId == null) {
            this.applicationId = getApplicationId(this);
        }
    }

    private String getApplicationId(ThreadFixInfo info) {
        PluginClient client = new PluginClient(info.getUrl(), info.getApiKey());

        Application.Info[] threadFixApplications = client.getThreadFixApplications();

        LOG.debug("Looking for ThreadFix applications.");

        String returnId = null;

        for (Application.Info threadFixApplication : threadFixApplications) {
            String applicationName = threadFixApplication.applicationName;

            String id = threadFixApplication.getApplicationId();

            LOG.debug("Application name " + applicationName + " has ID " + id);

            if (info.getApplicationName().equals(threadFixApplication.getApplicationName())) {
                LOG.debug("Found match: " + info.getApplicationName() + ", id=" + id);
                returnId = id;
            }
        }

        if (threadFixApplications.length == 0) {
            LOG.error("No ThreadFix applications found, please set one up in ThreadFix and try again.");
        }

        return returnId;
    }

    public boolean valid() {
        return getErrors().isEmpty();
    }

    public List<String> getErrors() {
        List<String> errors = new ArrayList<>();

        if (url == null) {
            errors.add("ThreadFix URL is null, please set the property threadfix.url");
        }

        if (apiKey == null) {
            errors.add("ThreadFix API Key is null, please set the property threadfix.apiKey");
        }

        if (applicationName == null && applicationId == null) {
            errors.add("ThreadFix Application name and ID are null, please set the property threadfix.applicationName or the property threadfix.applicationId");
        }

        return errors;
    }

    public String getUrl() {
        return url;
    }

    public String getApiKey() {
        return apiKey;
    }

    public String getApplicationName() {
        return applicationName;
    }

    public String getApplicationId() {
        return applicationId;
    }
}
