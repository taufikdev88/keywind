<#import "template.ftl" as layout>
<#import "components/atoms/alert.ftl" as alert>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/checkbox.ftl" as checkbox>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>
<#import "components/atoms/link.ftl" as link>
<#import "components/atoms/tabs-content.ftl" as tabsContent>
<#import "components/atoms/tabs-content-group.ftl" as tabsContentGroup>
<#import "components/atoms/tabs-header.ftl" as tabsHeader>
<#import "components/atoms/tabs-header-group.ftl" as tabsHeaderGroup>
<#import "components/molecules/identity-provider.ftl" as identityProvider>
<#import "features/labels/username.ftl" as usernameLabel>

<#assign usernameLabel><@usernameLabel.kw /></#assign>
<#if !usernameHidden?? && supportPhone??>
  <#assign scriptSrc>dist/phoneNumberVerificationCode.js</#assign>
</#if>

<@layout.registrationLayout
  script=scriptSrc
  displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??
  displayMessage=!messagesPerField.existsError('username','password','code','phoneNumber'); section>

  <#--  HEADER SECTION  -->
  <#if section="header">
    ${msg("loginAccountTitle")}
  <#--  FORM SECTION  -->
  <#elseif section="form">
    <#if realm.password>
      <@form.kw action=url.loginAction method="post" onsubmit="login.disabled = true; return true;">
        <#--  show tab  -->
        <div
          <#if !usernameHidden?? && supportPhone??>
            x-data="phoneVerification"
            data-default-send-button-text="${msg('sendVerificationCode')}"
            data-default-required-phone-number-text="${msg('requiredPhoneNumber')}"
            data-realm-name="${realm.name}"
            data-token-code-type="authentication-code"
          </#if>>

          <#if !usernameHidden?? && supportPhone??>
            <#--  error message  -->
            <div x-show="errorMessage">
              <#--  alert for internal server error  -->
              <@alert.kw color="error">
                <span x-text="errorMessage"></span>
              </@alert.kw>
            </div>
            <#--  tabs header  -->
            <@tabsHeaderGroup.kw>
              <@tabsHeader.kw name="password" selected="!phoneActivated" @click="phoneActivated = false">
                ${msg("loginByPassword")}
              </@tabsHeader.kw>
              <@tabsHeader.kw name="phone" selected="phoneActivated" @click="phoneActivated = true">
                ${msg("loginByPhone")}
              </@tabsHeader.kw>
            </@tabsHeaderGroup.kw>
          </#if>
          <#--  tabs content  -->
          <@tabsContentGroup.kw>
            <@tabsContent.kw name="password" hidden=!usernameHidden?? && supportPhone??>
              <#if !usernameHidden?? && supportPhone??>
                <template x-if="!phoneActivated">
              </#if>

              <div>
                <#--  form username  -->
                <#if !usernameHidden??>
                  <@input.kw
                    autocomplete=realm.loginWithEmailAllowed?string("email", "username" )
                    autofocus=true
                    disabled=usernameEditDisabled??
                    invalid=messagesPerField.existsError("username", "password" )
                    label=usernameLabel
                    message=kcSanitize(messagesPerField.getFirstError("username", "password" ))
                    name="username"
                    type="text"
                    value=(login.username)!''
                  />
                </#if>
                <#--  form password  -->
                <@input.kw
                  invalid=messagesPerField.existsError("username", "password" )
                  label=msg("password")
                  name="password"
                  type="password"
                />

                <#--  form remember me  -->
                <#if realm.rememberMe && !usernameEditDisabled?? || realm.resetPasswordAllowed>
                  <div class="flex items-center justify-between">
                    <#if realm.rememberMe && !usernameEditDisabled??>
                      <@checkbox.kw checked=login.rememberMe?? label=msg("rememberMe") name="rememberMe" />
                    </#if>
                    <#if realm.resetPasswordAllowed>
                      <@link.kw color="primary" href=url.loginResetCredentialsUrl size="small">${msg("doForgotPassword")}</@link.kw>
                    </#if>
                  </div>
                </#if>
              </div>

              <#if !usernameHidden?? && supportPhone??>
                </template>
              </#if>
            </@tabsContent.kw>
            <#if !usernameHidden?? && supportPhone??>
              <@tabsContent.kw name="phone">
                <template x-if="phoneActivated">
                  <div>
                    <#--  input phone number  -->
                    <@input.kw
                      <#--  class="phone"  -->
                      tabindex=0
                      type="text"
                      id="phoneNumber"
                      label=msg("phoneNumber")
                      message=kcSanitize(messagesPerField.getFirstError('phoneNumber','code'))?no_esc
                      name="phoneNumber"
                      autofocus=true
                      model="phoneNumber"
                      disabled=usernameEditDisabled??
                      invalid=messagesPerField.existsError('code','phoneNumber')
                    />
                    <#--  input code with send button -->
                    <div class="flex flex-row">
                      <div class="basis-3/4 mr-4">
                        <@input.kw
                          tabindex=0
                          type="text"
                          id="code"
                          label=msg("verificationCode")
                          name="code"
                          invalid=messagesPerField.existsError('code','phoneNumber')
                          autocomplete="one-time-code"
                        />
                      </div>
                      <div class="basis-1/4">
                        <@input.kw
                          tabindex=0
                          class="btn block mt-1 py-2 bg-primary-600 hover:bg-primary-700 w-full text-white rounded sm:text-sm"
                          type="button"
                          model="sendButtonText"
                          click="sendVerificationCode"
                          disabled_function="sendButtonText !== initSendButtonText"
                        />
                      </div>
                    </div>
                  </div>
                </template>
              </@tabsContent.kw>
              <input type="hidden" id="phoneActivated" name="phoneActivated" x-model="phoneActivated">
            </#if>
          </@tabsContentGroup.kw>
        </div>

        <input name="credentialId" type="hidden" value="<#if auth.selectedCredential?has_content>${auth.selectedCredential}</#if>">
        <@buttonGroup.kw>
          <@button.kw color="primary" name="login" type="submit"> ${msg("doLogIn")} </@button.kw>
        </@buttonGroup.kw>
      </@form.kw>
    </#if>
  <#--  INFO SECTION  -->
  <#elseif section="info">
    <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
      <div class="text-center">
        ${msg("noAccount")}
        <@link.kw color="primary" href=url.registrationUrl>${msg("doRegister")}</@link.kw>
      </div>
    </#if>
  <#--  SOCIAL PROVIDERS SECTION  -->
  <#elseif section="socialProviders">
    <#if realm.password && social.providers??>
      <@identityProvider.kw providers=social.providers />
    </#if>
  </#if>
</@layout.registrationLayout>
