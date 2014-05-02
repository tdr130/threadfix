<script type="text/ng-template" id="newApplicationModal.html">
    <div class="modal-header">
        <h4 id="myModalLabel">
            New Application
        </h4>
    </div>

    <form id="newApplicationForm" name='form'>
        <div class="modal-body input-group">

            <table class="modal-form-table">
                <tr class="left-align">
                    <td>Name</td>
                    <td>
                        <input id="applicationNameInput" focus-on="focusInput" type='text' name='name' ng-model="object.name" required/>
                        <span id="applicationNameInputRequiredError" class="errors" ng-show="form.name.$dirty && form.name.$error.required">Name is required.</span>
                        <span id="applicationNameInputNameError" class="errors" ng-show="object.name_error"> {{ object.name_error }}</span>
                    </td>
                </tr>
                <tr class="left-align">
                    <td>URL</td>
                    <td>
                        <input id="applicationUrlInput" type='url' name='url' ng-model="object.url" ng-maxlength="255"/>
                        <span id="applicationUrlInputLengthError" class="errors" ng-show="form.url.$dirty && form.url.$error.maxlength">Maximum length is 255.</span>
                        <span id="applicationUrlInputInvalidUrlError" class="errors" ng-show="form.url.$dirty && form.url.$error.url">URL is invalid.</span>
                    </td>
                </tr>
                <tr class="left-align">
                    <td>Unique ID</td>
                    <td>
                        <input name="uniqueId" type='text' style="margin-bottom:0px;"
                               ng-model="object.uniqueId"
                               id="uniqueIdInput" size="50" maxlength="255"/>
                        <span id="uniqueIdLengthError" class="errors" ng-show="form.uniqueId.$dirty && form.uniqueId.$error.maxlength">Maximum length is 255.</span>
                    </td>
                </tr>
                <tr class="left-align">
                    <td>Team</td>
                    <td id="teamNameLabel">{{ object.team.name }}</td>
                </tr>
                <tr class="left-align">
                    <td>Criticality</td>
                    <td>
                        <select name="applicationCriticality.id"
                                style="margin-bottom:0px;"
                                ng-model="object.applicationCriticality.id"
                                id="criticalityIdSelect">

                            <c:forEach items="${applicationCriticalityList}" var="applicationCriticality">
                                <option value="<c:out value='${applicationCriticality.id}'/>">
                                    <c:out value='${applicationCriticality.name}'/>
                                </option>
                            </c:forEach>
                        </select>
                        <span class="errors" ng-show="object.applicationCriticality_id_error"> {{ object.applicationCriticality_id_error }}</span>
                    </td>
                </tr>
                <tr>
                    <td class="right-align">Application Type</td>
                    <td class="left-align" >
                        <select name="frameworkType" ng-model="object.frameworkType" id="frameworkTypeSelect{{ object.team.id }}">
                            <c:forEach items="${applicationTypes}" var="type">
                                <option value="<c:out value='${type.displayName}'/>">
                                    <c:out value='${type.displayName}'/>
                                </option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <a class="pointer" ng-click="sourceCodeDisplay = !sourceCodeDisplay">Source Code Information</a>
                    </td>
                </tr>
                <tr ng-show="sourceCodeDisplay">
                    <td class="right-align">Source Code URL</td>
                    <td class="left-align" >
                        <input name="repositoryUrl"
                                type='url' id="repositoryUrlInput"
                                maxlength="255" ng-model="object.repositoryUrl"/>
                        <span id="sourceUrlLengthError" class="errors" ng-show="form.repositoryUrl.$dirty && form.repositoryUrl.$error.maxlength">Maximum length is 255.</span>
                        <span id="sourceUrlValidError" class="errors" ng-show="form.repositoryUrl.$dirty && form.repositoryUrl.$error.url">URL is invalid.</span>
                    </td>
                </tr>
                <tr ng-show="sourceCodeDisplay">
                    <td>Source Code Revision</td>
                    <td>
                        <input type="text" id="repositoryBranch" ng-model="object.repositoryBranch" maxlength="250" name="repositoryBranch"/>
                        <span id="sourceRevisionLengthError" class="errors" ng-show="form.repositoryBranch.$dirty && form.repositoryBranch.$error.maxlength">Maximum length is 250.</span>
                    </td>
                </tr>
                <tr ng-show="sourceCodeDisplay">
                    <td>Source Code User Name</td>
                    <td>
                        <input type="text" id="repositoryUsername" ng-model="object.repositoryUserName" maxlength="250" name="repositoryUserName"/>
                        <span id="sourceUserNameLengthError" class="errors" ng-show="form.repositoryUserName.$dirty && form.repositoryUserName.$error.maxlength">Maximum length is 250.</span>
                    </td>
                </tr>
                <tr ng-show="sourceCodeDisplay">
                    <td>Source Code Password</td>
                    <td>
                        <input type="password" id="repositoryPassword" ng-model="object.repositoryPassword" showPassword="true" maxlength="250" name="repositoryPassword"/>
                        <span id="sourcePasswordLengthError" class="errors" ng-show="form.repositoryPassword.$dirty && form.repositoryPassword.$error.maxlength">Maximum length is 250.</span>
                    </td>
                </tr>
                <tr ng-show="sourceCodeDisplay">
                    <td class="right-align">Source Code Folder</td>
                    <td class="left-align" >
                        <input name="repositoryFolder"
                                type='text' id="repositoryFolderInput"
                                maxlength="250" ng-model="object.repositoryFolder"/>
                        <span id="sourceFolderLengthError" class="errors" ng-show="form.repositoryFolder.$dirty && form.repositoryFolder.$error.maxlength">Maximum length is 250.</span>
                        <span id="sourceFolderOtherError" class="errors" ng-show="object.repositoryFolder_error"> {{ object.repositoryFolder_error }}</span>
                    </td>
                </tr>
            </table>

        </div>
        <%@ include file="/WEB-INF/views/modal/footer.jspf" %>
    </form>
</script>
